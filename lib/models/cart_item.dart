import 'menu_item.dart';

class CartItem {
  final MenuItem menuItem;
  int quantity;
  final List<MenuOption> selectedOptions;

  CartItem({
    required this.menuItem,
    this.quantity = 1,
    this.selectedOptions = const [],
  });

  int get totalPrice {
    int optionsPrice =
        selectedOptions.fold(0, (sum, option) => sum + option.additionalPrice);
    return (menuItem.price + optionsPrice) * quantity;
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      menuItem: MenuItem.fromJson(json['menuItem']),
      quantity: json['quantity'] ?? 1,
      selectedOptions: (json['selectedOptions'] as List<dynamic>?)
              ?.map((option) => MenuOption.fromJson(option))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'menuItem': menuItem.toJson(),
      'quantity': quantity,
      'selectedOptions':
          selectedOptions.map((option) => option.toJson()).toList(),
    };
  }
}
