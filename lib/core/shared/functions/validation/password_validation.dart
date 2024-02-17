// String? passwordValidation(String? value) {
//   if (value == null || value.isEmpty) {
//     return "Password is required"; // Password is required
//   }
//   if (value.length < 8) {
//     return "Password must be at least 8 characters long"; // Check for minimum length
//   }
//   if (!RegExp(r'[A-Z]').hasMatch(value)) {
//     return "Password must contain at least one uppercase letter"; // Check for uppercase letter
//   }
//   if (!RegExp(r'[a-z]').hasMatch(value)) {
//     return "Password must contain at least one lowercase letter"; // Check for lowercase letter
//   }
//   if (!RegExp(r'[0-9]').hasMatch(value)) {
//     return "Password must contain at least one digit"; // Check for digit
//   }
//   if (!RegExp(r'[@$!%*#?&]').hasMatch(value)) {
//     return "Password must contain at least one special character (@\$!%*#?&)"; // Check for special character
//   }
//   return null; // If all conditions are met, return null (valid)
// }
String? passwordValidation(String? value) {
  if (value == null || value.isEmpty) {
    return "Password is required"; // Password is required
  }
  if (value.length < 8) {
    return "Password must be at least 8 characters long"; // Check for minimum length
  }
  // Check for at least one letter
  if (!RegExp(r'(?=.*[A-Za-z])').hasMatch(value)) {
    return "Password must contain at least one letter"; // Check for at least one letter
  }
  // Check for at least one number
  if (!RegExp(r'(?=.*\d)').hasMatch(value)) {
    return "Password must contain at least one number"; // Check for at least one number
  }
  return null; // If all conditions are met, return null (valid)
}
