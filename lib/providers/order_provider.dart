import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/order.dart';
import '../services/api_service.dart';

class OrderProvider with ChangeNotifier {
  List<Order> _orders = [];
  Order? _currentOrder;

  List<Order> get orders => _orders;
  Order? get currentOrder => _currentOrder;

  Future<bool> completeOrder(List<CartItem> items, String paymentMethod) async {
    try {
      final orderId = DateTime.now().millisecondsSinceEpoch.toString();
      final totalAmount = items.fold(0, (sum, item) => sum + item.totalPrice);

      // 주문 객체 생성
      final order = Order(
        id: orderId,
        items: List.from(items),
        totalAmount: totalAmount,
        paymentMethod: paymentMethod,
        orderTime: DateTime.now(),
        status: OrderStatus.pending,
      );

      // API로 주문 전송 (선택사항)
      final success = await ApiService.submitOrder(
        orderId: orderId,
        items: items.map((item) => item.toJson()).toList(),
        totalAmount: totalAmount,
        paymentMethod: paymentMethod,
      );

      if (success) {
        _currentOrder = order;
        _orders.add(order);
        notifyListeners();
        return true;
      }

      return false;
    } catch (e) {
      // 오프라인 모드에서도 주문 저장
      final order = Order(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        items: List.from(items),
        totalAmount: items.fold(0, (sum, item) => sum + item.totalPrice),
        paymentMethod: paymentMethod,
        orderTime: DateTime.now(),
        status: OrderStatus.completed,
      );

      _currentOrder = order;
      _orders.add(order);
      notifyListeners();
      return true;
    }
  }

  void clearCurrentOrder() {
    _currentOrder = null;
    notifyListeners();
  }

  void updateOrderStatus(String orderId, OrderStatus status) {
    final orderIndex = _orders.indexWhere((order) => order.id == orderId);
    if (orderIndex != -1) {
      final existingOrder = _orders[orderIndex];
      _orders[orderIndex] = Order(
        id: existingOrder.id,
        items: existingOrder.items,
        totalAmount: existingOrder.totalAmount,
        paymentMethod: existingOrder.paymentMethod,
        orderTime: existingOrder.orderTime,
        status: status,
      );
      notifyListeners();
    }
  }
}
