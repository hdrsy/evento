String? passwordValidation(String? value) {
  if (value == null || value.isEmpty) {
    return "Password is required"; // Password is required
  }
  if (value.length < 8) {
    return "Password must be at least 8 characters long"; // Check for minimum length
  }
  if (!RegExp(r'[A-Z]').hasMatch(value)) {
    return "Password must contain at least one uppercase letter"; // Check for uppercase letter
  }
  if (!RegExp(r'[a-z]').hasMatch(value)) {
    return "Password must contain at least one lowercase letter"; // Check for lowercase letter
  }
  if (!RegExp(r'[0-9]').hasMatch(value)) {
    return "Password must contain at least one digit"; // Check for digit
  }
  if (!RegExp(r'[@$!%*#?&]').hasMatch(value)) {
    return "Password must contain at least one special character (@\$!%*#?&)"; // Check for special character
  }
  return null; // If all conditions are met, return null (valid)
}
