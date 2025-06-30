import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/menu_provider.dart';
import '../widgets/product_grid.dart';
import '../widgets/cart_panel.dart';

class MainContentWithBanner extends StatelessWidget {
  const MainContentWithBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 상단 광고 배너 영역
        Container(
          height: 400, // 160에서 320으로 2배 증가
          color: Colors.red,
          margin:
              const EdgeInsets.only(left: 16, top: 16, right: 16), // 상단 여백 추가
          // padding: const EdgeInsets.only(top: 20), // 상단 여백 추가
          child: Row(
            children: [
              // 광고 배너 (전체 너비)
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      colors: [Colors.red.shade600, Colors.red.shade800],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Stack(
                    children: [
                      // 광고 텍스트
                      Positioned(
                        left: 30,
                        top: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                'KFC더블적립!!',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              '광고용 배너',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              '(KFC 더블적립 혜택)',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // 오른쪽 이미지
                      Positioned(
                        right: 30,
                        top: 20,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.local_drink,
                            size: 50,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // 매장식사/포장주문 버튼 영역
        Container(
          height: 80,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: _buildOrderTypeButton('매장식사', Icons.restaurant),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildOrderTypeButton('포장주문', Icons.shopping_bag),
              ),
            ],
          ),
        ),

        // 구분선
        Container(
          height: 1,
          color: Colors.grey[300],
        ),

        // 상품 목록 제목 영역
        Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: Colors.grey[300]!, width: 1),
            ),
          ),
          child: Row(
            children: [
              const Text(
                '상품 목록',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),

        // 메인 콘텐츠 영역 (상품 그리드 + 장바구니)
        Expanded(
          child: Row(
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
          ),
        ),
      ],
    );
  }

  Widget _buildOrderTypeButton(String text, IconData icon) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red, width: 2),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.red, size: 24),
              const SizedBox(width: 8),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
