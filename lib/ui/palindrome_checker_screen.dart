// Copyright (c) 2024 Appliberated (https://www.appliberated.com/). All rights reserved.
// Use of this source code is governed by a user license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../common/settings.dart';
import '../common/strings.dart' as strings;
import '../logic/palindrome_checker.dart';
import 'palindrome_status.dart';
import 'palindrome_text_field.dart';
import 'sponsor_badge.dart';
import '../common/custom_icons.dart' as custom_icons;

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

  void _shareResult() async {
    final text = _textController.text;
    final resultText = _isPalindrome ? strings.isPalindromeText : strings.notPalindromeText;
    final content = "$text\n\n$resultText";
    // await SharePlus.instance.share(content, subject: "Palindrome Check Result");
  }

  void _appBarAction(_AppBarActions action) {
    switch (action) {
      case _AppBarActions.paste:
        _pasteText();
        break;
      case _AppBarActions.ignoreCase:
        SettingsProvider().ignoreCase = !SettingsProvider().ignoreCase;
        _checkPalindrome();
        break;
      case _AppBarActions.ignoreSpacing:
        SettingsProvider().ignoreSpacing = !SettingsProvider().ignoreSpacing;
        _checkPalindrome();
        break;
      case _AppBarActions.ignoreNonAlphanumeric:
        SettingsProvider().ignoreNonAlphanumeric = !SettingsProvider().ignoreNonAlphanumeric;
        _checkPalindrome();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Calculate isLandscape based on the available screen width and height
    final bool isLandscape = MediaQuery.of(context).size.width > MediaQuery.of(context).size.height;

    // Theme.of(context).colorScheme.
    return Scaffold(
      appBar: _AppBar(
        onAppBarAction: _appBarAction,
        ignoreCase: SettingsProvider().ignoreCase,
        ignoreSpacing: SettingsProvider().ignoreSpacing,
        ignoreNonAlphanumeric: SettingsProvider().ignoreNonAlphanumeric,
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
            // Add a horizontal or vertical space between the text field and the status
            // depending on the value of isLandscape
            if (isLandscape) const SizedBox(width: 16.0) else const SizedBox(height: 16.0),
            Expanded(
              child: PalindromeStatus(
                isPalindrome: _isPalindrome,
                normalizedText: _normalizedText,
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: const SponsorBadge(),
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.share),
      //   onPressed: () => _shareResult(),
      // ),
      // floatingActionButton: FloatingActionButton.extended(
      //   icon: const Icon(custom_icons.eastTecLogoMark),
      //   // label: const Text(strings.broughtToYouByWide),
      //   label: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: <Widget>[
      //       Text(
      //         strings.broughtToYouByWide,
      //         style: Theme.of(context).textTheme.bodySmall,
      //       ),
      //       Text(
      //         strings.eastTecWide,
      //         style: Theme.of(context).textTheme.bodyMedium,
      //       ),
      //     ],
      //   ),
      //   onPressed: () => _shareResult(),
      // ),
      floatingActionButton: const SponsorBadge(),
    );
  }
}

/// The available actions that can be performed from the app bar.
enum _AppBarActions {
  paste,
  ignoreCase,
  ignoreSpacing,
  ignoreNonAlphanumeric,
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({
    super.key, // ignore: unused_element
    this.onAppBarAction,
    required this.ignoreCase,
    required this.ignoreSpacing,
    required this.ignoreNonAlphanumeric,
  });

  final bool ignoreCase;
  final bool ignoreSpacing;
  final bool ignoreNonAlphanumeric;

  /// Called when the user taps an app bar icon button or menu item.
  final void Function(_AppBarActions)? onAppBarAction;

  @override
  Widget build(BuildContext context) {
    final Color mainColor = Theme.of(context).colorScheme.secondary;

    return AppBar(
      title: const Text(strings.appTitle),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.paste),
          onPressed: () => onAppBarAction?.call(_AppBarActions.paste),
        ),
        // SettingsMenuWidget(),
        PopupMenuButton<_AppBarActions>(
          onSelected: onAppBarAction,
          itemBuilder: (BuildContext context) => [
            CheckedPopupMenuItem<_AppBarActions>(
              value: _AppBarActions.ignoreCase,
              checked: ignoreCase,
              child: const Text(strings.ignoreCaseText),
            ),
            CheckedPopupMenuItem<_AppBarActions>(
              value: _AppBarActions.ignoreSpacing,
              checked: ignoreSpacing,
              child: const Text(strings.ignoreSpacingText),
            ),
            CheckedPopupMenuItem<_AppBarActions>(
              value: _AppBarActions.ignoreNonAlphanumeric,
              checked: ignoreNonAlphanumeric,
              child: const Text(strings.ignoreNonAlphanumeric),
            ),
          ],
        ),
      ],
      flexibleSpace: Container(
        decoration: BoxDecoration(
          // A linear gradient from mainColor to black until half the width of the app bar
          // and back to mainColor until the end of the app bar, to suggest a sense of reflection
          gradient: LinearGradient(
            colors: [Colors.black, mainColor, Colors.black],
            stops: const [0.0, 0.5, 1.0],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
