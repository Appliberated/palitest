// Copyright (c) 2024 Appliberated (https://www.appliberated.com/). All rights reserved.
// Use of this source code is governed by a user license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../common/settings.dart';
import '../common/strings.dart' as strings;
import '../logic/palindrome_checker.dart';
import 'result_text_widget.dart';

class PalindromeCheckerScreen extends StatefulWidget {
  const PalindromeCheckerScreen({super.key});

  @override
  State<PalindromeCheckerScreen> createState() => _PalindromeCheckerScreenState();
}

class _PalindromeCheckerScreenState extends State<PalindromeCheckerScreen> {
  final TextEditingController _textController = TextEditingController();
  String _processedText = "";
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
      _processedText = palResult.$2;
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
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: const InputDecoration(hintText: strings.hintText),
              maxLines: null, // Allow multiline input
              onChanged: (_) => _checkPalindrome(),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                const Text(strings.processedTextLabel),
                const SizedBox(width: 8.0),
                Expanded(child: Text(_processedText)),
              ],
            ),
            const SizedBox(height: 8.0),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: ResultTextWidget(
                text: _isPalindrome ? strings.isPalindromeText : strings.notPalindromeText,
                color: _isPalindrome ? Colors.green : Colors.red,
                animation: const AlwaysStoppedAnimation(1.0),
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
