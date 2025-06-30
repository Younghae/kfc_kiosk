import 'cart_item.dart';

enum OrderStatus {
  pending,
  preparing,
  ready,
  completed,
  cancelled,
}

class Order {
  final String id;
  final List<CartItem> items;
  final int totalAmount;
  final String paymentMethod;
  final DateTime orderTime;
  final OrderStatus status;

  Order({
    required this.id,
    required this.items,
    required this.totalAmount,
    required this.paymentMethod,
    required this.orderTime,
    required this.status,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] ?? '',
      items: (json['items'] as List<dynamic>?)
              ?.map((item) => CartItem.fromJson(item))
              .toList() ??
          [],
      totalAmount: json['totalAmount'] ?? 0,
      paymentMethod: json['paymentMethod'] ?? '',
      orderTime: DateTime.tryParse(json['orderTime'] ?? '') ?? DateTime.now(),
      status: OrderStatus.values.firstWhere(
        (status) => status.toString() == 'OrderStatus.${json['status']}',
        orElse: () => OrderStatus.pending,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'items': items.map((item) => item.toJson()).toList(),
      'totalAmount': totalAmount,
      'paymentMethod': paymentMethod,
      'orderTime': orderTime.toIso8601String(),
      'status': status.toString().split('.').last,
    };
  }
}
