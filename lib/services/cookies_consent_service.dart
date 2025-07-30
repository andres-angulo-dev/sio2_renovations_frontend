import 'package:shared_preferences/shared_preferences.dart';

class CookiesConsentService {
  static const String necessaryKey = 'necessaryCookies';
  static const String preferencesKey = 'preferencesCookies';
  static const String statisticsKey = 'statisticsCookies';
  static const String marketingKey = 'marketingCookies';

  // Loads saved cookie preferences from SharedPreferences and updates the state  
  static Future<Map<String, bool?>> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    return {
      necessaryKey: prefs.getBool(necessaryKey),
      preferencesKey: prefs.getBool(preferencesKey) ?? false,
      statisticsKey: prefs.getBool(statisticsKey) ?? false,
      marketingKey: prefs.getBool(marketingKey) ?? false,
    };
  }

  // Saves the global consent status as "true" to SharedPreferences
  static Future<void> saveGlobalConsent() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(necessaryKey, true); // Necessary cookies are always enabled
    await prefs.setBool(preferencesKey, true);
    await prefs.setBool(statisticsKey, true);
    await prefs.setBool(marketingKey, true);
  }

  // Saves individual cookie preferences to SharedPreferences
  static Future<void> savePreferences(Map<String, bool> prefsMap) async {
    final prefs = await SharedPreferences.getInstance();
    
    for (var entry in prefsMap.entries) {
      await prefs.setBool(entry.key, entry.value);
    }
  }
}
