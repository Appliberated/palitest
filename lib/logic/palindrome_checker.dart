// Copyright (c) 2024 Appliberated (https://www.appliberated.com/). All rights reserved.
// Use of this source code is governed by a user license that can be found in the LICENSE file.

/// Check if the given [text] is a palindrome.
///
/// When [ignoreCase] is true, the text is converted to lowercase before checking. When
/// [ignoreSpacing] is true, all spaces are removed before checking. When [ignoreNonAlphanumeric] is
/// true, all non-word characters are removed before checking.
///
/// Returns a tuple with the first element as a boolean indicating if the text is a palindrome
/// and the second element as the processed text.
(bool, String) isPalindrome(
  String text, {
  bool ignoreCase = true,
  bool ignoreSpacing = true,
  bool ignoreNonAlphanumeric = true,
}) {
  // Empty string is considered a palindrome
  if (text.isEmpty) return (true, text);

  String processedText = text;

  // Convert to lowercase if needed
  if (ignoreCase) {
    processedText = processedText.toLowerCase();
  }

  // Remove spaces if needed
  if (ignoreSpacing) {
    processedText = processedText.replaceAll(RegExp(r"\s+"), "");
  }

  // Remove non-alphanumeric characters if needed
  if (ignoreNonAlphanumeric) {
    processedText = processedText.replaceAll(RegExp(r"[^a-zA-Z0-9]"), "");
    // processedText = processedText.replaceAll(RegExp(r"[^\w]"), "");
  }

  int left = 0;
  int right = processedText.length - 1;
  bool isPalindrome = true;

  // Check if the text is a palindrome
  while (left < right) {
    if (processedText[left] != processedText[right]) {
      isPalindrome = false;
      break;
    }
    left++;
    right--;
  }

  return (isPalindrome, processedText);
}
