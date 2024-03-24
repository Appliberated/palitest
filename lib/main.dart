// Copyright (c) 2024 Appliberated (https://www.appliberated.com/). All rights reserved.
// Use of this source code is governed by a user license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import 'common/strings.dart' as strings;
import 'ui/palindrome_checker_screen.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await SettingsProvider().loadSettings(); // Load settings on startup
  runApp(const PaliTestApp());
}

class PaliTestApp extends StatelessWidget {
  const PaliTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: strings.appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PalindromeCheckerScreen(),
    );
  }
}
