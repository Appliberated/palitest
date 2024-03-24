// Copyright (c) 2024 Appliberated (https://www.appliberated.com/). All rights reserved.
// Use of this source code is governed by a user license that can be found in the LICENSE file.

/// Check if the given [text] is a palindrome.
///
/// When [ignoreCase] is true, the text is converted to lowercase before checking. When
/// [ignoreSpacing] is true, all spaces are removed before checking. When [ignoreNonAlphanumeric] is
/// true, all non-word characters are removed before checking.
///
/// Returns a tuple with the first element as a boolean indicating if the text is a palindrome
/// and the second element as the normalized text used for checking.
(bool, String) isPalindrome(
  String text, {
  bool ignoreCase = true,
  bool ignoreSpacing = true,
  bool ignoreNonAlphanumeric = true,
}) {
  // Empty string is considered a palindrome
  if (text.isEmpty) return (true, text);

  String normalizedText = text;

  // Convert to lowercase if needed
  if (ignoreCase) {
    normalizedText = normalizedText.toLowerCase();
  }

  // Remove spaces if needed
  if (ignoreSpacing) {
    normalizedText = normalizedText.replaceAll(RegExp(r"\s+"), "");
  }

  // Remove non-alphanumeric characters if needed
  if (ignoreNonAlphanumeric) {
    normalizedText = normalizedText.replaceAll(RegExp(r"[^a-zA-Z0-9]"), "");
  }

  int left = 0;
  int right = normalizedText.length - 1;
  bool isPalindrome = true;

  // Check if the text is a palindrome
  while (left < right) {
    if (normalizedText[left] != normalizedText[right]) {
      isPalindrome = false;
      break;
    }
    left++;
    right--;
  }

  return (isPalindrome, normalizedText);
}
