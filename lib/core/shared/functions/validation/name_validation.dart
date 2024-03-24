import 'package:easy_localization/easy_localization.dart';

String? nameValidation(String? value) {
  if (value == null || value.isEmpty) {
    return tr("Please enter a name"); // Handle null or empty input
  }
  if (value.length <= 2) {
    return tr("Please Type Longer name");
  } else if (value.length > 20) {
    return tr("Please type shorter name");
  }

  return null;
}
