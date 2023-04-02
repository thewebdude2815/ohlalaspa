import 'package:flutter/material.dart';

class TextFieldSpaApp extends StatelessWidget {
  const TextFieldSpaApp({
    super.key,
    required this.idController,
    required this.textInputType,
    required this.hintTxt,
  });

  final TextEditingController idController;
  final TextInputType textInputType;
  final String hintTxt;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: idController,
      keyboardType: textInputType,
      decoration: InputDecoration(
        hintText: hintTxt,
        filled: true,
        fillColor: const Color(0xFF707070).withOpacity(0.05),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: const Color(0xFF707070).withOpacity(0.09)),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: const Color(0xFF707070).withOpacity(0.09)),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xfff0f0f0)),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xffB00020),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
