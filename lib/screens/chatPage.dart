import 'package:chat/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/message.dart';
import '../widgets/chatbuble.dart';

class Chatpage extends StatefulWidget {
  static String id = "Chatpage";

  @override
  State<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessageCollections);

  TextEditingController controller = TextEditingController();

  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      print('done');
    }else {
      print("No email found");
    }
    var email = ModalRoute.of(context)!.settings.arguments;
    if (email!=null) {
      print(email);
    }else {
      print("No email found");
    }
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // print(snapshot.data!.docs[0]['message']);
          List<Message> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(
              Message.fromJson(snapshot.data!.docs[i]),
            );
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    kLogo,
                    height: 50,
                  ),
                  const Text(
                    'Chat',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              backgroundColor: kPrimaryColor,
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                      controller: _controller,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        return messagesList[index].id == email ? chatBuble(
                          message: messagesList[index],
                        ) : chatBubleForFriends(message: messagesList[index]);
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      messages.add({
                        kMessage: data,
                        kCreatedAt: DateTime.now(),
                        'id': email,
                      });
                      controller.clear();
                      _controller.animateTo(
                        // _controller.position.maxScrollExtent,
                        0,
                        duration: Duration(seconds: 1),
                        curve: Curves.fastOutSlowIn,
                      );
                    },
                    decoration: InputDecoration(
                      hintText: 'Send Message',
                      suffixIcon: const Icon(Icons.send, color: kPrimaryColor),
                      //(suffixIcon) نحاول نخلى دى هيا زرار السبميت
                      // عن طريف انها تكون (icon button)
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: kPrimaryColor)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: kPrimaryColor)),
                    ),
                  ),
                )
              ],
            ),
          );
        } else {
          return Text('Loading...');
        }
      },
    );
  }
}
