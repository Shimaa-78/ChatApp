import 'package:flutter/material.dart';

import '../Constants.dart';

class CustomButton extends StatelessWidget {
  String txt;
  final VoidCallback? ontap;
  CustomButton({required this.ontap, required this.txt});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: double.infinity,
        height: 63,
        decoration: BoxDecoration(
            color: Color(0xff353D4A), borderRadius: BorderRadius.circular(2)),
        child: Center(
            child: Text(
          txt,
          style: TextStyle(
              color: Color(0xff4C545F),
              fontWeight: FontWeight.bold,
              fontSize: 20),
        )),
      ),
    );
  }
}
