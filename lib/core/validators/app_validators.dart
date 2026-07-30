import 'package:ticketflow/core/functions/is_null_or_empty.dart';
import 'package:ticketflow/core/validators/app_regx.dart';

/// ? Contains all ready-to-use Form Validators for TextFormField
class AppValidators {
  AppValidators._(); // Private constructor to prevent instantiation

  /// Validates email format
  static String? validateEmail(String? value) {
    if (isNullOrEmpty(value)) {
      return 'Email is required';
    } else if (!AppRegex.isEmailValid(value!.trim())) {
      return 'Enter a valid email address';
    }
    return null;
  }

  /// Validates password (8+ chars, at least 1 lowercase letter, at least 1 uppercase letter, 1 digit, at least 1 special character)
  static String? validatePassword(String? value) {
    if (isNullOrEmpty(value)) {
      return 'Password is required';
    } else if (!AppRegex.isPasswordValid(value!.trim())) {
      return 'Password must be at least 8 characters and contain:\n'
          '• Uppercase letter\n'
          '• Lowercase letter\n'
          '• Number\n'
          '• Special character (@\$!%*?&)';
    }
    return null;
  }

  /// Validates that confirm password matches the original
  static String? validateConfirmPassword(String? confirm, String original) {
    if (isNullOrEmpty(confirm)) {
      return 'Please confirm your password';
    } else if (confirm != original) {
      return 'Passwords do not match';
    }
    return null;
  }

  /// Validates that a field is not empty
  static String? validateNotEmpty(
    String? value, [
    String message = 'This field is required',
  ]) {
    if (isNullOrEmpty(value)) {
      return message;
    }
    return null;
  }

  /// Validates ticket subject (min 3 chars)
  static String? validateSubject(String? value) {
    if (isNullOrEmpty(value)) {
      return 'Subject is required';
    } else if (value!.trim().length < 3) {
      return 'Subject must be at least 3 characters long';
    }
    return null;
  }

  /// Validates ticket description (min 10 chars)
  static String? validateDescription(String? value) {
    if (isNullOrEmpty(value)) {
      return 'Description is required';
    } else if (value!.trim().length < 10) {
      return 'Description must be at least 10 characters long';
    }
    return null;
  }
}

