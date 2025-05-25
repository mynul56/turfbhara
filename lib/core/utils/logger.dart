import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import '../constants/app_constants.dart';

class AppLogger {
  static late Logger _logger;
  static bool _isInitialized = false;
  
  // Initialize logger
  static void init() {
    if (_isInitialized) return;
    
    _logger = Logger(
      printer: _getLoggerPrinter(),
      level: _getLogLevel(),
      output: _getLogOutput(),
    );
    
    _isInitialized = true;
    info('Logger initialized');
  }
  
  // Get logger printer based on build mode
  static LogPrinter _getLoggerPrinter() {
    if (kDebugMode) {
      return PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 8,
        lineLength: 120,
        colors: true,
        printEmojis: true,
        printTime: true,
      );
    } else {
      return SimplePrinter(
        colors: false,
        printTime: true,
      );
    }
  }
  
  // Get log level based on build mode
  static Level _getLogLevel() {
    if (kDebugMode) {
      return Level.debug;
    } else if (kProfileMode) {
      return Level.info;
    } else {
      return Level.warning;
    }
  }
  
  // Get log output
  static LogOutput _getLogOutput() {
    if (kDebugMode) {
      return ConsoleOutput();
    } else {
      // In production, you might want to use a file output or remote logging
      return MultiOutput([
        ConsoleOutput(),
        // FileOutput(file: logFile), // Uncomment if you want file logging
      ]);
    }
  }
  
  // Ensure logger is initialized
  static void _ensureInitialized() {
    if (!_isInitialized) {
      init();
    }
  }
  
  // Debug level logging
  static void debug(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _ensureInitialized();
    _logger.d(message, error: error, stackTrace: stackTrace);
    
    if (kDebugMode) {
      developer.log(
        message.toString(),
        name: AppConstants.appName,
        level: 500, // Debug level
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
  
  // Info level logging
  static void info(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _ensureInitialized();
    _logger.i(message, error: error, stackTrace: stackTrace);
    
    developer.log(
      message.toString(),
      name: AppConstants.appName,
      level: 800, // Info level
      error: error,
      stackTrace: stackTrace,
    );
  }
  
  // Warning level logging
  static void warning(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _ensureInitialized();
    _logger.w(message, error: error, stackTrace: stackTrace);
    
    developer.log(
      message.toString(),
      name: AppConstants.appName,
      level: 900, // Warning level
      error: error,
      stackTrace: stackTrace,
    );
  }
  
  // Error level logging
  static void error(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _ensureInitialized();
    _logger.e(message, error: error, stackTrace: stackTrace);
    
    developer.log(
      message.toString(),
      name: AppConstants.appName,
      level: 1000, // Error level
      error: error,
      stackTrace: stackTrace,
    );
  }
  
  // Fatal level logging
  static void fatal(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _ensureInitialized();
    _logger.f(message, error: error, stackTrace: stackTrace);
    
    developer.log(
      message.toString(),
      name: AppConstants.appName,
      level: 1200, // Fatal level
      error: error,
      stackTrace: stackTrace,
    );
  }
  
  // Trace level logging (verbose)
  static void trace(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _ensureInitialized();
    _logger.t(message, error: error, stackTrace: stackTrace);
    
    if (kDebugMode) {
      developer.log(
        message.toString(),
        name: AppConstants.appName,
        level: 300, // Trace level
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
  
  // Log API requests
  static void apiRequest({
    required String method,
    required String url,
    Map<String, dynamic>? headers,
    dynamic body,
  }) {
    if (!kDebugMode) return;
    
    final message = '''API Request:
Method: $method
URL: $url
Headers: $headers
Body: $body''';
    debug(message);
  }
  
  // Log API responses
  static void apiResponse({
    required String method,
    required String url,
    required int statusCode,
    Map<String, dynamic>? headers,
    dynamic body,
    Duration? duration,
  }) {
    if (!kDebugMode) return;
    
    final message = '''API Response:
Method: $method
URL: $url
Status: $statusCode
Duration: ${duration?.inMilliseconds}ms
Headers: $headers
Body: $body''';
    
    if (statusCode >= 200 && statusCode < 300) {
      info(message);
    } else if (statusCode >= 400) {
      error(message);
    } else {
      warning(message);
    }
  }
  
  // Log navigation events
  static void navigation(String from, String to, [Map<String, dynamic>? params]) {
    if (!kDebugMode) return;
    
    final message = 'Navigation: $from -> $to${params != null ? ' with params: $params' : ''}';
    debug(message);
  }
  
  // Log user actions
  static void userAction(String action, [Map<String, dynamic>? details]) {
    final message = 'User Action: $action${details != null ? ' - $details' : ''}';
    info(message);
  }
  
  // Log performance metrics
  static void performance(String operation, Duration duration, [Map<String, dynamic>? details]) {
    final message = 'Performance: $operation took ${duration.inMilliseconds}ms${details != null ? ' - $details' : ''}';
    
    if (duration.inMilliseconds > 1000) {
      warning(message);
    } else {
      info(message);
    }
  }
  
  // Log business events
  static void business(String event, [Map<String, dynamic>? data]) {
    final message = 'Business Event: $event${data != null ? ' - $data' : ''}';
    info(message);
  }
  
  // Log security events
  static void security(String event, [Map<String, dynamic>? details]) {
    final message = 'Security Event: $event${details != null ? ' - $details' : ''}';
    warning(message);
  }
  
  // Log authentication events
  static void auth(String event, [String? userId]) {
    final message = 'Auth Event: $event${userId != null ? ' for user: $userId' : ''}';
    info(message);
  }
  
  // Log payment events
  static void payment(String event, [Map<String, dynamic>? details]) {
    final message = 'Payment Event: $event${details != null ? ' - $details' : ''}';
    info(message);
  }
  
  // Log booking events
  static void booking(String event, [Map<String, dynamic>? details]) {
    final message = 'Booking Event: $event${details != null ? ' - $details' : ''}';
    info(message);
  }
  
  // Log cache events
  static void cache(String event, [Map<String, dynamic>? details]) {
    if (!kDebugMode) return;
    
    final message = 'Cache Event: $event${details != null ? ' - $details' : ''}';
    debug(message);
  }
  
  // Log database events
  static void database(String event, [Map<String, dynamic>? details]) {
    if (!kDebugMode) return;
    
    final message = 'Database Event: $event${details != null ? ' - $details' : ''}';
    debug(message);
  }
  
  // Log Firebase events
  static void firebase(String event, [Map<String, dynamic>? details]) {
    final message = 'Firebase Event: $event${details != null ? ' - $details' : ''}';
    info(message);
  }
  
  // Log widget lifecycle events
  static void widget(String widget, String event, [Map<String, dynamic>? details]) {
    if (!kDebugMode) return;
    
    final message = 'Widget Lifecycle: $widget - $event${details != null ? ' - $details' : ''}';
    trace(message);
  }
  
  // Log state changes
  static void state(String state, String event, [Map<String, dynamic>? details]) {
    if (!kDebugMode) return;
    
    final message = 'State Change: $state - $event${details != null ? ' - $details' : ''}';
    debug(message);
  }
  
  // Close logger
  static void close() {
    if (_isInitialized) {
      _logger.close();
      _isInitialized = false;
    }
  }
}

// Custom log output for file logging
class FileOutput extends LogOutput {
  // TODO: Implement file logging if needed
  @override
  void output(OutputEvent event) {
    // Implement file writing logic here
  }
}

// Log level extension
extension LogLevelExtension on Level {
  String get name {
    switch (this) {
      case Level.trace:
        return 'TRACE';
      case Level.debug:
        return 'DEBUG';
      case Level.info:
        return 'INFO';
      case Level.warning:
        return 'WARNING';
      case Level.error:
        return 'ERROR';
      case Level.fatal:
        return 'FATAL';
      default:
        return 'UNKNOWN';
    }
  }
}

// Logger mixin for easy access in classes
mixin LoggerMixin {
  void logDebug(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    AppLogger.debug('${runtimeType.toString()}: $message', error, stackTrace);
  }
  
  void logInfo(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    AppLogger.info('${runtimeType.toString()}: $message', error, stackTrace);
  }
  
  void logWarning(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    AppLogger.warning('${runtimeType.toString()}: $message', error, stackTrace);
  }
  
  void logError(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    AppLogger.error('${runtimeType.toString()}: $message', error, stackTrace);
  }
  
  void logFatal(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    AppLogger.fatal('${runtimeType.toString()}: $message', error, stackTrace);
  }
}