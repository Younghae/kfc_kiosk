import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/main_screen.dart';
import 'providers/cart_provider.dart';
import 'providers/menu_provider.dart';
import 'providers/order_provider.dart';
import 'providers/user_provider.dart';

void main() {
  runApp(const KioskApp());
}

class KioskApp extends StatelessWidget {
  const KioskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => MenuProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'KFC Kiosk',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
          fontFamily: 'NotoSans',
          scaffoldBackgroundColor: Colors.white,
        ),
        home: const MainScreen(),
      ),
    );
  }
}
