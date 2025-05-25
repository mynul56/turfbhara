import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceUtils {
  static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();
  
  // Platform checks
  static bool get isAndroid => Platform.isAndroid;
  static bool get isIOS => Platform.isIOS;
  static bool get isWeb => kIsWeb;
  static bool get isMobile => isAndroid || isIOS;
  static bool get isDesktop => Platform.isWindows || Platform.isMacOS || Platform.isLinux;
  
  // Screen information
  static Size get screenSize => ui.window.physicalSize / ui.window.devicePixelRatio;
  static double get screenWidth => screenSize.width;
  static double get screenHeight => screenSize.height;
  static double get devicePixelRatio => ui.window.devicePixelRatio;
  static Brightness get platformBrightness => ui.window.platformBrightness;
  
  // Screen size categories
  static bool get isSmallScreen => screenWidth < 600;
  static bool get isMediumScreen => screenWidth >= 600 && screenWidth < 1200;
  static bool get isLargeScreen => screenWidth >= 1200;
  
  static bool get isTablet => screenWidth >= 600;
  static bool get isPhone => screenWidth < 600;
  
  // Orientation
  static bool get isPortrait => screenHeight > screenWidth;
  static bool get isLandscape => screenWidth > screenHeight;
  
  // Safe area
  static EdgeInsets getSafeArea(BuildContext context) {
    return MediaQuery.of(context).padding;
  }
  
  static double getStatusBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }
  
  static double getBottomSafeArea(BuildContext context) {
    return MediaQuery.of(context).padding.bottom;
  }
  
  // Device information
  static Future<Map<String, dynamic>> getDeviceInfo() async {
    final Map<String, dynamic> deviceData = {};
    
    try {
      if (isAndroid) {
        final androidInfo = await _deviceInfo.androidInfo;
        deviceData.addAll({
          'platform': 'Android',
          'model': androidInfo.model,
          'manufacturer': androidInfo.manufacturer,
          'brand': androidInfo.brand,
          'device': androidInfo.device,
          'product': androidInfo.product,
          'androidId': androidInfo.id,
          'androidVersion': androidInfo.version.release,
          'sdkInt': androidInfo.version.sdkInt,
          'isPhysicalDevice': androidInfo.isPhysicalDevice,
          'fingerprint': androidInfo.fingerprint,
          'hardware': androidInfo.hardware,
          'host': androidInfo.host,
          'tags': androidInfo.tags,
          'type': androidInfo.type,
        });
      } else if (isIOS) {
        final iosInfo = await _deviceInfo.iosInfo;
        deviceData.addAll({
          'platform': 'iOS',
          'model': iosInfo.model,
          'name': iosInfo.name,
          'systemName': iosInfo.systemName,
          'systemVersion': iosInfo.systemVersion,
          'localizedModel': iosInfo.localizedModel,
          'identifierForVendor': iosInfo.identifierForVendor,
          'isPhysicalDevice': iosInfo.isPhysicalDevice,
          'utsname': {
            'machine': iosInfo.utsname.machine,
            'nodename': iosInfo.utsname.nodename,
            'release': iosInfo.utsname.release,
            'sysname': iosInfo.utsname.sysname,
            'version': iosInfo.utsname.version,
          },
        });
      } else if (isWeb) {
        final webInfo = await _deviceInfo.webBrowserInfo;
        deviceData.addAll({
          'platform': 'Web',
          'browserName': webInfo.browserName.name,
          'appCodeName': webInfo.appCodeName,
          'appName': webInfo.appName,
          'appVersion': webInfo.appVersion,
          'deviceMemory': webInfo.deviceMemory,
          'language': webInfo.language,
          'languages': webInfo.languages,
          'platform': webInfo.platform,
          'product': webInfo.product,
          'productSub': webInfo.productSub,
          'userAgent': webInfo.userAgent,
          'vendor': webInfo.vendor,
          'vendorSub': webInfo.vendorSub,
          'hardwareConcurrency': webInfo.hardwareConcurrency,
          'maxTouchPoints': webInfo.maxTouchPoints,
        });
      }
      
      // Add common device data
      deviceData.addAll({
        'screenWidth': screenWidth,
        'screenHeight': screenHeight,
        'devicePixelRatio': devicePixelRatio,
        'isTablet': isTablet,
        'isPhone': isPhone,
        'orientation': isPortrait ? 'portrait' : 'landscape',
      });
      
    } catch (e) {
      deviceData['error'] = e.toString();
    }
    
    return deviceData;
  }
  
  // App information
  static Future<Map<String, dynamic>> getAppInfo() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      
      return {
        'appName': packageInfo.appName,
        'packageName': packageInfo.packageName,
        'version': packageInfo.version,
        'buildNumber': packageInfo.buildNumber,
        'buildSignature': packageInfo.buildSignature,
        'installerStore': packageInfo.installerStore,
      };
    } catch (e) {
      return {'error': e.toString()};
    }
  }
  
  // System UI
  static void setSystemUIOverlayStyle({
    Color? statusBarColor,
    Brightness? statusBarIconBrightness,
    Color? systemNavigationBarColor,
    Brightness? systemNavigationBarIconBrightness,
  }) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: statusBarColor,
        statusBarIconBrightness: statusBarIconBrightness,
        systemNavigationBarColor: systemNavigationBarColor,
        systemNavigationBarIconBrightness: systemNavigationBarIconBrightness,
      ),
    );
  }
  
  static void hideStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }
  
  static void showStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  }
  
  static void setFullScreen() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }
  
  static void exitFullScreen() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }
  
  // Orientation
  static void setPortraitOrientation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
  
  static void setLandscapeOrientation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }
  
  static void setAllOrientations() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }
  
  static void lockCurrentOrientation() {
    if (isPortrait) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    } else {
      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    }
  }
  
  // Haptic feedback
  static void lightHaptic() {
    HapticFeedback.lightImpact();
  }
  
  static void mediumHaptic() {
    HapticFeedback.mediumImpact();
  }
  
  static void heavyHaptic() {
    HapticFeedback.heavyImpact();
  }
  
  static void selectionHaptic() {
    HapticFeedback.selectionClick();
  }
  
  static void vibrate() {
    HapticFeedback.vibrate();
  }
  
  // Keyboard
  static void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
  
  static void showKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.show');
  }
  
  static bool isKeyboardVisible(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom > 0;
  }
  
  static double getKeyboardHeight(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom;
  }
  
  // Responsive design helpers
  static double getResponsiveWidth(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.width * (percentage / 100);
  }
  
  static double getResponsiveHeight(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.height * (percentage / 100);
  }
  
  static double getResponsiveFontSize(BuildContext context, double baseFontSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    if (screenWidth < 600) {
      return baseFontSize * 0.9; // Small screens
    } else if (screenWidth < 1200) {
      return baseFontSize; // Medium screens
    } else {
      return baseFontSize * 1.1; // Large screens
    }
  }
  
  static EdgeInsets getResponsivePadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    if (screenWidth < 600) {
      return const EdgeInsets.all(16); // Small screens
    } else if (screenWidth < 1200) {
      return const EdgeInsets.all(24); // Medium screens
    } else {
      return const EdgeInsets.all(32); // Large screens
    }
  }
  
  static int getResponsiveColumns(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    if (screenWidth < 600) {
      return 1; // Small screens
    } else if (screenWidth < 900) {
      return 2; // Medium screens
    } else if (screenWidth < 1200) {
      return 3; // Large screens
    } else {
      return 4; // Extra large screens
    }
  }
  
  // Text scale factor
  static double getTextScaleFactor(BuildContext context) {
    return MediaQuery.of(context).textScaleFactor;
  }
  
  static bool isLargeTextScale(BuildContext context) {
    return getTextScaleFactor(context) > 1.3;
  }
  
  // Accessibility
  static bool isAccessibilityEnabled(BuildContext context) {
    return MediaQuery.of(context).accessibleNavigation;
  }
  
  static bool isBoldTextEnabled(BuildContext context) {
    return MediaQuery.of(context).boldText;
  }
  
  static bool isHighContrastEnabled(BuildContext context) {
    return MediaQuery.of(context).highContrast;
  }
  
  static bool isReduceMotionEnabled(BuildContext context) {
    return MediaQuery.of(context).disableAnimations;
  }
  
  // Network type (requires additional setup)
  static Future<String> getNetworkType() async {
    // This would require connectivity_plus package
    // For now, return unknown
    return 'unknown';
  }
  
  // Battery level (requires additional setup)
  static Future<int> getBatteryLevel() async {
    // This would require battery_plus package
    // For now, return -1 (unknown)
    return -1;
  }
  
  // Storage information
  static Future<Map<String, int>> getStorageInfo() async {
    // This would require additional platform-specific code
    // For now, return empty map
    return {};
  }
  
  // Memory information
  static Future<Map<String, int>> getMemoryInfo() async {
    // This would require additional platform-specific code
    // For now, return empty map
    return {};
  }
  
  // Device capabilities
  static bool get hasCamera => isMobile;
  static bool get hasGPS => isMobile;
  static bool get hasBluetooth => isMobile;
  static bool get hasNFC => isAndroid; // Generally Android only
  static bool get hasBiometrics => isMobile;
  
  // Performance helpers
  static void optimizeForPerformance() {
    // Disable debug banner in release mode
    if (kReleaseMode) {
      // Already handled by Flutter in release mode
    }
    
    // Set system UI overlay style for better performance
    setSystemUIOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    );
  }
  
  // Debug information
  static Map<String, dynamic> getDebugInfo(BuildContext context) {
    return {
      'platform': Platform.operatingSystem,
      'isDebugMode': kDebugMode,
      'isProfileMode': kProfileMode,
      'isReleaseMode': kReleaseMode,
      'screenSize': '${screenWidth.toInt()}x${screenHeight.toInt()}',
      'devicePixelRatio': devicePixelRatio,
      'textScaleFactor': getTextScaleFactor(context),
      'brightness': platformBrightness.name,
      'orientation': isPortrait ? 'portrait' : 'landscape',
      'isTablet': isTablet,
      'safeAreaTop': getStatusBarHeight(context),
      'safeAreaBottom': getBottomSafeArea(context),
      'keyboardVisible': isKeyboardVisible(context),
      'accessibilityEnabled': isAccessibilityEnabled(context),
      'boldTextEnabled': isBoldTextEnabled(context),
      'highContrastEnabled': isHighContrastEnabled(context),
      'reduceMotionEnabled': isReduceMotionEnabled(context),
    };
  }
  
  // Utility methods for responsive design
  static T responsive<T>({
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop && desktop != null) {
      return desktop;
    } else if (isTablet && tablet != null) {
      return tablet;
    } else {
      return mobile;
    }
  }
  
  static T responsiveValue<T>(BuildContext context, {
    required T small,
    T? medium,
    T? large,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    if (screenWidth >= 1200 && large != null) {
      return large;
    } else if (screenWidth >= 600 && medium != null) {
      return medium;
    } else {
      return small;
    }
  }
  
  // Copy to clipboard
  static Future<void> copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }
  
  // Get from clipboard
  static Future<String?> getFromClipboard() async {
    final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    return clipboardData?.text;
  }
  
  // Share content (requires additional setup)
  static Future<void> shareText(String text) async {
    // This would require share_plus package
    // For now, copy to clipboard
    await copyToClipboard(text);
  }
  
  // Open URL (requires additional setup)
  static Future<bool> openUrl(String url) async {
    // This would require url_launcher package
    // For now, return false
    return false;
  }
  
  // Check if app can open URL
  static Future<bool> canOpenUrl(String url) async {
    // This would require url_launcher package
    // For now, return false
    return false;
  }
}