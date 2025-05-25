import '../constants/app_constants.dart';

class Validators {
  // Email validation
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    
    if (!RegExp(AppConstants.emailRegex).hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    
    return null;
  }
  
  // Password validation
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    
    if (value.length < AppConstants.minPasswordLength) {
      return 'Password must be at least ${AppConstants.minPasswordLength} characters';
    }
    
    if (value.length > AppConstants.maxPasswordLength) {
      return 'Password must not exceed ${AppConstants.maxPasswordLength} characters';
    }
    
    if (!RegExp(AppConstants.passwordRegex).hasMatch(value)) {
      return 'Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character';
    }
    
    return null;
  }
  
  // Confirm password validation
  static String? confirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    
    if (value != password) {
      return 'Passwords do not match';
    }
    
    return null;
  }
  
  // Phone number validation (Bangladesh format)
  static String? phoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    
    // Remove any spaces, dashes, or parentheses
    final cleanedValue = value.replaceAll(RegExp(r'[\s\-\(\)]'), '');
    
    if (!RegExp(AppConstants.phoneRegex).hasMatch(cleanedValue)) {
      return 'Please enter a valid Bangladesh phone number';
    }
    
    return null;
  }
  
  // Name validation
  static String? name(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    
    if (value.trim().length > 50) {
      return 'Name must not exceed 50 characters';
    }
    
    if (!RegExp(r'^[a-zA-Z\s\u0980-\u09FF]+$').hasMatch(value.trim())) {
      return 'Name can only contain letters and spaces';
    }
    
    return null;
  }
  
  // Required field validation
  static String? required(String? value, [String? fieldName]) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    return null;
  }
  
  // Minimum length validation
  static String? minLength(String? value, int minLength, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return null; // Let required validator handle this
    }
    
    if (value.length < minLength) {
      return '${fieldName ?? 'This field'} must be at least $minLength characters';
    }
    
    return null;
  }
  
  // Maximum length validation
  static String? maxLength(String? value, int maxLength, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return null;
    }
    
    if (value.length > maxLength) {
      return '${fieldName ?? 'This field'} must not exceed $maxLength characters';
    }
    
    return null;
  }
  
  // Numeric validation
  static String? numeric(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return null;
    }
    
    if (double.tryParse(value) == null) {
      return '${fieldName ?? 'This field'} must be a valid number';
    }
    
    return null;
  }
  
  // Integer validation
  static String? integer(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return null;
    }
    
    if (int.tryParse(value) == null) {
      return '${fieldName ?? 'This field'} must be a valid integer';
    }
    
    return null;
  }
  
  // Minimum value validation
  static String? minValue(String? value, double minValue, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return null;
    }
    
    final numValue = double.tryParse(value);
    if (numValue == null) {
      return '${fieldName ?? 'This field'} must be a valid number';
    }
    
    if (numValue < minValue) {
      return '${fieldName ?? 'This field'} must be at least $minValue';
    }
    
    return null;
  }
  
  // Maximum value validation
  static String? maxValue(String? value, double maxValue, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return null;
    }
    
    final numValue = double.tryParse(value);
    if (numValue == null) {
      return '${fieldName ?? 'This field'} must be a valid number';
    }
    
    if (numValue > maxValue) {
      return '${fieldName ?? 'This field'} must not exceed $maxValue';
    }
    
    return null;
  }
  
  // URL validation
  static String? url(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return null;
    }
    
    if (!RegExp(r'^https?:\/\/.+').hasMatch(value)) {
      return '${fieldName ?? 'This field'} must be a valid URL';
    }
    
    return null;
  }
  
  // Date validation
  static String? date(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return null;
    }
    
    try {
      DateTime.parse(value);
      return null;
    } catch (e) {
      return '${fieldName ?? 'This field'} must be a valid date';
    }
  }
  
  // Future date validation
  static String? futureDate(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return null;
    }
    
    try {
      final date = DateTime.parse(value);
      if (date.isBefore(DateTime.now())) {
        return '${fieldName ?? 'This field'} must be a future date';
      }
      return null;
    } catch (e) {
      return '${fieldName ?? 'This field'} must be a valid date';
    }
  }
  
  // Past date validation
  static String? pastDate(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return null;
    }
    
    try {
      final date = DateTime.parse(value);
      if (date.isAfter(DateTime.now())) {
        return '${fieldName ?? 'This field'} must be a past date';
      }
      return null;
    } catch (e) {
      return '${fieldName ?? 'This field'} must be a valid date';
    }
  }
  
  // Age validation (minimum age)
  static String? minimumAge(String? value, int minimumAge, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return null;
    }
    
    try {
      final birthDate = DateTime.parse(value);
      final age = DateTime.now().difference(birthDate).inDays ~/ 365;
      
      if (age < minimumAge) {
        return 'You must be at least $minimumAge years old';
      }
      return null;
    } catch (e) {
      return '${fieldName ?? 'This field'} must be a valid date';
    }
  }
  
  // Credit card validation (basic Luhn algorithm)
  static String? creditCard(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return null;
    }
    
    // Remove spaces and dashes
    final cleanedValue = value.replaceAll(RegExp(r'[\s\-]'), '');
    
    if (!RegExp(r'^\d{13,19}$').hasMatch(cleanedValue)) {
      return '${fieldName ?? 'Credit card number'} must be 13-19 digits';
    }
    
    // Luhn algorithm
    int sum = 0;
    bool alternate = false;
    
    for (int i = cleanedValue.length - 1; i >= 0; i--) {
      int digit = int.parse(cleanedValue[i]);
      
      if (alternate) {
        digit *= 2;
        if (digit > 9) {
          digit = (digit % 10) + 1;
        }
      }
      
      sum += digit;
      alternate = !alternate;
    }
    
    if (sum % 10 != 0) {
      return '${fieldName ?? 'Credit card number'} is invalid';
    }
    
    return null;
  }
  
  // CVV validation
  static String? cvv(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return null;
    }
    
    if (!RegExp(r'^\d{3,4}$').hasMatch(value)) {
      return '${fieldName ?? 'CVV'} must be 3 or 4 digits';
    }
    
    return null;
  }
  
  // Expiry date validation (MM/YY format)
  static String? expiryDate(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return null;
    }
    
    if (!RegExp(r'^(0[1-9]|1[0-2])\/\d{2}$').hasMatch(value)) {
      return '${fieldName ?? 'Expiry date'} must be in MM/YY format';
    }
    
    final parts = value.split('/');
    final month = int.parse(parts[0]);
    final year = int.parse('20${parts[1]}');
    
    final now = DateTime.now();
    final expiryDate = DateTime(year, month + 1, 0); // Last day of the month
    
    if (expiryDate.isBefore(now)) {
      return '${fieldName ?? 'Card'} has expired';
    }
    
    return null;
  }
  
  // OTP validation
  static String? otp(String? value, [int length = 6]) {
    if (value == null || value.isEmpty) {
      return 'OTP is required';
    }
    
    if (value.length != length) {
      return 'OTP must be $length digits';
    }
    
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'OTP must contain only numbers';
    }
    
    return null;
  }
  
  // Combine multiple validators
  static String? Function(String?) combine(List<String? Function(String?)> validators) {
    return (String? value) {
      for (final validator in validators) {
        final result = validator(value);
        if (result != null) {
          return result;
        }
      }
      return null;
    };
  }
  
  // Custom regex validation
  static String? regex(String? value, String pattern, String errorMessage) {
    if (value == null || value.isEmpty) {
      return null;
    }
    
    if (!RegExp(pattern).hasMatch(value)) {
      return errorMessage;
    }
    
    return null;
  }
  
  // Bangladesh National ID validation
  static String? nationalId(String? value) {
    if (value == null || value.isEmpty) {
      return 'National ID is required';
    }
    
    // Remove any spaces or dashes
    final cleanedValue = value.replaceAll(RegExp(r'[\s\-]'), '');
    
    // Bangladesh NID is either 10, 13, or 17 digits
    if (!RegExp(r'^\d{10}$|^\d{13}$|^\d{17}$').hasMatch(cleanedValue)) {
      return 'Please enter a valid National ID';
    }
    
    return null;
  }
  
  // Turf name validation
  static String? turfName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Turf name is required';
    }
    
    if (value.trim().length < 3) {
      return 'Turf name must be at least 3 characters';
    }
    
    if (value.trim().length > 100) {
      return 'Turf name must not exceed 100 characters';
    }
    
    return null;
  }
  
  // Price validation
  static String? price(String? value) {
    if (value == null || value.isEmpty) {
      return 'Price is required';
    }
    
    final price = double.tryParse(value);
    if (price == null) {
      return 'Please enter a valid price';
    }
    
    if (price < 0) {
      return 'Price cannot be negative';
    }
    
    if (price > 10000) {
      return 'Price seems too high';
    }
    
    return null;
  }
  
  // Rating validation
  static String? rating(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    
    final rating = double.tryParse(value);
    if (rating == null) {
      return 'Please enter a valid rating';
    }
    
    if (rating < 1 || rating > 5) {
      return 'Rating must be between 1 and 5';
    }
    
    return null;
  }
  
  // Address validation
  static String? address(String? value) {
    if (value == null || value.isEmpty) {
      return 'Address is required';
    }
    
    if (value.trim().length < 10) {
      return 'Please enter a complete address';
    }
    
    if (value.trim().length > 200) {
      return 'Address is too long';
    }
    
    return null;
  }
}

// Validation result class
class ValidationResult {
  final bool isValid;
  final String? error;
  
  const ValidationResult({required this.isValid, this.error});
  
  factory ValidationResult.valid() {
    return const ValidationResult(isValid: true);
  }
  
  factory ValidationResult.invalid(String error) {
    return ValidationResult(isValid: false, error: error);
  }
}

// Form validation helper
class FormValidationHelper {
  static Map<String, String> validateForm(Map<String, dynamic> data, Map<String, List<String? Function(String?)>> rules) {
    final errors = <String, String>{};
    
    for (final entry in rules.entries) {
      final field = entry.key;
      final validators = entry.value;
      final value = data[field]?.toString();
      
      for (final validator in validators) {
        final error = validator(value);
        if (error != null) {
          errors[field] = error;
          break; // Stop at first error for this field
        }
      }
    }
    
    return errors;
  }
  
  static bool isFormValid(Map<String, String> errors) {
    return errors.isEmpty;
  }
}