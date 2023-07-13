import 'package:flutter/material.dart';
//import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:provider/provider.dart';

import '../../provider/chat_provider.dart';
import 'chat_detial.dart';

class ConversationList extends StatelessWidget {
  String name;
  String messageText;
  String imageUrl;
  String time;
  bool isMessageRead;
  int id;
  String email;
  ConversationList(
      {
        required this.name,
      required this.email,
      required this.id,
      required this.messageText,
      required this.imageUrl,
      required this.time,
      required this.isMessageRead});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children:[
                CircleAvatar(
                  backgroundImage:imageUrl==null||imageUrl=="string"||imageUrl==""? AssetImage('assets/images/avtar.png'):null,
                  foregroundImage:imageUrl==null||imageUrl=="string"||imageUrl==""? null:NetworkImage(imageUrl),
                  backgroundColor: Colors.white,
                  maxRadius: 30,
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          name,
                          style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          messageText,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                              fontWeight: isMessageRead
                                  ? FontWeight.bold
                                  : FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: TextStyle(
                fontSize: 12,
                fontWeight:
                    isMessageRead ? FontWeight.bold : FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
