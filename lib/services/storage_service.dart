import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class StorageService {
  static const String _cartKey = 'cart_items';
  static const String _userKey = 'user_data';

  static Future<void> saveCart(List<Map<String, dynamic>> cartData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_cartKey, json.encode(cartData));
  }

  static Future<List<Map<String, dynamic>>> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartString = prefs.getString(_cartKey);
    if (cartString != null) {
      return List<Map<String, dynamic>>.from(json.decode(cartString));
    }
    return [];
  }

  static Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cartKey);
  }

  static Future<void> saveUser(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, json.encode(userData));
  }

  static Future<Map<String, dynamic>?> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString(_userKey);
    if (userString != null) {
      return Map<String, dynamic>.from(json.decode(userString));
    }
    return null;
  }

  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }
}
