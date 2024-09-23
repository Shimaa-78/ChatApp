import 'package:groupchat/Screens/LoginScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../Widgets/CustomButton.dart';
import '../Widgets/CustomTxtField.dart';
import 'ChatScreen.dart';
class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});
  static String id = "register";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool isloading = false;

  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
        backgroundColor: Color(0xffEDE7E7),
        body: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0,right: 20,top: 70),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Create Account",
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
                            txt: "Continue  with Google",
                            ontap:()async {
                              signInWithGoogle();

                            },
                      ),)
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
                    height: 40,
                  ),
                  Row(
                    children: [
                      buildContainer(Color(0xff353D4A)),
                      SizedBox(width: 1,),
                      Expanded(child: CustomTextField(controler: nameController, txt: "Name", obscured: false,valid: nameValidator,))
                    ]

                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                      children: [
                        buildContainer(Color(0xff353D4A)),
                        SizedBox(width: 1,),
                        Expanded(child: CustomTextField(controler: phoneController, txt: "Phone Number", obscured: false,valid: phoneValidator,))
                      ]

                  ),
                  SizedBox(
                    height: 20,
                  ),
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
                    height: 20,
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
                    height: 20,
                  ),
                  CustomButton(
                    ontap: () async {
                      if (formkey.currentState!.validate()) {
                        setState(() {
                          isloading = true;
                        });

                        try {
                          await Register();

                          Navigator.pushNamed(context, ChatScreen.id,arguments: emailController.text);
                        } on FirebaseAuthException catch (e) {
                          setState(() {
                            isloading = false;
                          });

                          if (e.code == 'email-already-in-use') {
                            // Show the SnackBar for "email-already-in-use"
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('The email is already in use by another account.')),
                            );
                            print('The email is already in use by another account.');
                          } else if (e.code == 'weak-password') {
                            // Show the SnackBar for "weak-password"
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('The password provided is too weak.')),
                            );
                            print('The password provided is too weak.');
                          } else if (e.code == 'invalid-email') {
                            // Show the SnackBar for "invalid-email"
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('The email address is not valid.')),
                            );
                            print('The email address is not valid.');
                          } else {
                            // Handle other potential errors
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('An error occurred. Please try again.')),
                            );
                          }
                        } catch (e) {
                          setState(() {
                            isloading = false;
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('An unexpected error occurred. Please try again later.')),
                          );
                          print(e.toString());
                        }

                        setState(() {
                          isloading = false;
                        });
                        emailController.clear();
                        passController.clear();
                        phoneController.clear();
                        nameController.clear();
                      }
                    },

                    txt: "Register",
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
                            Navigator.pushNamed(context, LoginScreen.id,
                                arguments: emailController);
                          },
                          child: Text(
                            "Login",
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
  void showSnackBar(BuildContext context, String txt) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(txt)));
  }

  Future<void> Register() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passController.text,
    );
    String userId = userCredential.user!.uid;

    // Store additional user info in Firestore
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'name': "name",
      "phone": "kgmfgl",
    });
    // Navigate to another screen or show success
    print('User registered: ${userCredential.user}');
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }

    // Basic email pattern matching
    final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );

    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }

    return null;
  }
  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null; // Add additional checks if needed (e.g., length)
  }

  String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    // Check if the phone number is valid (e.g., using regex or length)
    if (value.length < 10) {
      return 'Please enter a valid phone number';
    }
    return null;
  }
  Future<User?> signInWithGoogle() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      setState(() {
        isloading = true;
      });

      final googleUser = await GoogleSignIn(scopes: ['profile', 'email']).signIn();
      if (googleUser == null) {
        setState(() {
          isloading = false;
        });
        return null; // User cancelled the sign-in
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Attempt to sign in with the credential
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final String? email = userCredential.user?.email;

      if (email != null) {
        Navigator.pushNamed(
          context,
          ChatScreen.id,
          arguments: email,
        );
      }

    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.code} - ${e.message}'); // Log the error
      if (e.code == 'account-exists-with-different-credential') {
        showSnackBar(
          context,
          'This email is already registered with a different sign-in provider. Please use that method to sign in.',
        );
      } else if (e.code == 'invalid-credential') {
        showSnackBar(
          context,
          'The provided credentials are not valid. Please try again.',
        );
      } else {
        showSnackBar(
          context,
          'Error: ${e.message}',
        );
      }
    } catch (e) {
      print('Error: $e'); // Log the general error
      showSnackBar(context, 'Error: Check your Internet connection.');
    } finally {
      setState(() {
        isloading = false;
      });
    }
  }




}
