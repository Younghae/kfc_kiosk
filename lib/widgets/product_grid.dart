import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/menu_provider.dart';
import '../widgets/product_card.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MenuProvider>(
      builder: (context, menuProvider, child) {
        final items = menuProvider.filteredMenuItems;

        if (items.isEmpty) {
          return const Center(
            child: Text(
              '해당 카테고리에 상품이 없습니다.',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.8,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ProductCard(menuItem: items[index]);
          },
        );
      },
    );
  }
}
