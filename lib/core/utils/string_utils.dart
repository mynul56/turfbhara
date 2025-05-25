import 'dart:convert';
import 'dart:math';

class StringUtils {
  // Check if string is null or empty
  static bool isNullOrEmpty(String? value) {
    return value == null || value.isEmpty;
  }
  
  // Check if string is null, empty, or whitespace
  static bool isNullOrWhitespace(String? value) {
    return value == null || value.trim().isEmpty;
  }
  
  // Capitalize first letter
  static String capitalize(String value) {
    if (isNullOrEmpty(value)) return value;
    return value[0].toUpperCase() + value.substring(1).toLowerCase();
  }
  
  // Capitalize each word
  static String capitalizeWords(String value) {
    if (isNullOrEmpty(value)) return value;
    return value.split(' ').map((word) => capitalize(word)).join(' ');
  }
  
  // Convert to camelCase
  static String toCamelCase(String value) {
    if (isNullOrEmpty(value)) return value;
    final words = value.split(RegExp(r'[\s_-]+'));
    if (words.isEmpty) return value;
    
    final first = words.first.toLowerCase();
    final rest = words.skip(1).map((word) => capitalize(word));
    return first + rest.join('');
  }
  
  // Convert to PascalCase
  static String toPascalCase(String value) {
    if (isNullOrEmpty(value)) return value;
    final words = value.split(RegExp(r'[\s_-]+'));
    return words.map((word) => capitalize(word)).join('');
  }
  
  // Convert to snake_case
  static String toSnakeCase(String value) {
    if (isNullOrEmpty(value)) return value;
    return value
        .replaceAllMapped(RegExp(r'[A-Z]'), (match) => '_${match.group(0)!.toLowerCase()}')
        .replaceAll(RegExp(r'[\s-]+'), '_')
        .replaceAll(RegExp(r'^_+|_+\$'), '')
        .toLowerCase();
  }
  
  // Convert to kebab-case
  static String toKebabCase(String value) {
    if (isNullOrEmpty(value)) return value;
    return value
        .replaceAllMapped(RegExp(r'[A-Z]'), (match) => '-${match.group(0)!.toLowerCase()}')
        .replaceAll(RegExp(r'[\s_]+'), '-')
        .replaceAll(RegExp(r'^-+|-+\$'), '')
        .toLowerCase();
  }
  
  // Remove all whitespace
  static String removeWhitespace(String value) {
    return value.replaceAll(RegExp(r'\s+'), '');
  }
  
  // Remove extra whitespace (multiple spaces become single space)
  static String removeExtraWhitespace(String value) {
    return value.replaceAll(RegExp(r'\s+'), ' ').trim();
  }
  
  // Truncate string with ellipsis
  static String truncate(String value, int maxLength, {String suffix = '...'}) {
    if (value.length <= maxLength) return value;
    return value.substring(0, maxLength - suffix.length) + suffix;
  }
  
  // Truncate string at word boundary
  static String truncateAtWord(String value, int maxLength, {String suffix = '...'}) {
    if (value.length <= maxLength) return value;
    
    final truncated = value.substring(0, maxLength - suffix.length);
    final lastSpace = truncated.lastIndexOf(' ');
    
    if (lastSpace > 0) {
      return truncated.substring(0, lastSpace) + suffix;
    }
    
    return truncated + suffix;
  }
  
  // Extract initials from name
  static String getInitials(String name, {int maxInitials = 2}) {
    if (isNullOrEmpty(name)) return '';
    
    final words = name.trim().split(RegExp(r'\s+'));
    final initials = words
        .take(maxInitials)
        .map((word) => word.isNotEmpty ? word[0].toUpperCase() : '')
        .where((initial) => initial.isNotEmpty)
        .join('');
    
    return initials;
  }
  
  // Generate random string
  static String generateRandomString(int length, {bool includeNumbers = true, bool includeSymbols = false}) {
    const letters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const numbers = '0123456789';
    const symbols = '!@#\$%^&*()_+-=[]{}|;:,.<>?';
    
    String chars = letters;
    if (includeNumbers) chars += numbers;
    if (includeSymbols) chars += symbols;
    
    final random = Random();
    return String.fromCharCodes(
      Iterable.generate(length, (_) => chars.codeUnitAt(random.nextInt(chars.length))),
    );
  }
  
  // Generate random ID
  static String generateId({int length = 8}) {
    return generateRandomString(length, includeNumbers: true, includeSymbols: false);
  }
  
  // Mask string (e.g., for phone numbers, emails)
  static String mask(String value, {int visibleStart = 2, int visibleEnd = 2, String maskChar = '*'}) {
    if (value.length <= visibleStart + visibleEnd) {
      return value;
    }
    
    final start = value.substring(0, visibleStart);
    final end = value.substring(value.length - visibleEnd);
    final middle = maskChar * (value.length - visibleStart - visibleEnd);
    
    return start + middle + end;
  }
  
  // Mask email
  static String maskEmail(String email) {
    if (!email.contains('@')) return email;
    
    final parts = email.split('@');
    final username = parts[0];
    final domain = parts[1];
    
    if (username.length <= 2) {
      return email;
    }
    
    final maskedUsername = mask(username, visibleStart: 1, visibleEnd: 1);
    return '$maskedUsername@$domain';
  }
  
  // Mask phone number
  static String maskPhoneNumber(String phoneNumber) {
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'[^0-9+]'), '');
    
    if (cleanNumber.length < 6) {
      return phoneNumber;
    }
    
    return mask(cleanNumber, visibleStart: 3, visibleEnd: 2);
  }
  
  // Format phone number for Bangladesh
  static String formatBangladeshPhone(String phoneNumber) {
    // Remove all non-digit characters except +
    String cleaned = phoneNumber.replaceAll(RegExp(r'[^0-9+]'), '');
    
    // Remove leading zeros
    cleaned = cleaned.replaceAll(RegExp(r'^0+'), '');
    
    // Add country code if not present
    if (!cleaned.startsWith('+880') && !cleaned.startsWith('880')) {
      if (cleaned.startsWith('1') && cleaned.length == 10) {
        cleaned = '880$cleaned';
      } else if (cleaned.length == 11 && cleaned.startsWith('01')) {
        cleaned = '880${cleaned.substring(1)}';
      }
    }
    
    // Remove +880 prefix for formatting
    if (cleaned.startsWith('+880')) {
      cleaned = cleaned.substring(4);
    } else if (cleaned.startsWith('880')) {
      cleaned = cleaned.substring(3);
    }
    
    // Format as +880 1XXX-XXXXXX
    if (cleaned.length == 10 && cleaned.startsWith('1')) {
      return '+880 ${cleaned.substring(0, 4)}-${cleaned.substring(4)}';
    }
    
    return phoneNumber; // Return original if can't format
  }
  
  // Extract numbers from string
  static String extractNumbers(String value) {
    return value.replaceAll(RegExp(r'[^0-9]'), '');
  }
  
  // Extract letters from string
  static String extractLetters(String value) {
    return value.replaceAll(RegExp(r'[^a-zA-Z]'), '');
  }
  
  // Check if string contains only numbers
  static bool isNumeric(String value) {
    return RegExp(r'^[0-9]+\$').hasMatch(value);
  }
  
  // Check if string contains only letters
  static bool isAlpha(String value) {
    return RegExp(r'^[a-zA-Z]+\$').hasMatch(value);
  }
  
  // Check if string contains only letters and numbers
  static bool isAlphaNumeric(String value) {
    return RegExp(r'^[a-zA-Z0-9]+\$').hasMatch(value);
  }
  
  // Check if string is a valid email
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}\$').hasMatch(email);
  }
  
  // Check if string is a valid URL
  static bool isValidUrl(String url) {
    return RegExp(r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)\$').hasMatch(url);
  }
  
  // Check if string is a valid Bangladesh phone number
  static bool isValidBangladeshPhone(String phoneNumber) {
    final cleaned = phoneNumber.replaceAll(RegExp(r'[^0-9+]'), '');
    
    // Check various formats
    final patterns = [
      RegExp(r'^\+8801[3-9]\d{8}\$'), // +8801XXXXXXXXX
      RegExp(r'^8801[3-9]\d{8}\$'),  // 8801XXXXXXXXX
      RegExp(r'^01[3-9]\d{8}\$'),    // 01XXXXXXXXX
      RegExp(r'^1[3-9]\d{8}\$'),     // 1XXXXXXXXX
    ];
    
    return patterns.any((pattern) => pattern.hasMatch(cleaned));
  }
  
  // Convert string to slug (URL-friendly)
  static String toSlug(String value) {
    return value
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9\s-]'), '')
        .replaceAll(RegExp(r'\s+'), '-')
        .replaceAll(RegExp(r'-+'), '-')
        .replaceAll(RegExp(r'^-+|-+\$'), '');
  }
  
  // Count words in string
  static int countWords(String value) {
    if (isNullOrWhitespace(value)) return 0;
    return value.trim().split(RegExp(r'\s+')).length;
  }
  
  // Count characters (excluding whitespace)
  static int countCharacters(String value, {bool includeWhitespace = true}) {
    if (includeWhitespace) {
      return value.length;
    } else {
      return removeWhitespace(value).length;
    }
  }
  
  // Reverse string
  static String reverse(String value) {
    return value.split('').reversed.join('');
  }
  
  // Check if string is palindrome
  static bool isPalindrome(String value) {
    final cleaned = value.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');
    return cleaned == reverse(cleaned);
  }
  
  // Encode to Base64
  static String encodeBase64(String value) {
    return base64Encode(utf8.encode(value));
  }
  
  // Decode from Base64
  static String decodeBase64(String value) {
    try {
      return utf8.decode(base64Decode(value));
    } catch (e) {
      return '';
    }
  }
  
  // Calculate Levenshtein distance (string similarity)
  static int levenshteinDistance(String a, String b) {
    if (a.isEmpty) return b.length;
    if (b.isEmpty) return a.length;
    
    final matrix = List.generate(
      a.length + 1,
      (i) => List.generate(b.length + 1, (j) => 0),
    );
    
    for (int i = 0; i <= a.length; i++) {
      matrix[i][0] = i;
    }
    
    for (int j = 0; j <= b.length; j++) {
      matrix[0][j] = j;
    }
    
    for (int i = 1; i <= a.length; i++) {
      for (int j = 1; j <= b.length; j++) {
        final cost = a[i - 1] == b[j - 1] ? 0 : 1;
        matrix[i][j] = [
          matrix[i - 1][j] + 1,     // deletion
          matrix[i][j - 1] + 1,     // insertion
          matrix[i - 1][j - 1] + cost, // substitution
        ].reduce((a, b) => a < b ? a : b);
      }
    }
    
    return matrix[a.length][b.length];
  }
  
  // Calculate string similarity percentage
  static double similarity(String a, String b) {
    if (a == b) return 1.0;
    if (a.isEmpty || b.isEmpty) return 0.0;
    
    final distance = levenshteinDistance(a.toLowerCase(), b.toLowerCase());
    final maxLength = [a.length, b.length].reduce((a, b) => a > b ? a : b);
    
    return 1.0 - (distance / maxLength);
  }
  
  // Format currency (Bangladesh Taka)
  static String formatCurrency(double amount, {String symbol = '৳', int decimalPlaces = 2}) {
    final formatted = amount.toStringAsFixed(decimalPlaces);
    final parts = formatted.split('.');
    final integerPart = parts[0];
    final decimalPart = parts.length > 1 ? parts[1] : '';
    
    // Add thousand separators
    final regex = RegExp(r'(\d)(?=(\d{3})+(?!\d))');
    final formattedInteger = integerPart.replaceAllMapped(regex, (match) => '${match.group(1)},');
    
    if (decimalPlaces > 0 && decimalPart.isNotEmpty) {
      return '$symbol$formattedInteger.$decimalPart';
    } else {
      return '$symbol$formattedInteger';
    }
  }
  
  // Format file size
  static String formatFileSize(int bytes) {
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB'];
    
    if (bytes == 0) return '0 B';
    
    final i = (log(bytes) / log(1024)).floor();
    final size = bytes / pow(1024, i);
    
    return '${size.toStringAsFixed(1)} ${suffixes[i]}';
  }
  
  // Highlight search terms in text
  static String highlightSearchTerms(String text, String searchTerm, {String highlightStart = '<mark>', String highlightEnd = '</mark>'}) {
    if (isNullOrEmpty(searchTerm)) return text;
    
    final regex = RegExp(RegExp.escape(searchTerm), caseSensitive: false);
    return text.replaceAllMapped(regex, (match) {
      return '$highlightStart${match.group(0)}$highlightEnd';
    });
  }
  
  // Remove HTML tags
  static String removeHtmlTags(String html) {
    return html.replaceAll(RegExp(r'<[^>]*>'), '');
  }
  
  // Escape HTML characters
  static String escapeHtml(String text) {
    return text
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#x27;');
  }
  
  // Unescape HTML characters
  static String unescapeHtml(String html) {
    return html
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&quot;', '"')
        .replaceAll('&#x27;', "'");
  }
  
  // Generate username from name
  static String generateUsername(String name, {int maxLength = 20}) {
    final cleaned = name
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9\s]'), '')
        .replaceAll(RegExp(r'\s+'), '_');
    
    if (cleaned.length <= maxLength) {
      return cleaned;
    }
    
    return cleaned.substring(0, maxLength);
  }
  
  // Validate and format Bangladesh NID
  static String? formatBangladeshNID(String nid) {
    final cleaned = extractNumbers(nid);
    
    // Old NID format: 13 digits
    if (cleaned.length == 13) {
      return cleaned;
    }
    
    // New NID format: 10 or 17 digits
    if (cleaned.length == 10 || cleaned.length == 17) {
      return cleaned;
    }
    
    return null; // Invalid NID
  }
  
  // Check if string contains Bengali characters
  static bool containsBengali(String text) {
    return RegExp(r'[\u0980-\u09FF]').hasMatch(text);
  }
  
  // Check if string contains English characters
  static bool containsEnglish(String text) {
    return RegExp(r'[a-zA-Z]').hasMatch(text);
  }
  
  // Convert Bengali numbers to English
  static String bengaliToEnglishNumbers(String text) {
    const bengaliDigits = '০১২৩৪৫৬৭৮৯';
    const englishDigits = '0123456789';
    
    String result = text;
    for (int i = 0; i < bengaliDigits.length; i++) {
      result = result.replaceAll(bengaliDigits[i], englishDigits[i]);
    }
    
    return result;
  }
  
  // Convert English numbers to Bengali
  static String englishToBengaliNumbers(String text) {
    const bengaliDigits = '০১২৩৪৫৬৭৮৯';
    const englishDigits = '0123456789';
    
    String result = text;
    for (int i = 0; i < englishDigits.length; i++) {
      result = result.replaceAll(englishDigits[i], bengaliDigits[i]);
    }
    
    return result;
  }
}