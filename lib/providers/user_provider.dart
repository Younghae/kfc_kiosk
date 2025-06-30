import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String? _userId;
  String? _userName;
  int _points = 0;
  bool _isLoggedIn = false;

  String? get userId => _userId;
  String? get userName => _userName;
  int get points => _points;
  bool get isLoggedIn => _isLoggedIn;

  void login(String userId, String userName, int points) {
    _userId = userId;
    _userName = userName;
    _points = points;
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _userId = null;
    _userName = null;
    _points = 0;
    _isLoggedIn = false;
    notifyListeners();
  }

  void usePoints(int amount) {
    if (_points >= amount) {
      _points -= amount;
      notifyListeners();
    }
  }

  void earnPoints(int amount) {
    _points += amount;
    notifyListeners();
  }
}
