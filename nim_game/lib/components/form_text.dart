import 'package:flutter/material.dart';

class FormText extends StatelessWidget {
  const FormText({super.key, required this.controller, required this.text});

  final TextEditingController controller;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: text),
      keyboardType: TextInputType.number,
    );
  }
}
