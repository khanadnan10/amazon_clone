// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:amazon_clone/constants/global_variables.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final int maxLines;
  final TextInputType keyboardType;
  final TextEditingController controller;
  const CustomTextField({
    Key? key,
    required this.hintText,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: GlobalVariables.secondaryColor,
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter a $hintText';
        }
        return null;
      },
      maxLines: maxLines,
    );
  }
}
