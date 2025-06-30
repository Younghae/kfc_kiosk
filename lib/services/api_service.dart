import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/menu_item.dart';
import '../utils/constants.dart';

class ApiService {
  static const String baseUrl = AppConstants.apiBaseUrl;

  static Future<List<MenuItem>> getMenuItems() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/menu'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => MenuItem.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load menu items');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  static Future<bool> processPayment({
    required String orderId,
    required int amount,
    required String paymentMethod,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/payment'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'orderId': orderId,
          'amount': amount,
          'paymentMethod': paymentMethod,
        }),
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> submitOrder({
    required String orderId,
    required List<Map<String, dynamic>> items,
    required int totalAmount,
    required String paymentMethod,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/orders'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'orderId': orderId,
          'items': items,
          'totalAmount': totalAmount,
          'paymentMethod': paymentMethod,
          'orderTime': DateTime.now().toIso8601String(),
        }),
      );

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }
}
