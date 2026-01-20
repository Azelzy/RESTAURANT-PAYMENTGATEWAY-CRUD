import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String labelText;
  const MyTextField({
    super.key,
    required this.textEditingController,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(label: Text(labelText)),
      controller: textEditingController,
    );
  }
}
