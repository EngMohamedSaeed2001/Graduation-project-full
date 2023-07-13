import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class EmailInputField extends StatelessWidget {
  EmailInputField({this.hintText,this.onChanged, this.enabled, this.inputController});
  String? hintText;
  bool? enabled;
  Function(String)? onChanged;
 TextEditingController? inputController ;

  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: inputController,
      onChanged: onChanged,
      enabled: enabled,
      validator: (value) =>
          EmailValidator.validate(value!) || enabled==false? null : "Please enter a valid email",
      decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFF1F6FB),
          prefixIcon:   const Icon(Icons.email_outlined),
          hintText: hintText,
          hintStyle: const TextStyle(color: Color(0xFF8189B0)),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.white,
          )),
          border: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.white,
          ))),
    );
    return Text("ll");
  }
}
