import 'package:flutter/material.dart';

class PalindromeTextField extends StatelessWidget {
  const PalindromeTextField({
    super.key,
    this.controller,
    this.onChanged,
  });

  final TextEditingController? controller;

  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    // Return a text field widget, that fills the available space, both horizontally and vertically.
    // It should have a border all around, with a thickness of 2.0, and a color of Colors.deepPurple.
    return TextField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.deepPurple,
            width: 2.0,
          ),
        ),
      ),
      expands: true,
      maxLines: null,
      controller: controller,
      onChanged: onChanged,
    );
  }
}