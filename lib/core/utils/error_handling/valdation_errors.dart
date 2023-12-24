class ValidationError {
  Map<String, List<String>> errors;

  ValidationError(this.errors);

  // Returns all error messages
  List<String> getAllMessages() {
    List<String> messages = [];
    errors.forEach((field, errorList) {
      messages.addAll(errorList);
    });
    return messages;
  }

  // Returns error messages for a specific field
  List<String> getFieldMessages(String field) {
    return errors[field] ?? [];
  }
}