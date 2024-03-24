import 'package:easy_localization/easy_localization.dart';

String? phoneValidation(String? value) {
  // Preprocess to ensure consistency
  if (value != null && value.startsWith('9') && value.length == 9) {
    value = '0$value'; // Adjust the input for validation
  }

  if (value == null || value.isEmpty) {
    return tr("Please enter a phone number"); // Handle null or empty input
  }

  // Validate Syrian phone numbers (now considering the preprocessing step)
  if (!RegExp(r'^09\d{8}$').hasMatch(value)) {
    return tr("Please enter a valid Syrian phone number");
  }

  // No error found
  return null;
}
