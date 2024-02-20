import 'valdation_errors.dart';

/// ErrorResponse class models the error response returned from an API.
/// It includes a status flag, a general message, and detailed validation errors.
class ErrorResponse {
  bool? status; // Status indicating the success or failure of the API call
  String? message; // General message describing the error
  ValidationError?
      validationErrors; // Object holding detailed validation errors

  /// Constructor for creating an ErrorResponse instance.
  /// It initializes the instance with an optional status, message, and detailed error data.
  ErrorResponse({this.status, this.message, Map<String, dynamic>? errorData}) {
    if (errorData != null) {
      // Converts the error data into a more structured format.
      Map<String, List<String>> castedErrorData = {};
      errorData.forEach((key, value) {
        if (value is List) {
          // Ensure that the value is a list and cast it to List<String>.

          castedErrorData[key] = List<String>.from(value);
        }
      });
      // Create ValidationError instance with the structured error data.
      validationErrors = ValidationError(castedErrorData);
    }
  }

  /// Factory constructor to create an ErrorResponse instance from a JSON map.
  /// This is commonly used to parse the JSON response from an API call.
  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      status: json['status'] ??
          json['Status'], // Handle both 'status' and 'Status' keys.
      message: json['message'], // General error message from the API response.
      errorData:
          json['Validation Error'], // Specific validation error data, if any.
    );
  }

  /// Extracts and returns a list of error messages from the ErrorResponse instance.
  /// It combines the general error message with detailed validation error messages.
  List<String> getErrorMessages() {
    List<String> errors = [];
    if (message != null) {
      // Add the general error message, if available.
      errors.add(message!);
    }
    if (validationErrors != null) {
      // Add detailed validation error messages, if available.
      validationErrors!.errors.forEach((key, value) {
        errors.addAll(value);
      });
    }
    return errors;
  }

  /// Overrides toString to provide a readable string representation of the error.
  /// Returns a concatenated string of all error messages for easy display.
  @override
  String toString() {
    List<String> errors = getErrorMessages();
    // If there are error messages, join them with line breaks; otherwise, return a default message.
    return errors.isNotEmpty ? errors.join('\n') : "Unknown Error";
  }
}
