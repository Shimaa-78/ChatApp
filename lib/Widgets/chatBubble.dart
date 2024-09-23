import 'package:groupchat/Models/MessageModel.dart';
import 'package:flutter/material.dart';

import '../Constants.dart';
class ChatBubble extends StatelessWidget {
  MessageModel msg = MessageModel();
   ChatBubble({
    super.key,
   required this.msg,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(left: 20,right: 20,top: 10),
        padding: EdgeInsets.all(20),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          color: Color(0xff353D4A),


        ),
        child: Text("${msg.Message}",style: TextStyle(color: KTextColor),),
      ),
    );
  }
}
