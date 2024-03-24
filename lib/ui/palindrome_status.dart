// Copyright (c) 2024 Appliberated (https://www.appliberated.com/). All rights reserved.
// Use of this source code is governed by a user license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../common/strings.dart' as strings;

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Card.filled(
          color: isPalindrome ? Colors.green.shade50 : Colors.red.shade50,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              isPalindrome ? strings.isPalindromeText : strings.notPalindromeText,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: isPalindrome ? Colors.green : Colors.red,
                  ),
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              normalizedText,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
      ],
    );
  }
}
