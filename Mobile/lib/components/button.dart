import 'package:flutter/material.dart';

import '../utils/helper.dart';

class CustomButon extends StatelessWidget {
  CustomButon({this.onTap, required this.text});
  VoidCallback? onTap;
  String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Helper.blue,
          borderRadius: BorderRadius.circular(30),
        ),
        width: double.infinity,
        height: 60,
        child: Center(
          child: Text(text,
          style: const TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 18
          ),
          ),
        ),
      ),
    );
  }
}
