import 'package:flutter/material.dart';

import '../Constants.dart';
class CustomTextField extends StatelessWidget {
  String txt;
  bool obscured = false;

  final String? Function(String?)? valid;
  TextEditingController controler;
   CustomTextField({required this.controler,required this.txt, this.valid,required this.obscured});

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      obscureText: obscured,
      validator: valid,

        controller: controler,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: txt,

          hintStyle: TextStyle(color: Colors.grey),
          border:OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),

          ) ,
          errorBorder:OutlineInputBorder(

            borderRadius: BorderRadius.circular(1),
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ) ,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(1),
            borderSide: BorderSide(
              color: KTextColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(1),
            borderSide: BorderSide(
              color: KTextColor,
            ),
          ),
        ),
      );

  }
}
