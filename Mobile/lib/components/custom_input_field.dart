import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semsark/provider/create_ad_provider.dart';

import '../utils/helper.dart';

class CustomFieldInput extends StatelessWidget {
  CustomFieldInput({
    Key? key,
    required this.txt,
    required this.controller,
    this.inputType,
    this.color,
    this.maxLine,
    this.maxLen,
    this.auto,
  }) : super(key: key);

  String txt;
  final TextEditingController controller;
  TextInputType? inputType;
  Color? color;
  int? maxLine, maxLen;
  bool? auto ;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: inputType ?? TextInputType.text,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: txt,
        filled: true,
        fillColor: color ?? Helper.input_field_color,
      ),
      maxLines: maxLine ?? 1,
      maxLength: maxLen ?? 50,
      minLines: 1,
      autofocus: auto ?? false,
      enabled: true,
      textInputAction: TextInputAction.done,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $txt';
        }
        return null;
      },
      controller: controller,
    );
  }
}
