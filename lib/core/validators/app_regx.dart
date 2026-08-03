class AppRegex {
  AppRegex._(); // Private constructor to prevent instantiation

  // Email Validation
  static bool isEmailValid(String email) {
    return RegExp(r'^.+@[a-zA-Z]+\.[a-zA-Z]+(\.[a-zA-Z]+)?$').hasMatch(email);
  }

  // Strong Password Validation (8+ chars, at least 1 lowercase letter, at least 1 uppercase letter, 1 digit, at least 1 special character)
  static bool isPasswordValid(String password) {
    return RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    ).hasMatch(password);
  }

  // Allowed characters for email input formatter
  static final RegExp emailAllowedCharacters = RegExp(r'[a-zA-Z0-9@._%+-]');
}

