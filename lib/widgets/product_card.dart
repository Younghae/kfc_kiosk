import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/menu_item.dart';
import '../providers/cart_provider.dart';
import '../screens/product_detail_screen.dart';

class ProductCard extends StatelessWidget {
  final MenuItem menuItem;

  const ProductCard({super.key, required this.menuItem});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        // 장바구니에 같은 상품이 있는지 확인
        final cartItemIndex = cartProvider.items
            .indexWhere((item) => item.menuItem.id == menuItem.id);
        final isInCart = cartItemIndex >= 0;
        final cartQuantity =
            isInCart ? cartProvider.items[cartItemIndex].quantity : 0;

        return GestureDetector(
          onTap: () {
            if (menuItem.options.isNotEmpty ||
                menuItem.optionGroups.isNotEmpty) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(menuItem: menuItem),
                ),
              );
            } else {
              _addToCart(context);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
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
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12)),
                          color: Colors.grey[100],
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
                                    horizontal: 6, vertical: 3),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  'NEW',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            if (menuItem.isHot)
                              Container(
                                margin: const EdgeInsets.only(left: 4),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 3),
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  'HOT',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
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
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),
                        if (menuItem.originalPrice > menuItem.price)
                          Text(
                            '₩${_formatPrice(menuItem.originalPrice)}',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        Row(
                          children: [
                            Text(
                              '₩${_formatPrice(menuItem.price)}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                            const Spacer(),
                            // + 버튼 또는 수량 표시
                            if (!isInCart)
                              GestureDetector(
                                onTap: () => _addToCart(context),
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              )
                            else
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (cartQuantity > 1) {
                                          cartProvider.updateQuantity(
                                              cartItemIndex, cartQuantity - 1);
                                        } else {
                                          cartProvider
                                              .removeItem(cartItemIndex);
                                        }
                                      },
                                      child: const Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Text(
                                        '$cartQuantity',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        cartProvider.updateQuantity(
                                            cartItemIndex, cartQuantity + 1);
                                      },
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ],
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
      },
    );
  }

  void _addToCart(BuildContext context) {
    if (menuItem.options.isNotEmpty || menuItem.optionGroups.isNotEmpty) {
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
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }
}
