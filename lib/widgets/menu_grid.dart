import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/menu_provider.dart';
import '../widgets/menu_item_card.dart';

class MenuGrid extends StatelessWidget {
  const MenuGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MenuProvider>(
      builder: (context, menuProvider, child) {
        final items = menuProvider.filteredMenuItems;

        return GridView.builder(
          padding: const EdgeInsets.all(20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.8,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return MenuItemCard(menuItem: items[index]);
          },
        );
      },
    );
  }
}
