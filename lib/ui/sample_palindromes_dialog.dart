// Copyright (c) 2024 Appliberated (https://www.appliberated.com/). All rights reserved.
// Use of this source code is governed by a user license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../common/strings.dart' as strings;
import '../data/sample_palindromes.dart';

/// Shows a dialog with a list of sample palindromes.
Future<String?> showSamplePalindromesDialog(BuildContext context) async {
  return await showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: const Text(strings.samplePalindromesDialogTitle),
        children: <Widget>[
          // Text(strings.samplePalindromesDialogText),
          // const SizedBox(height: 16),
          // Text(strings.samplePalindromesDialogListTitle),
          // const SizedBox(height: 8),
          for (final sample in kSamplePalindromes)
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480.0),
              child: SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, sample);
                },
                child: Text(sample),
              ),
            ),
        ],
      );
    },
  );
}
