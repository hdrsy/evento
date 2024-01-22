String? phoneValidation(String? value) {
  if (value == null || value.isEmpty) {
    return "Please enter a phone number"; // Handle null or empty input
  }
  
  // Check if the length is neither 9 nor 10
  if (value.length != 10 && value.length != 9) {
    return "Please enter a valid number"; // Phone number should be 9 or 10 digits
  }

  // Add additional validations if needed (e.g., checking for non-numeric characters)

  return null; // No error found
}
