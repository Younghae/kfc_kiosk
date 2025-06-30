import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/menu_item.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _items = [];

  List<CartItem> get items => _items;

  int get totalItems => _items.fold(0, (sum, item) => sum + item.quantity);

  int get totalPrice => _items.fold(0, (sum, item) => sum + item.totalPrice);

  void addItem(MenuItem menuItem, List<MenuOption> selectedOptions) {
    final existingIndex = _items.indexWhere((item) =>
        item.menuItem.id == menuItem.id &&
        _optionsMatch(item.selectedOptions, selectedOptions));

    if (existingIndex >= 0) {
      _items[existingIndex].quantity++;
    } else {
      _items.add(CartItem(
        menuItem: menuItem,
        selectedOptions: selectedOptions,
      ));
    }
    notifyListeners();
  }

  void removeItem(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
      notifyListeners();
    }
  }

  void updateQuantity(int index, int quantity) {
    if (index >= 0 && index < _items.length && quantity > 0) {
      _items[index].quantity = quantity;
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  bool _optionsMatch(List<MenuOption> options1, List<MenuOption> options2) {
    if (options1.length != options2.length) return false;
    for (int i = 0; i < options1.length; i++) {
      if (options1[i].id != options2[i].id) return false;
    }
    return true;
  }
}
