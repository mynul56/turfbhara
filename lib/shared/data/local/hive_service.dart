import 'package:hive_flutter/hive_flutter.dart';

/// Service class for handling Hive local storage operations
class HiveService {
  static const String _settingsBox = 'settings';
  static const String _userBox = 'user';
  static const String _cacheBox = 'cache';

  static late Box<dynamic> _settings;
  static late Box<dynamic> _user;
  static late Box<dynamic> _cache;

  /// Initialize Hive boxes
  static Future<void> init() async {
    _settings = await Hive.openBox<dynamic>(_settingsBox);
    _user = await Hive.openBox<dynamic>(_userBox);
    _cache = await Hive.openBox<dynamic>(_cacheBox);
  }

  /// Clear all data from Hive boxes
  static Future<void> clearAll() async {
    await Future.wait([
      _settings.clear(),
      _user.clear(),
      _cache.clear(),
    ]);
  }

  /// Settings Box Operations
  static Future<void> saveSetting(String key, dynamic value) async {
    await _settings.put(key, value);
  }

  static T? getSetting<T>(String key) {
    return _settings.get(key) as T?;
  }

  static Future<void> removeSetting(String key) async {
    await _settings.delete(key);
  }

  /// User Box Operations
  static Future<void> saveUserData(String key, dynamic value) async {
    await _user.put(key, value);
  }

  static T? getUserData<T>(String key) {
    return _user.get(key) as T?;
  }

  static Future<void> removeUserData(String key) async {
    await _user.delete(key);
  }

  static Future<void> clearUserData() async {
    await _user.clear();
  }

  /// Cache Box Operations
  static Future<void> saveToCache(String key, dynamic value) async {
    await _cache.put(key, value);
  }

  static T? getFromCache<T>(String key) {
    return _cache.get(key) as T?;
  }

  static Future<void> removeFromCache(String key) async {
    await _cache.delete(key);
  }

  static Future<void> clearCache() async {
    await _cache.clear();
  }

  /// Check if a key exists in any box
  static bool hasKey(String key) {
    return _settings.containsKey(key) ||
        _user.containsKey(key) ||
        _cache.containsKey(key);
  }

  /// Close all Hive boxes
  static Future<void> dispose() async {
    await Future.wait([
      _settings.close(),
      _user.close(),
      _cache.close(),
    ]);
  }
}