import 'package:flutter/material.dart';

class TopHeader extends StatelessWidget {
  const TopHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.red,
      child: Row(
        children: [
          // 광고 이미지 영역
          Expanded(
            flex: 6,
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.shade700,
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: [Colors.red, Colors.red.shade800],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 30,
                    top: 30,
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
                          '더블적립!!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
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
                  Positioned(
                    right: 30,
                    top: 30,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.local_drink,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 200,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'X2',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 오른쪽 버튼들
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // 상단 버튼들
                  Row(
                    children: [
                      Expanded(
                        child: _buildTopButton('매장 식사', Icons.restaurant),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildTopButton('포장 주문', Icons.shopping_bag),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // 하단 버튼들
                  Row(
                    children: [
                      Expanded(
                        child: _buildTopButton('영양정보', Icons.info_outline),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildLanguageButton(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopButton(String text, IconData icon) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.red, size: 24),
              const SizedBox(height: 4),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageButton() {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {},
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
                      borderRadius: BorderRadius.circular(2),
                      color: Colors.blue,
                    ),
                    child: const Center(
                      child: Text(
                        '한',
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    width: 16,
                    height: 12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Colors.red,
                    ),
                    child: const Center(
                      child: Text(
                        'EN',
                        style: TextStyle(color: Colors.white, fontSize: 6),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    width: 16,
                    height: 12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Colors.orange,
                    ),
                    child: const Center(
                      child: Text(
                        '中',
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                'KO',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 12,
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
