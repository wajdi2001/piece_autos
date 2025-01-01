import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  /// Initialize SharedPreferences
  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  /// Generic method to get data
  static dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  /// Save primitive or serialized data
  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is int) return await sharedPreferences.setInt(key, value);
    if (value is bool) return await sharedPreferences.setBool(key, value);
    if (value is List<String>) return await sharedPreferences.setStringList(key, value);

    // If none of the above, assume it's a double
    return await sharedPreferences.setDouble(key, value);
  }

  /// Save a list of objects (e.g., List<TagModel> or List<ItemModel>)
  static Future<bool> saveObjectList<T>({
    required String key,
    required List<T> value,
    required String Function(T) toJson,
  }) async {
    // Serialize the list of objects into a JSON string
    List<String> jsonList = value.map((item) => toJson(item)).toList();
    return await sharedPreferences.setStringList(key, jsonList);
  }

  /// Retrieve a list of objects
  static List<T> getObjectList<T>({
    required String key,
    required T Function(String) fromJson,
  }) {
    // Get the JSON string list from SharedPreferences
    List<String>? jsonList = sharedPreferences.getStringList(key);
    if (jsonList == null) return [];
    // Deserialize each JSON string back into an object
    return jsonList.map((json) => fromJson(json)).toList();
  }

  /// Remove data by key
  static Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }
}
