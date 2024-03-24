// Copyright (c) 2024 Appliberated (https://www.appliberated.com/). All rights reserved.
// Use of this source code is governed by a user license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../common/strings.dart' as strings;
import '../common/theme.dart';

/// A text field for entering the text to check if it's a palindrome.
class PalindromeTextField extends StatelessWidget {
  const PalindromeTextField({
    super.key,
    this.controller,
    this.onChanged,
  });

  /// The controller for the text field.
  final TextEditingController? controller;

  /// The callback for when the text field value changes.
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: accentColor,
            width: 2.0,
          ),
        ),
        hintText: strings.hintText,
      ),
      textAlignVertical: TextAlignVertical.top,
      expands: true,
      maxLines: null,
      controller: controller,
      onChanged: onChanged,
    );
  }
}
