// Copyright (c) 2024 Appliberated (https://www.appliberated.com/). All rights reserved.
// Use of this source code is governed by a user license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../common/strings.dart' as strings;
import '../common/theme.dart';
import '../utils/color_utils.dart' as color_utils;

class PalindromeStatus extends StatelessWidget {
  const PalindromeStatus({
    super.key,
    required this.isPalindrome,
    required this.normalizedText,
  });

  /// Whether the text is a palindrome.
  final bool isPalindrome;

  /// The normalized text used for testing palindrome.
  final String normalizedText;

  @override
  Widget build(BuildContext context) {
    final Color resultBackgroundColor = isPalindrome ? greenResultColor : redResultColor;
    final Color resultTextColor = color_utils.getContrastColor(resultBackgroundColor);

    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // The header with the result text and filled with the result background color
          Container(
            color: resultBackgroundColor,
            padding: const EdgeInsets.all(16.0),
            child: Text(
              isPalindrome ? strings.isPalindromeText : strings.notPalindromeText,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: resultTextColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          // Display the normalized text in a scrollable container to handle long user input
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Text(
                  normalizedText,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
