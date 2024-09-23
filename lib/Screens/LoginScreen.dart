import 'package:groupchat/Screens/ChatScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../Constants.dart';
import '../Widgets/CustomButton.dart';
import '../Widgets/CustomTxtField.dart';
import 'Registration.dart';

class LoginScreen extends StatefulWidget {
  static String id = "login";

  GlobalKey formkey = GlobalKey();

  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formkey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool isloading = false;

  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
        backgroundColor: Color(0xffEDE7E7),
        body: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 100.0, horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Login To your Account",
                    style: TextStyle(
                        color: Color(0xff353D4A),
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      buildContainer(Color(0xff13161B)),
                      SizedBox(
                        width: 1,
                      ),
                      Expanded(
                        child: CustomButton(
                          txt: "Continue with Google",
                          ontap: () async {
                            signInWithGoogle();
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          indent: 12,
                          endIndent: 12,
                        ),
                      ),
                      Text("OR",
                          style: TextStyle(
                            fontSize: 18,
                          )),
                      Expanded(
                        child: Divider(
                          indent: 12,
                          endIndent: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  // Row(
                  //   children: [
                  //     buildContainer(Color(0xff353D4A)),
                  //     SizedBox(width: 1,),
                  //     Expanded(child: CustomTextField(onchanged: (String val){}, txt: "Full Name", obscured: false))
                  //   ]
                  //
                  // ),
                  // SizedBox(
                  //   height: 30,
                  // ),
                  Row(children: [
                    buildContainer(Color(0xff353D4A)),
                    SizedBox(
                      width: 1,
                    ),
                    Expanded(
                        child: CustomTextField(
                      controler: emailController,
                      txt: "Email",
                      obscured: false,
                      valid: emailValidator,
                    ))
                  ]),
                  SizedBox(
                    height: 30,
                  ),
                  Row(children: [
                    buildContainer(Color(0xff353D4A)),
                    SizedBox(
                      width: 1,
                    ),
                    Expanded(
                        child: CustomTextField(
                      controler: passController,
                      txt: "Password",
                      obscured: true,
                      valid: passwordValidator,
                    ))
                  ]),
                  SizedBox(
                    height: 60,
                  ),
                  CustomButton(
                    ontap: () async {
                      if (formkey.currentState!.validate()) {
                        setState(() {
                          isloading = true;
                        });

                        try {
                          await login();
                          // Only navigate if the login is successful
                          Navigator.pushNamed(context, ChatScreen.id,arguments: emailController.text);
                        } on FirebaseAuthException catch (e) {
                          setState(() {
                            isloading = false;
                          });

                          if (e.code == 'user-not-found') {
                            // Show SnackBar for unregistered email
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('No user found for that email.')),
                            );
                            print('No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            // Show SnackBar for wrong password
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Wrong password provided.')),
                            );
                            print('Wrong password provided.');
                          } else {
                            // Handle other FirebaseAuthExceptions
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Wrong Email or Password')),
                            );
                            print('Authentication error: ${e.message}');
                          }
                        } catch (e) {
                          // Handle other possible errors


                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('An error occurred. Please try again.')),
                          );
                          print('Error: $e');
                        }
                        setState(() {
                          isloading = false;
                        });
                        // Clear the input fields
                        emailController.clear();
                        passController.clear();
                      }
                    },

                    txt: "Login",
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "dont have an account? ",
                        style:
                            TextStyle(color: Color(0xff353D4A), fontSize: 16),
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, RegisterScreen.id,
                                arguments: "email");
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Color(0xff71C1D4), fontSize: 16),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container buildContainer(Color clr) {
    return Container(
      height: 63,
      width: 30,
      color: clr,
    );
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> login() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: emailController.text,
      password: passController.text,
    );
    print('User signed in: ${userCredential.user}');
  }

  //
  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }

    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    return null;
  }

  Future<User?> signInWithGoogle() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      setState(() {
        isloading = true;
      });

      final googleUser =
          await GoogleSignIn(scopes: ['profile', 'email']).signIn();
      if (googleUser == null) {
        setState(() {
          isloading = false;
        });
        return null; // User cancelled the sign-in
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final String? email = userCredential.user?.email;

      if (email != null) {
        Navigator.pushNamed(
          context,
          ChatScreen.id,
          arguments: email,
        );
      }
    } catch (e) {
      print('Error: $e');
      showSnackBar(context, 'Error: ${e.toString()}');
    } finally {
      setState(() {
        isloading = false;
      });
    }
  }
}
