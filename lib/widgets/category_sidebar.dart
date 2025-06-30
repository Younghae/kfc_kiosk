import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/menu_provider.dart';

class CategorySidebar extends StatelessWidget {
  const CategorySidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.white,
      child: Consumer<MenuProvider>(
        builder: (context, menuProvider, child) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: menuProvider.categories.length,
            itemBuilder: (context, index) {
              final category = menuProvider.categories[index];
              final isSelected = menuProvider.selectedCategory == category;

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Material(
                  color: isSelected ? Colors.red : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () => menuProvider.setSelectedCategory(category),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      child: Row(
                        children: [
                          Icon(
                            _getCategoryIcon(category),
                            color: isSelected ? Colors.white : Colors.grey[600],
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              category,
                              style: TextStyle(
                                color:
                                    isSelected ? Colors.white : Colors.black87,
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
