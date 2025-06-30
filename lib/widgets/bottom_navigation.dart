import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.black,
      child: Row(
        children: [
          // 왼쪽 빈 공간
          const Expanded(flex: 1, child: SizedBox()),

          // 중앙 네비게이션 버튼들
          Expanded(
            flex: 8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavButton('쿠폰', Icons.local_offer, () {}),
                _buildNavButton('전체취소', Icons.refresh, () {}),
                _buildNavButton('주문완료', Icons.check_circle, () {}),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.camera_alt, size: 16),
                      SizedBox(width: 4),
                      Text('4/10',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 오른쪽 빈 공간
          const Expanded(flex: 1, child: SizedBox()),
        ],
      ),
    );
  }

  Widget _buildNavButton(String text, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 16),
            const SizedBox(width: 4),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
