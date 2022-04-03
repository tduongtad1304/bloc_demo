import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.keyboardType,
    this.labelText,
    this.fontSize,
    required this.isAlign,
  }) : super(key: key);

  final TextEditingController controller;
  final double? fontSize;
  final bool isAlign;
  final TextInputType keyboardType;
  final String? labelText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
      ),
      textCapitalization: TextCapitalization.words,
      textAlign: isAlign ? TextAlign.center : TextAlign.start,
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.purple,
            width: 2.0,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        labelText: labelText,
      ),
      onSubmitted: (value) {
        controller.text = value;
      },
    );
  }
}
