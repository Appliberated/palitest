// Copyright (c) 2024 Appliberated (https://www.appliberated.com/). All rights reserved.
// Use of this source code is governed by a user license that can be found in the LICENSE file.

// This app is designed to be web-only, so we can use the web-only dart:html library to store
// the app settings in the browser's local storage.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

/// A singleton class that provides access to the app settings.
class SettingsProvider {
  static final SettingsProvider _instance = SettingsProvider._internal();

  factory SettingsProvider() => _instance;

  SettingsProvider._internal();

  static const String _ignoreCaseKey = "ignoreCase";
  static const String _ignoreSpacingKey = "ignoreSpacing";
  static const String _ignoreNonAlphanumeric = "ignoreNonAlphanumeric";

  Storage get _storage => window.localStorage;

  /// The ignore case setting (true by default).
  bool get ignoreCase => _storage[_ignoreCaseKey] != "false";
  set ignoreCase(bool value) {
    _storage[_ignoreCaseKey] = value.toString();
  }

  /// The ignore spacing setting (true by default).
  bool get ignoreSpacing => _storage[_ignoreSpacingKey] != "false";
  set ignoreSpacing(bool value) {
    _storage[_ignoreSpacingKey] = value.toString();
  }

  /// The ignore non-alphanumeric setting (true by default).
  bool get ignoreNonAlphanumeric => _storage[_ignoreNonAlphanumeric] != "false";
  set ignoreNonAlphanumeric(bool value) {
    _storage[_ignoreNonAlphanumeric] = value.toString();
  }
}
