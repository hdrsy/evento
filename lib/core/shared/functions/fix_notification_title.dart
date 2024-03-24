String removeNavigateToEnd(String input) {
  // Find the index of "navigate" in the string
  int navigateIndex = input.indexOf('navigate');

  // If "navigate" is found, return the substring from the start to just before "navigate"
  // Otherwise, return the original string
  return navigateIndex != -1 ? input.substring(0, navigateIndex).trim() : input;
}

String extractWordAfterNavigate(String input) {
  // Define a regex pattern to find the word after "navigate"
  final RegExp regExp = RegExp(r'navigate (\w+)');

  // Find the first match of the pattern in the input string
  final match = regExp.firstMatch(input);

  // If a match is found, return the word immediately following "navigate"
  if (match != null) {
    return match.group(
        1)!; // The exclamation mark asserts that the matched group is not null
  } else {
    return 'No word found after "navigate".';
  }
}
