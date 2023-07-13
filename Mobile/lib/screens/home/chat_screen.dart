import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semsark/components/loading_screen.dart';

import '../../models/chat/chat_message_model.dart';
import '../../models/chat/chat_user_model.dart';
import '../../provider/chat_provider.dart';
import '../chat/chat_detial.dart';
import '../chat/conversationList.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<ChatMessage> chatMessages = [];

  @override
  Widget build(BuildContext context) {

    return _ui(context);
  }

  _ui(context){

    double height = MediaQuery.of(context).size.height ;
    var provider = Provider.of<ChatProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          "Conversations",
                          style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          padding:
                          const EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search...",
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey.shade600,
                        size: 20,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: const EdgeInsets.all(8),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.grey.shade100)),
                    ),
                  ),
                ),
                (provider.chatUsers.isNotEmpty
                    ? ListView.builder(
                  itemCount: provider.chatUsers.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 16),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        await provider.setReciver(provider.chatUsers[index]);
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return ChatDetailPage();
                        }));
                      },
                      child: ConversationList(
                        name: provider.chatUsers[index].username,
                        messageText: "",
                        imageUrl: provider.chatUsers[index].image,
                        time: "",
                        isMessageRead: true,
                        email: provider.chatUsers[index].email,
                        id: provider.chatUsers[index].id,
                      ),
                    );
                  },
                )
                    : Column(
                  children: [
                    SizedBox(
                      height: 0.4*height,
                    ),
                    const Center(child: Text("No messages yet",style:TextStyle(fontSize: 25 )))
                  ],
                ))
              ],
            ),
          ),
          if(provider.loading) const LoadingScreen() ,
    ],
      ),
    );
  }

  void getAllMessage(ChatProvider provider)  {
    chatMessages=[];
    FirebaseApp firebaseApp = Firebase.app();
    FirebaseDatabase database = FirebaseDatabase.instanceFor(app:firebaseApp);
    database.ref('chat/${provider.room}/').onValue.listen((DatabaseEvent event) {
      final snapshot = event.snapshot.value;
      Map<dynamic, dynamic>? dataMap = snapshot as Map<dynamic, dynamic>?;
      if (dataMap != null) {
        dataMap.forEach((key, value) {
          if(value["receiverEmail"] == provider.reciverEmail)
            chatMessages.add(ChatMessage( receiverEmail: value["receiverEmail"], message: value["message"], status: value["status"], date: value["dates"]));
          print(value["message"]);
          setState(() {

          });
        });
      }
      chatMessages.sort((a, b) => a.date.compareTo(b.date));

    });
    print(chatMessages);
  }
}
