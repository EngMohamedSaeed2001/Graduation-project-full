import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:semsark/components/loading_screen.dart';
import 'package:semsark/provider/chat_provider.dart';

import '../../models/chat/chat_message_model.dart';

class ChatDetailPage extends StatelessWidget {
  //int index;

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
    var provider = Provider.of<ChatProvider>(context);
    DateTime currentDate = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy HH:mm:ss').format(currentDate);
    double width = MediaQuery.of(context).size.width ;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                SizedBox(
                  width: 40,
                  height: 40,
                  child: CircleAvatar(
                    backgroundImage:provider.reciver!.image==null||provider.reciver!.image=="string"||provider.reciver!.image==""? const AssetImage('assets/images/avtar.png'):null,
                    foregroundImage:provider.reciver!.image==null||provider.reciver!.image=="string"||provider.reciver!.image==""? null:NetworkImage(provider.reciver!.image),
                    backgroundColor: Colors.white,
                    maxRadius: 30,
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        provider.reciver!.username,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              
              ],
            ),
          ),
        ),
      ),
      body: 
        Column(
            children: [
              provider.chatMessages.isNotEmpty ?
              Expanded(
                child: Stack(
                  children: [
                    ListView.builder(
                      itemCount: provider.chatMessages.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      controller: _scrollController,
                      itemBuilder: (context, index) {
                        return Container(
                          padding:
                              const EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                          child: Align(
                            alignment:
                                (provider.chatMessages[index].receiverEmail != provider.currentUserEmail
                                    ? Alignment.topRight
                                    : Alignment.topLeft),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:
                                    (provider.chatMessages[index].receiverEmail == provider.currentUserEmail
                                        ? Colors.grey.shade200
                                        : Colors.blue[200]),
                              ),
                              padding: const EdgeInsets.all(16),
                              child:Column(
                                children: [
                                  SizedBox(
                                    // width: width * messages[index].message.length/10,
                                    child: Text(
                                      provider.chatMessages[index].message,
                                      style: const TextStyle(fontSize: 15),

                                    ),
                                  ),
                                  const SizedBox(height: 10,),

                                    SizedBox(
                                      width: width*0.3,
                                      child: Text(
                                        provider.chatMessages[index].date,
                                        style: const TextStyle(fontSize: 10,),
                                        textAlign: TextAlign.right,
                                      ),
                                    )


                                ],
                              )
                            ),
                          ),
                        );
                      },
                    ),
                    if(provider.loading) const LoadingScreen(),
                  ],
                ),
              )
              :
              const Expanded(child: Center(child: Text("No messages yet",textAlign: TextAlign.center,))),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                  height: 60,
                  width: double.infinity,
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      // GestureDetector(
                      //   onTap: () {},
                      //   child: Container(
                      //     height: 30,
                      //     width: 30,
                      //     decoration: BoxDecoration(
                      //       color: Colors.lightBlue,
                      //       borderRadius: BorderRadius.circular(30),
                      //     ),
                      //     child: const Icon(
                      //       Icons.add,
                      //       color: Colors.white,
                      //       size: 20,
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: TextField(
                          controller: provider.textEditingController,
                          onChanged: (value) => {provider.setMessage(value)},
                          decoration: const InputDecoration(
                              hintText: "Write message...",
                              hintStyle: TextStyle(color: Colors.black54),
                              border: InputBorder.none),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          //provider.setReciverEmail(provider.reciver!.email);
                          DateTime currentDate = DateTime.now();
                          print(currentDate);
                          String formattedDate = DateFormat('dd-MM-yyyy HH:mm:ss').format(currentDate);
                          provider.setDate(formattedDate);
                          provider.setMessage(provider.textEditingController.text);
                          provider.sendMessage();
                          //provider.setMessage("");
                          provider.textEditingController.clear();
                        },
                        backgroundColor: Colors.blue,
                        elevation: 0,
                        child: const Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ) 
     
      
    );
  }
}
