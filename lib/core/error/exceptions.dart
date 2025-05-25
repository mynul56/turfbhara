// Base Exception Classes
abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic details;
  
  const AppException({
    required this.message,
    this.code,
    this.details,
  });
  
  @override
  String toString() {
    return 'AppException: $message${code != null ? ' (Code: $code)' : ''}';
  }
}

// Server Exceptions
class ServerException extends AppException {
  const ServerException({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class NetworkException extends AppException {
  const NetworkException({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class TimeoutException extends AppException {
  const TimeoutException({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

// Authentication Exceptions
class AuthException extends AppException {
  const AuthException({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class UnauthorizedException extends AppException {
  const UnauthorizedException({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class ForbiddenException extends AppException {
  const ForbiddenException({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class TokenExpiredException extends AppException {
  const TokenExpiredException({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

// Validation Exceptions
class ValidationException extends AppException {
  const ValidationException({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class InvalidInputException extends AppException {
  const InvalidInputException({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class InvalidEmailException extends AppException {
  const InvalidEmailException({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class InvalidPhoneException extends AppException {
  const InvalidPhoneException({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class WeakPasswordException extends AppException {
  const WeakPasswordException({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

// Data Exceptions
class CacheException extends AppException {
  const CacheException({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class DatabaseException extends AppException {
  const DatabaseException({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class StorageException extends AppException {
  const StorageException({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class SerializationException extends AppException {
  const SerializationException({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

// Business Logic Exceptions
class BookingException extends AppException {
  const BookingException({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class PaymentException extends AppException {
  const PaymentException({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class TurfNotAvailableException extends AppException {
  const TurfNotAvailableException({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class SlotNotAvailableException extends AppException {
  const SlotNotAvailableException({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class BookingConflictException extends AppException {
  const BookingConflictException({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class CancellationException extends AppException {
  const CancellationException({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

// Location Exceptions
class LocationException extends AppException {
  const LocationException({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class PermissionException extends AppException {
  const PermissionException({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class LocationServiceDisabledException extends AppException {
  const LocationServiceDisabledException({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

// File Exceptions
class FileException extends AppException {
  const FileException({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class ImageException extends AppException {
  const ImageException({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class FileUploadException extends AppException {
  const FileUploadException({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class FileSizeException extends AppException {
  const FileSizeException({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class FileFormatException extends AppException {
  const FileFormatException({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

// Generic Exceptions
class NotFoundException extends AppException {
  const NotFoundException({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class ConflictException extends AppException {
  const ConflictException({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class RateLimitException extends AppException {
  const RateLimitException({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class MaintenanceException extends AppException {
  const MaintenanceException({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class UnknownException extends AppException {
  const UnknownException({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

// Notification Exceptions
class NotificationException extends AppException {
  const NotificationException({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class PushNotificationException extends AppException {
  const PushNotificationException({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

// Firebase Specific Exceptions
class FirebaseException extends AppException {
  const FirebaseException({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class FirestoreException extends AppException {
  const FirestoreException({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class FirebaseAuthException extends AppException {
  const FirebaseAuthException({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class FirebaseStorageException extends AppException {
  const FirebaseStorageException({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class FirebaseFunctionsException extends AppException {
  const FirebaseFunctionsException({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

// Payment Gateway Specific Exceptions
class BkashException extends AppException {
  const BkashException({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class NagadException extends AppException {
  const NagadException({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class RocketException extends AppException {
  const RocketException({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class StripeException extends AppException {
  const StripeException({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class PaymentGatewayException extends AppException {
  const PaymentGatewayException({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class PaymentDeclinedException extends AppException {
  const PaymentDeclinedException({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class InsufficientFundsException extends AppException {
  const InsufficientFundsException({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

// Helper class for creating exceptions from different sources
class ExceptionFactory {
  static AppException fromDioError(dynamic error) {
    if (error.response != null) {
      final statusCode = error.response?.statusCode ?? 0;
      final message = error.response?.data?['message'] ?? error.message ?? 'Unknown error';
      
      switch (statusCode) {
        case 400:
          return ValidationException(
            message: message,
            code: 'BAD_REQUEST',
            details: error.response?.data,
          );
        case 401:
          return UnauthorizedException(
            message: message,
            code: 'UNAUTHORIZED',
            details: error.response?.data,
          );
        case 403:
          return ForbiddenException(
            message: message,
            code: 'FORBIDDEN',
            details: error.response?.data,
          );
        case 404:
          return NotFoundException(
            message: message,
            code: 'NOT_FOUND',
            details: error.response?.data,
          );
        case 409:
          return ConflictException(
            message: message,
            code: 'CONFLICT',
            details: error.response?.data,
          );
        case 429:
          return RateLimitException(
            message: message,
            code: 'RATE_LIMIT',
            details: error.response?.data,
          );
        case 500:
        case 502:
        case 503:
        case 504:
          return ServerException(
            message: message,
            code: 'SERVER_ERROR',
            details: error.response?.data,
          );
        default:
          return ServerException(
            message: message,
            code: 'HTTP_ERROR',
            details: error.response?.data,
          );
      }
    } else {
      // Network error
      return NetworkException(
        message: 'Network error: ${error.message}',
        code: 'NETWORK_ERROR',
        details: error,
      );
    }
  }
  
  static AppException fromFirebaseAuthError(dynamic error) {
    final code = error.code ?? 'unknown';
    final message = error.message ?? 'Authentication error occurred';
    
    switch (code) {
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-email':
      case 'user-disabled':
        return AuthException(
          message: message,
          code: code,
          details: error,
        );
      case 'email-already-in-use':
        return ConflictException(
          message: message,
          code: code,
          details: error,
        );
      case 'weak-password':
        return WeakPasswordException(
          message: message,
          code: code,
          details: error,
        );
      case 'network-request-failed':
        return NetworkException(
          message: message,
          code: code,
          details: error,
        );
      case 'too-many-requests':
        return RateLimitException(
          message: message,
          code: code,
          details: error,
        );
      default:
        return FirebaseAuthException(
          message: message,
          code: code,
          details: error,
        );
    }
  }
  
  static AppException fromFirestoreError(dynamic error) {
    final code = error.code ?? 'unknown';
    final message = error.message ?? 'Firestore error occurred';
    
    switch (code) {
      case 'permission-denied':
        return ForbiddenException(
          message: message,
          code: code,
          details: error,
        );
      case 'not-found':
        return NotFoundException(
          message: message,
          code: code,
          details: error,
        );
      case 'already-exists':
        return ConflictException(
          message: message,
          code: code,
          details: error,
        );
      case 'resource-exhausted':
        return RateLimitException(
          message: message,
          code: code,
          details: error,
        );
      case 'unavailable':
        return ServerException(
          message: message,
          code: code,
          details: error,
        );
      case 'deadline-exceeded':
        return TimeoutException(
          message: message,
          code: code,
          details: error,
        );
      default:
        return FirestoreException(
          message: message,
          code: code,
          details: error,
        );
    }
  }
  
  static AppException fromGenericError(dynamic error) {
    if (error is AppException) {
      return error;
    }
    
    if (error is Exception) {
      return UnknownException(
        message: 'An unexpected error occurred: ${error.toString()}',
        code: 'UNKNOWN_ERROR',
        details: error,
      );
    }
    
    return UnknownException(
      message: 'An unexpected error occurred: ${error.toString()}',
      code: 'UNKNOWN_ERROR',
      details: error,
    );
  }
}