// Copyright (c) 2024 Appliberated (https://www.appliberated.com/). All rights reserved.
// Use of this source code is governed by a user license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../common/settings.dart';
import '../common/strings.dart' as strings;
import '../common/theme.dart';
import '../logic/palindrome_checker.dart';
import '../utils/utils.dart' as utils;
import '../common/urls.dart' as urls;
import 'palindrome_status.dart';
import 'palindrome_text_field.dart';
import 'sample_palindromes_dialog.dart';
import 'sponsor_badge.dart';

/// The main screen of the app that allows the user to check if a text is a palindrome.
class PalindromeCheckerScreen extends StatefulWidget {
  const PalindromeCheckerScreen({super.key});

  @override
  State<PalindromeCheckerScreen> createState() => _PalindromeCheckerScreenState();
}

class _PalindromeCheckerScreenState extends State<PalindromeCheckerScreen> {
  final TextEditingController _textController = TextEditingController();

  /// Whether the text in the text field is a palindrome.
  ///
  /// By default, it's true because an empty string is considered a palindrome.
  bool _isPalindrome = true;

  /// The normalized user text that is checked for palindrome.
  String _normalizedText = "";

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  /// Checks if the text in the text field is a palindrome and updates the UI.
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

  /// Pastes the text from the clipboard into the text field and rechecks for palindrome.
  Future<void> _pasteText() async {
    final text = await Clipboard.getData(Clipboard.kTextPlain);
    if (text?.text != null) {
      _textController.text = text!.text!;
      _checkPalindrome();
    }
  }

  /// Shows a dialog with a list of sample palindromes, and lets the user select one to check.
  Future<void> _showSamplePalindromes() async {
    final String? sample = await showSamplePalindromesDialog(context);
    if (sample != null) {
      _textController.text = sample;
      _checkPalindrome();
    }
  }

  // TODO: Add Share functionality
  // void _shareResult() async {
  //   final text = _textController.text;
  //   final resultText = _isPalindrome ? strings.isPalindromeText : strings.notPalindromeText;
  //   final content = "$text\n\n$resultText";
  //   // await SharePlus.instance.share(content, subject: "Palindrome Check Result");
  // }

  /// Called when the user taps an app bar icon button or menu item.
  void _appBarAction(_AppBarActions action) {
    switch (action) {
      case _AppBarActions.paste:
        _pasteText();
        break;
      case _AppBarActions.samplePalindromes:
        _showSamplePalindromes();
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

  /// Opens the sponsor badge URL in the default external application.
  void _onSponsorPressed() {
    utils.launchUrlExternal(context, urls.sponsorBadgeUrl);
  }

  @override
  Widget build(BuildContext context) {
    final bool isLandscape = MediaQuery.of(context).size.width > MediaQuery.of(context).size.height;

    return Scaffold(
      // The app bar at the top of the screen
      appBar: _AppBar(
        onAppBarAction: _appBarAction,
        ignoreCase: SettingsProvider().ignoreCase,
        ignoreSpacing: SettingsProvider().ignoreSpacing,
        ignoreNonAlphanumeric: SettingsProvider().ignoreNonAlphanumeric,
      ),

      // The main content of the screen
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16.0),

        // Constrain the width and height of the content, like a responsive web design container
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 1024.0,
            maxHeight: isLandscape ? 320.0 : 480.0,
          ),
          child: Flex(
            direction: isLandscape ? Axis.horizontal : Axis.vertical,
            children: <Widget>[
              // The text field for entering the text to check
              Expanded(
                child: PalindromeTextField(
                  controller: _textController,
                  onChanged: (_) => _checkPalindrome(),
                ),
              ),
              if (isLandscape) const SizedBox(width: 16.0) else const SizedBox(height: 16.0),

              // The status card that displays the result and normalized text
              Expanded(
                child: PalindromeStatus(
                  isPalindrome: _isPalindrome,
                  normalizedText: _normalizedText,
                ),
              ),
            ],
          ),
        ),
      ),

      // The sponsor badge at the bottom right corner
      floatingActionButton: SponsorBadge(
        onPressed: _onSponsorPressed,
      ),
    );
  }
}

/// The available actions that can be performed from the app bar.
enum _AppBarActions {
  paste,
  samplePalindromes,
  ignoreCase,
  ignoreSpacing,
  ignoreNonAlphanumeric,
}

/// The app bar for the palindrome checker screen.
class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({
    super.key, // ignore: unused_element
    this.onAppBarAction,
    required this.ignoreCase,
    required this.ignoreSpacing,
    required this.ignoreNonAlphanumeric,
  });

  /// The current Ignore Case setting to display in the menu.
  final bool ignoreCase;

  /// The current Ignore Spacing setting to display in the menu.
  final bool ignoreSpacing;

  /// The current Ignore Non-Alphanumeric setting to display in the menu.
  final bool ignoreNonAlphanumeric;

  /// Called when the user taps an app bar icon button or menu item.
  final void Function(_AppBarActions)? onAppBarAction;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      foregroundColor: Colors.white,
      title: const Text(strings.appTitle),
      actions: <Widget>[
        // The Paste icon button
        IconButton(
          icon: const Icon(Icons.paste),
          tooltip: strings.pasteActionTooltip,
          onPressed: () => onAppBarAction?.call(_AppBarActions.paste),
        ),
        // The Sample Palindromes icon button
        IconButton(
          icon: const Icon(Icons.list),
          tooltip: strings.samplePalindromesActionTooltip,
          onPressed: () => onAppBarAction?.call(_AppBarActions.samplePalindromes),
        ),
        PopupMenuButton<_AppBarActions>(
          onSelected: onAppBarAction,
          itemBuilder: (BuildContext context) => [
            // The Ignore Case checkbox menu item
            CheckedPopupMenuItem<_AppBarActions>(
              value: _AppBarActions.ignoreCase,
              checked: ignoreCase,
              child: const Text(strings.ignoreCaseText),
            ),

            // The Ignore Spacing checkbox menu item
            CheckedPopupMenuItem<_AppBarActions>(
              value: _AppBarActions.ignoreSpacing,
              checked: ignoreSpacing,
              child: const Text(strings.ignoreSpacingText),
            ),

            // The Ignore Non-Alphanumeric checkbox menu item
            CheckedPopupMenuItem<_AppBarActions>(
              value: _AppBarActions.ignoreNonAlphanumeric,
              checked: ignoreNonAlphanumeric,
              child: const Text(strings.ignoreNonAlphanumeric),
            ),
          ],
        ),
      ],

      // Fill the app bar with a linear gradient that suggests reflection (similar to a palindrome)
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, accentColor, Colors.black],
            stops: [0.0, 0.5, 1.0],
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
