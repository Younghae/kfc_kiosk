import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/menu_item.dart';
import '../providers/cart_provider.dart';
import '../screens/product_detail_screen.dart';

class MenuItemCard extends StatelessWidget {
  final MenuItem menuItem;

  const MenuItemCard({super.key, required this.menuItem});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (menuItem.options.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailScreen(menuItem: menuItem),
            ),
          );
        } else {
          context.read<CartProvider>().addItem(menuItem, []);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${menuItem.nameKr}이(가) 장바구니에 추가되었습니다.'),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 이미지 영역
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(12)),
                      color: Colors.grey[200],
                    ),
                    child: const Icon(
                      Icons.fastfood,
                      size: 60,
                      color: Colors.grey,
                    ),
                  ),
                  // 뱃지들
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Row(
                      children: [
                        if (menuItem.isNew)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'NEW',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        if (menuItem.isHot)
                          Container(
                            margin: const EdgeInsets.only(left: 4),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'HOT',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // 정보 영역
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      menuItem.nameKr,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        if (menuItem.originalPrice > menuItem.price)
                          Expanded(
                            child: Text(
                              '₩${_formatPrice(menuItem.originalPrice)}',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ),
                        const SizedBox(width: 8),
                        Text(
                          '₩${_formatPrice(menuItem.price)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }
}
