import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = 'KFC Kiosk';
  static const String apiBaseUrl = 'https://api.kfc.co.kr';

  // 색상
  static const kfcRed = Color(0xFFE31837);
  static const kfcLightRed = Color(0xFFFFEBEE);

  // 크기
  static const double headerHeight = 120.0;
  static const double categoryTabHeight = 80.0;
  static const double bottomNavHeight = 80.0;

  // 애니메이션
  static const Duration animationDuration = Duration(milliseconds: 300);

  // 텍스트 스타일
  static const titleTextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );

  static const priceTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: kfcRed,
  );
}
