import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class FamxPayCacheService {
  final SharedPreferences prefs;
  static const String cacheKey = 'famx_pay_cache';
  static const Duration cacheDuration = Duration(hours: 1);

  FamxPayCacheService({required this.prefs});

  Future<void> cacheData(Map<String, dynamic> data) async {
    final cacheData = {
      'timestamp': DateTime.now().toIso8601String(),
      'data': data,
    };
    await prefs.setString(cacheKey, json.encode(cacheData));
  }

  Future<Map<String, dynamic>?> getCachedData() async {
    final cachedString = prefs.getString(cacheKey);
    if (cachedString == null) return null;

    final cached = json.decode(cachedString);
    final timestamp = DateTime.parse(cached['timestamp']);
    
    if (DateTime.now().difference(timestamp) > cacheDuration) {
      // Cache expired
      await prefs.remove(cacheKey);
      return null;
    }

    return cached['data'];
  }

  Future<void> clearCache() async {
    await prefs.remove(cacheKey);
  }
}