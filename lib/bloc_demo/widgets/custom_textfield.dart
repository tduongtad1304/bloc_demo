import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.keyboardType,
    this.labelText,
    this.fontSize,
    required this.isAlign,
    required this.color,
  }) : super(key: key);

  final TextEditingController controller;
  final double? fontSize;
  final bool isAlign;
  final TextInputType keyboardType;
  final String? labelText;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: color,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
      ),
      textCapitalization: TextCapitalization.words,
      textAlign: isAlign ? TextAlign.center : TextAlign.start,
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: color,
          width: 2.0,
          style: BorderStyle.solid,
        )),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: color,
            width: 2.0,
            style: BorderStyle.solid,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        labelText: labelText,
      ),
      onSubmitted: (value) {
        controller.text = value;
        if (kDebugMode) {
          print(value);
        }
      },
    );
  }
}
