// Copyright (c) 2024 Appliberated (https://www.appliberated.com/). All rights reserved.
// Use of this source code is governed by a user license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../common/settings.dart';
import '../common/strings.dart' as strings;
import '../logic/palindrome_checker.dart';
import 'palindrome_status.dart';
import 'palindrome_text_field.dart';

class PalindromeCheckerScreen extends StatefulWidget {
  const PalindromeCheckerScreen({super.key});

  @override
  State<PalindromeCheckerScreen> createState() => _PalindromeCheckerScreenState();
}

class _PalindromeCheckerScreenState extends State<PalindromeCheckerScreen> {
  final TextEditingController _textController = TextEditingController();
  String _normalizedText = "";
  bool _isPalindrome = false;

  Future<void> _checkPalindrome() async {
    final text = _textController.text;
    final settingsProvider = SettingsProvider();
    final palResult = isPalindrome(
      text,
      ignoreCase: settingsProvider.ignoreCase,
      ignoreSpacing: settingsProvider.ignoreSpacing,
      ignoreNonAlphanumeric: settingsProvider.ignoreNonAlphanumeric,
    );
    setState(() {
      _isPalindrome = palResult.$1;
      _normalizedText = palResult.$2;
    });
  }

  Future<void> _pasteText() async {
    final text = await Clipboard.getData(Clipboard.kTextPlain);
    if (text?.text != null) {
      setState(() {
        _textController.text = text!.text!;
      });
      _checkPalindrome();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Calculate isLandscape based on the available screen width and height
    final bool isLandscape = MediaQuery.of(context).size.width > MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(strings.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.paste),
            onPressed: _pasteText,
          ),
          // SettingsMenuWidget(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Flex(
          direction: isLandscape ? Axis.horizontal : Axis.vertical,
          children: [
            Expanded(
              child: PalindromeTextField(
                controller: _textController,
                onChanged: (_) => _checkPalindrome(),
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: PalindromeStatus(
                isPalindrome: _isPalindrome,
                normalizedText: _normalizedText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
