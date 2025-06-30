import 'package:flutter/material.dart';

class KioskHeader extends StatelessWidget {
  const KioskHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.red,
      child: Stack(
        children: [
          // KFC 로고 (왼쪽 상단)
          Positioned(
            left: 20,
            top: 20,
            child: Container(
              width: 80,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  'KFC',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          // 배너 텍스트 (중앙)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'KFC더블적립!!',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  '더블적립!!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  '더 빠른 승급 혜택!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // X2 뱃지 (오른쪽)
          Positioned(
            right: 100,
            top: 30,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Text(
                'X2',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // 음료컵 아이콘 (오른쪽)
          Positioned(
            right: 20,
            top: 20,
            child: Container(
              width: 60,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.local_drink,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),

          // 상단 우측 버튼들
          Positioned(
            right: 20,
            top: 120,
            child: Row(
              children: [
                _buildHeaderButton('매장 식사', Icons.restaurant),
                const SizedBox(width: 8),
                _buildHeaderButton('포장 주문', Icons.shopping_bag),
                const SizedBox(width: 8),
                _buildHeaderButton('영양정보', Icons.info_outline),
                const SizedBox(width: 8),
                _buildLanguageButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderButton(String text, IconData icon) {
    return Container(
      width: 80,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.red, size: 20),
          const SizedBox(height: 4),
          Text(
            text,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageButton() {
    return Container(
      width: 80,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 16,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: const Center(
                  child: Text('한',
                      style: TextStyle(color: Colors.white, fontSize: 8)),
                ),
              ),
              const SizedBox(width: 2),
              Container(
                width: 16,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: const Center(
                  child: Text('EN',
                      style: TextStyle(color: Colors.white, fontSize: 6)),
                ),
              ),
              const SizedBox(width: 2),
              Container(
                width: 16,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: const Center(
                  child: Text('中',
                      style: TextStyle(color: Colors.white, fontSize: 8)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'KO',
            style: TextStyle(
                color: Colors.red, fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
