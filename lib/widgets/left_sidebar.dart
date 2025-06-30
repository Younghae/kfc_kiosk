import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/menu_provider.dart';

class LeftSidebar extends StatelessWidget {
  const LeftSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // KFC 로고
          Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'KFC',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // 광고 배너와 매장식사/포장주문 버튼과 구분선 높이만큼 빈 공간
          // 320 (광고배너) + 80 (버튼) + 1 (구분선) = 401px
          SizedBox(height: 401),

          // 메뉴 카테고리 제목 (상품 목록과 정확히 같은 높이)
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: Colors.grey[300]!, width: 1),
              ),
            ),
            child: const Text(
              '메뉴 카테고리',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),

          // 카테고리 목록
          Expanded(
            child: Consumer<MenuProvider>(
              builder: (context, menuProvider, child) {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: menuProvider.categories.length,
                  itemBuilder: (context, index) {
                    final category = menuProvider.categories[index];
                    final isSelected =
                        menuProvider.selectedCategory == category;

                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Material(
                        color: isSelected ? Colors.red : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () =>
                              menuProvider.setSelectedCategory(category),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 20),
                            child: Row(
                              children: [
                                Icon(
                                  _getCategoryIcon(category),
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.grey[600],
                                  size: 24,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    category,
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black87,
                                      fontSize: 16,
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case '베스트 메뉴':
        return Icons.star;
      case '버거':
        return Icons.lunch_dining;
      case '트위스터':
        return Icons.wrap_text;
      case '치밥':
        return Icons.rice_bowl;
      case '치킨':
        return Icons.food_bank;
      case '사이드 스낵':
        return Icons.fastfood;
      case '음료':
        return Icons.local_drink;
      case '주류':
        return Icons.local_bar;
      default:
        return Icons.restaurant;
    }
  }
}
