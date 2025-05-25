import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final String? code;
  final dynamic details;
  
  const Failure({
    required this.message,
    this.code,
    this.details,
  });
  
  @override
  List<Object?> get props => [message, code, details];
}

// Server Failures
class ServerFailure extends Failure {
  const ServerFailure({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class NetworkFailure extends Failure {
  const NetworkFailure({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class TimeoutFailure extends Failure {
  const TimeoutFailure({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

// Authentication Failures
class AuthFailure extends Failure {
  const AuthFailure({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class ForbiddenFailure extends Failure {
  const ForbiddenFailure({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

// Validation Failures
class ValidationFailure extends Failure {
  const ValidationFailure({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class InvalidInputFailure extends Failure {
  const InvalidInputFailure({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

// Data Failures
class CacheFailure extends Failure {
  const CacheFailure({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class StorageFailure extends Failure {
  const StorageFailure({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

// Business Logic Failures
class BookingFailure extends Failure {
  const BookingFailure({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class PaymentFailure extends Failure {
  const PaymentFailure({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class TurfNotAvailableFailure extends Failure {
  const TurfNotAvailableFailure({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class SlotNotAvailableFailure extends Failure {
  const SlotNotAvailableFailure({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

// Location Failures
class LocationFailure extends Failure {
  const LocationFailure({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class PermissionFailure extends Failure {
  const PermissionFailure({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

// File Failures
class FileFailure extends Failure {
  const FileFailure({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class ImageFailure extends Failure {
  const ImageFailure({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

// Generic Failures
class UnknownFailure extends Failure {
  const UnknownFailure({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class ConflictFailure extends Failure {
  const ConflictFailure({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class RateLimitFailure extends Failure {
  const RateLimitFailure({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class MaintenanceFailure extends Failure {
  const MaintenanceFailure({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

// Notification Failures
class NotificationFailure extends Failure {
  const NotificationFailure({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

// Firebase Specific Failures
class FirebaseFailure extends Failure {
  const FirebaseFailure({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class FirestoreFailure extends Failure {
  const FirestoreFailure({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class FirebaseAuthFailure extends Failure {
  const FirebaseAuthFailure({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class FirebaseStorageFailure extends Failure {
  const FirebaseStorageFailure({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

// Payment Gateway Specific Failures
class BkashFailure extends Failure {
  const BkashFailure({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class NagadFailure extends Failure {
  const NagadFailure({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class RocketFailure extends Failure {
  const RocketFailure({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

class StripeFailure extends Failure {
  const StripeFailure({
    required String message,
    String? code,
    dynamic details,
  }) : super(message: message, code: code, details: details);
}

// Helper class for creating failures from different sources
class FailureFactory {
  static Failure fromException(Exception exception) {
    if (exception is FormatException) {
      return ValidationFailure(
        message: 'Invalid data format: ${exception.message}',
        code: 'FORMAT_ERROR',
        details: exception,
      );
    }
    
    return UnknownFailure(
      message: 'An unexpected error occurred: ${exception.toString()}',
      code: 'UNKNOWN_ERROR',
      details: exception,
    );
  }
  
  static Failure fromError(Error error) {
    return UnknownFailure(
      message: 'An unexpected error occurred: ${error.toString()}',
      code: 'UNKNOWN_ERROR',
      details: error,
    );
  }
  
  static Failure fromHttpStatusCode(int statusCode, String message) {
    switch (statusCode) {
      case 400:
        return ValidationFailure(
          message: message,
          code: 'BAD_REQUEST',
          details: statusCode,
        );
      case 401:
        return UnauthorizedFailure(
          message: message,
          code: 'UNAUTHORIZED',
          details: statusCode,
        );
      case 403:
        return ForbiddenFailure(
          message: message,
          code: 'FORBIDDEN',
          details: statusCode,
        );
      case 404:
        return NotFoundFailure(
          message: message,
          code: 'NOT_FOUND',
          details: statusCode,
        );
      case 409:
        return ConflictFailure(
          message: message,
          code: 'CONFLICT',
          details: statusCode,
        );
      case 429:
        return RateLimitFailure(
          message: message,
          code: 'RATE_LIMIT',
          details: statusCode,
        );
      case 500:
      case 502:
      case 503:
      case 504:
        return ServerFailure(
          message: message,
          code: 'SERVER_ERROR',
          details: statusCode,
        );
      default:
        return UnknownFailure(
          message: message,
          code: 'HTTP_ERROR',
          details: statusCode,
        );
    }
  }
  
  static Failure fromFirebaseAuthCode(String code, String message) {
    switch (code) {
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-email':
      case 'user-disabled':
        return AuthFailure(
          message: message,
          code: code,
        );
      case 'email-already-in-use':
        return ConflictFailure(
          message: message,
          code: code,
        );
      case 'weak-password':
        return ValidationFailure(
          message: message,
          code: code,
        );
      case 'network-request-failed':
        return NetworkFailure(
          message: message,
          code: code,
        );
      case 'too-many-requests':
        return RateLimitFailure(
          message: message,
          code: code,
        );
      default:
        return FirebaseAuthFailure(
          message: message,
          code: code,
        );
    }
  }
  
  static Failure fromFirestoreCode(String code, String message) {
    switch (code) {
      case 'permission-denied':
        return ForbiddenFailure(
          message: message,
          code: code,
        );
      case 'not-found':
        return NotFoundFailure(
          message: message,
          code: code,
        );
      case 'already-exists':
        return ConflictFailure(
          message: message,
          code: code,
        );
      case 'resource-exhausted':
        return RateLimitFailure(
          message: message,
          code: code,
        );
      case 'unavailable':
        return ServerFailure(
          message: message,
          code: code,
        );
      case 'deadline-exceeded':
        return TimeoutFailure(
          message: message,
          code: code,
        );
      default:
        return FirestoreFailure(
          message: message,
          code: code,
        );
    }
  }
}