import 'package:flutter/material.dart';

class AppColors {
  // Brand Colors
  static const Color primary = Color(0xFF2E7D32); // Primary Color
  static const Color primaryGreen = primary; // Deep Green
  static const Color primaryLightGreen = Color(0xFF4CAF50); // Light Green
  static const Color accentOrange = Color(0xFFFF6F00); // Orange
  static const Color accentLightOrange = Color(0xFFFF8F00); // Light Orange

  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0xFFFBC02D);
  static const Color info = Color(0xFF0288D1);

  // Surface and OnSurface Colors for Light/Dark themes
  static const Color darkSurface = Color(0xFF121212);
  static const Color lightSurface = Color(0xFFFFFFFF);

  static const Color darkOnSurface = Color(0xFFF5F5F5);
  static const Color lightOnSurface = Color(0xFF222222);

  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey900 = Color(0xFF212121);

  // Payment Colors
  static const Color bkashPink = Color(0xFFE2136E);
  static const Color nagadOrange = Color(0xFFEC1C24);
  static const Color rocketPurple = Color(0xFF8B1538);
  static const Color stripePurple = Color(0xFF635BFF);

  // Status Colors
  static const Color available = Color(0xFF4CAF50);
  static const Color booked = Color(0xFFF44336);
  static const Color pending = Color(0xFFFF9800);
  static const Color confirmed = Color(0xFF2196F3);
  static const Color cancelled = Color(0xFF9E9E9E);

  // Rating Colors
  static const Color ratingGold = Color(0xFFFFD700);
  static const Color ratingGrey = Color(0xFFE0E0E0);

  // Light Color Scheme
  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primaryGreen,
    onPrimary: white,
    primaryContainer: Color(0xFFC8E6C9),
    onPrimaryContainer: Color(0xFF1B5E20),
    secondary: accentOrange,
    onSecondary: white,
    secondaryContainer: Color(0xFFFFE0B2),
    onSecondaryContainer: Color(0xFFE65100),
    tertiary: Color(0xFF9C27B0),
    onTertiary: white,
    tertiaryContainer: Color(0xFFE1BEE7),
    onTertiaryContainer: Color(0xFF4A148C),
    error: Color(0xFFF44336),
    onError: white,
    errorContainer: Color(0xFFFFEBEE),
    onErrorContainer: Color(0xFFB71C1C),
    background: white,
    onBackground: black,
    surface: white,
    onSurface: black,
    surfaceVariant: grey100,
    onSurfaceVariant: grey700,
    outline: grey400,
    outlineVariant: grey200,
    shadow: black,
    scrim: black,
    inverseSurface: grey800,
    onInverseSurface: grey100,
    inversePrimary: Color(0xFF81C784),
    surfaceTint: primaryGreen,
  );

  // Dark Color Scheme
  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF81C784),
    onPrimary: Color(0xFF1B5E20),
    primaryContainer: Color(0xFF2E7D32),
    onPrimaryContainer: Color(0xFFC8E6C9),
    secondary: Color(0xFFFFB74D),
    onSecondary: Color(0xFFE65100),
    secondaryContainer: Color(0xFFFF8F00),
    onSecondaryContainer: Color(0xFFFFE0B2),
    tertiary: Color(0xFFBA68C8),
    onTertiary: Color(0xFF4A148C),
    tertiaryContainer: Color(0xFF6A4C93),
    onTertiaryContainer: Color(0xFFE1BEE7),
    error: Color(0xFFEF5350),
    onError: Color(0xFFB71C1C),
    errorContainer: Color(0xFFD32F2F),
    onErrorContainer: Color(0xFFFFEBEE),
    background: Color(0xFF121212),
    onBackground: white,
    surface: Color(0xFF121212),
    onSurface: white,
    surfaceVariant: grey900,
    onSurfaceVariant: grey300,
    outline: grey700,
    outlineVariant: grey800,
    shadow: black,
    scrim: black,
    inverseSurface: grey100,
    onInverseSurface: grey900,
    inversePrimary: primaryGreen,
    surfaceTint: Color(0xFF81C784),
  );

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryGreen, primaryLightGreen],
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accentOrange, accentLightOrange],
  );

  static const LinearGradient successGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF4CAF50), Color(0xFF8BC34A)],
  );

  static const LinearGradient warningGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFF9800), Color(0xFFFFC107)],
  );

  // Text Colors
  static const Color textPrimaryLight = Color(0xFF212121);
  static const Color textSecondaryLight = Color(0xFF757575);
  static const Color textDisabledLight = Color(0xFFBDBDBD);
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFFBDBDBD);
  static const Color textDisabledDark = Color(0xFF616161);

  // Icon Colors
  static const Color iconPrimaryLight = Color(0xFF212121);
  static const Color iconSecondaryLight = Color(0xFF757575);
  static const Color iconDisabledLight = Color(0xFFBDBDBD);
  static const Color iconPrimaryDark = Color(0xFFFFFFFF);
  static const Color iconSecondaryDark = Color(0xFFBDBDBD);
  static const Color iconDisabledDark = Color(0xFF616161);

  // Special Colors
  static const Color transparent = Colors.transparent;
  static const Color facebook = Color(0xFF1877F2);
  static const Color google = Color(0xFF4285F4);
  static const Color apple = Color(0xFF000000);
  static const Color whatsapp = Color(0xFF25D366);
  static const Color telegram = Color(0xFF0088CC);

  // Map Colors
  static const Color mapMarker = primaryGreen;
  static const Color mapRoute = accentOrange;

  // Chart Colors
  static const List<Color> chartColors = [
    primaryGreen,
    accentOrange,
    Color(0xFF2196F3),
    Color(0xFF9C27B0),
    Color(0xFFFF5722),
    Color(0xFF607D8B),
    Color(0xFF795548),
    Color(0xFFE91E63),
  ];

  // Helper Methods
  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'available':
        return available;
      case 'booked':
        return booked;
      case 'pending':
        return pending;
      case 'confirmed':
        return confirmed;
      case 'cancelled':
        return cancelled;
      default:
        return grey500;
    }
  }

  static Color lighten(Color color, [double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return hslLight.toColor();
  }

  static Color darken(Color color, [double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }
}
