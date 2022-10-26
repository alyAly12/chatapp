import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:chity/model/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatPage extends StatelessWidget {
  ChatPage({Key? key, }) : super(key: key);
  static  String id = 'chatId';
  final ScrollController controller = ScrollController();

  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  @override
  Widget build(BuildContext context) {
    var email =  ModalRoute.of(context)!.settings.arguments ;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy('createdAt',descending: true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            List<MessageModel>messageList=[];
            for(int i=0 ; i<snapshot.data!.docs.length ; i++){
              messageList.add(MessageModel.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: const Color(0xff284461),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.chat_bubble_outline),
                      Text(
                        'Chat',
                        style: GoogleFonts.pacifico(fontSize: 25),
                      ),
                    ],
                  ),
                  centerTitle: true,
                ),
                body: Column(
                    children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller:controller ,
                      itemCount: messageList.length,
                        itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: BubbleSpecialThree(
                          delivered: true,
                          seen: true,
                          text:messageList[index].message,
                          textStyle: GoogleFonts.aBeeZee(
                              color: Colors.white, fontSize: 16),
                          color: const Color(0xff284461),
                          tail: true,
                        ),
                      );
                    }),
                  ),

                  MessageBar(
                    onSend: (data){
                      messages.add({
                      'message': data,
                      'createdAt': DateTime.now(),
                        'id':email.toString()
                    });
                      controller.animateTo(
                        0.0,
                        duration:const Duration(seconds: 1) ,
                        curve:Curves.fastOutSlowIn
                          );

                    },
                    actions: [
                      InkWell(
                        child: const Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 24,
                        ),
                        onTap: () {},
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: InkWell(
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.green,
                            size: 24,
                          ),
                          onTap: () {},
                        ),
                      ),
                    ],
                  )
                ]));
          } else{
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }
        });
  }
}
