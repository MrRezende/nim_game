import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({super.key, required this.function, required this.text});

  final VoidCallback function;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: function,
        child: Text(text),
      ),
    );
  }
}
