import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../screens/payment_screen.dart';

class CartPanel extends StatelessWidget {
  const CartPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        return Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(color: Colors.grey[300]!, width: 1),
            ),
          ),
          child: Column(
            children: [
              // 장바구니 헤더
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[200]!, width: 1),
                  ),
                ),
                child: Row(
                  children: [
                    const Text(
                      '장바구니',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${cartProvider.totalItems}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // 장바구니 아이템들
              Expanded(
                child: cartProvider.items.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              size: 64,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              '장바구니가 비어있습니다.\n메뉴를 담아주세요!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: cartProvider.items.length,
                        itemBuilder: (context, index) {
                          final item = cartProvider.items[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey[200]!),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        item.menuItem.nameKr,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () =>
                                          cartProvider.removeItem(index),
                                      icon: Icon(Icons.close,
                                          size: 18, color: Colors.grey[600]),
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                    ),
                                  ],
                                ),
                                if (item.selectedOptions.isNotEmpty)
                                  ...item.selectedOptions.map(
                                    (option) => Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, top: 4),
                                      child: Text(
                                        '+ ${option.nameKr}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ),
                                  ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    // 수량 조절
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey[300]!),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              if (item.quantity > 1) {
                                                cartProvider.updateQuantity(
                                                    index, item.quantity - 1);
                                              }
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(8),
                                              child: Icon(
                                                Icons.remove,
                                                size: 16,
                                                color: item.quantity > 1
                                                    ? Colors.black
                                                    : Colors.grey[400],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 8),
                                            child: Text(
                                              '${item.quantity}',
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              cartProvider.updateQuantity(
                                                  index, item.quantity + 1);
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(8),
                                              child: const Icon(Icons.add,
                                                  size: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '₩${_formatPrice(item.totalPrice)}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),

              // 하단 전체취소 및 주문 버튼
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(color: Colors.grey[200]!, width: 1),
                  ),
                ),
                child: Column(
                  children: [
                    // 전체취소 버튼
                    if (cartProvider.items.isNotEmpty)
                      Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () => _showClearCartDialog(context),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              side: const BorderSide(color: Colors.red),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              '전체취소',
                              style: TextStyle(fontSize: 14, color: Colors.red),
                            ),
                          ),
                        ),
                      ),

                    // 총 금액
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Text(
                            '주문금액',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Text(
                            '₩ ${_formatPrice(cartProvider.totalPrice)}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // 주문완료 버튼
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: cartProvider.items.isEmpty
                            ? null
                            : () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const PaymentScreen(),
                                  ),
                                );
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: cartProvider.items.isEmpty
                              ? Colors.grey[300]
                              : Colors.red,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          '주문완료',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: cartProvider.items.isEmpty
                                ? Colors.grey[600]
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }

  void _showClearCartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            '전체취소',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
            '장바구니를 초기화하고\n대기화면으로 돌아가시겠습니까?',
            style: TextStyle(height: 1.5),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                '취소',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.read<CartProvider>().clearCart();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                '확인',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
