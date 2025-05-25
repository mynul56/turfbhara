import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Providers for app-wide configuration
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);
final localeProvider = StateProvider<Locale?>((ref) => null);

/// Environment configuration
class AppConfig {
  static const bool isDevelopment = true;
  static const bool enableLogging = true;
  static const bool enableCrashlytics = true;
  static const bool enableAnalytics = true;
  
  // API Configuration
  static const String apiBaseUrl = 'https://api.turfbhara.com';
  static const Duration apiTimeout = Duration(seconds: 30);
  
  // Cache Configuration
  static const Duration cacheValidityDuration = Duration(hours: 24);
  static const int maxCacheSize = 100 * 1024 * 1024; // 100MB
  
  // App Store URLs
  static const String playStoreUrl = 'https://play.google.com/store/apps/details?id=com.turfbhara.app';
  static const String appStoreUrl = 'https://apps.apple.com/app/turf-bhara/id123456789';
  
  // Social Media URLs
  static const String websiteUrl = 'https://turfbhara.com';
  static const String privacyPolicyUrl = 'https://turfbhara.com/privacy';
  static const String termsOfServiceUrl = 'https://turfbhara.com/terms';
  
  // Support
  static const String supportEmail = 'support@turfbhara.com';
  static const String supportPhone = '+880-1234-567890';
}