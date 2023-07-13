import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  InputField({this.hintText, this.inputIcon,this.onChanged, required String? Function(dynamic value) validator, required TextEditingController controller});
  String? hintText;
  Icon? inputIcon;
  Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data) {
        if (data!.isEmpty) {
          return "Field is required";
        }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFF1F6FB),
          prefixIcon: inputIcon,
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
  }
}
