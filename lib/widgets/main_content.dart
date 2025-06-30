import 'package:flutter/material.dart';
import 'product_grid.dart';
import 'cart_panel.dart';

class MainContent extends StatelessWidget {
  const MainContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 상품 그리드 영역
        Expanded(
          flex: 7,
          child: Container(
            color: Colors.grey[50],
            child: const ProductGrid(),
          ),
        ),

        // 장바구니 패널
        SizedBox(
          width: 350,
          child: Container(
            color: Colors.white,
            child: const CartPanel(),
          ),
        ),
      ],
    );
  }
}
