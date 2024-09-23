import 'package:groupchat/Widgets/FriendChatBubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../Constants.dart';
import '../Models/MessageModel.dart';
import '../Widgets/chatBubble.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});
  static String id = "ChatScreen";
  TextEditingController meassageController = TextEditingController();
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  final scrollController = ScrollController();


  var email;
    @override
  Widget build(BuildContext context) {
     email= ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy("date",descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<MessageModel> MesaagesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; ++i) {
              MesaagesList.add(MessageModel.fromJson(snapshot.data!.docs[i]));
            }
            // print(snapshot.data!.docs[0]["text"]);
            return Scaffold(
              backgroundColor: Color(0xffEDE7E7),
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor:  Color(0xff353D4A),
                title: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      child: Image.asset(
                        "assets/Images/img.jpg",
                        width: 80,
                      ),
                    ),
                    SizedBox(width: 7,),
                    Text(
                      "Friends",
                      style: TextStyle(
                          color: KTextColor, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse:true ,
                        controller: scrollController,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: ((context, index) {
                          if(MesaagesList[index].id == email)
                            return ChatBubble(msg: MesaagesList[index]);
                          else return friendChatBubble(msg: MesaagesList[index]);
                        })),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: meassageController,
                      onSubmitted: (String val) {
                        meassageController.text = val;
                        _submitData();

                      },
                      decoration: InputDecoration(
                          hintText: "Enter a Message",
                          hintStyle: TextStyle(color: Colors.grey),
                          suffix: GestureDetector(
                            onTap: _submitData,
                            child: Icon(
                              Icons.send,
                              color: KPrimeryColor,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.grey,
                          )),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.grey,
                          ))),
                    ),
                  )
                ],
              ),
            );
          } else
            return Text("");
        });
  }
  void _submitData() {

    messages.add({
      'text': meassageController.text,
      "date": DateTime.now(),
      "id":email,
    });
    meassageController.clear();
    scrollController.animateTo(
        0, duration: Duration(microseconds: 500),
        curve: Curves.easeIn

    );
  }
}
