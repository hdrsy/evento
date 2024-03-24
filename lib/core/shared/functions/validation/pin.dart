import 'package:easy_localization/easy_localization.dart';

String? pinValidation(String? value) {
  if (value == null || value.isEmpty) {
    return "Please enter a pin"; // Handle null or empty input
  }
  if (value.length != 4) {
    return "Please Type 4 digites";
  }

  return null;
}

String? otpPaymentValidation(String? value) {
  if (value == null || value.isEmpty) {
    return tr("Please enter a pin"); // Handle null or empty input
  }
  if (value.length != 6) {
    return tr("Please Type the required digites");
  }

  return null;
}
