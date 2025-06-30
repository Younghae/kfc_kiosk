import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../screens/payment_screen.dart';

class CartSummary extends StatelessWidget {
  const CartSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        return Column(
          children: [
            // 장바구니 헤더
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const Text(
                    '장바구니',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Text(
                    '${cartProvider.totalItems}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            // 장바구니 아이템들
            Expanded(
              child: cartProvider.items.isEmpty
                  ? const Center(
                      child: Text(
                        '장바구니가 비어있습니다.\n메뉴를 담아주세요!',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: cartProvider.items.length,
                      itemBuilder: (context, index) {
                        final item = cartProvider.items[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey[300]!),
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
                                    icon: const Icon(Icons.close, size: 20),
                                  ),
                                ],
                              ),
                              if (item.selectedOptions.isNotEmpty)
                                ...item.selectedOptions.map(
                                  (option) => Padding(
                                    padding:
                                        const EdgeInsets.only(left: 8, top: 4),
                                    child: Text(
                                      '+ ${option.nameKr}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  // 수량 조절
                                  Container(
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.grey[300]!),
                                      borderRadius: BorderRadius.circular(4),
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
                                            child: const Icon(Icons.remove,
                                                size: 16),
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
                                            child:
                                                const Icon(Icons.add, size: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '₩${_formatPrice(item.totalPrice)}',
                                    style: const TextStyle(
                                      fontSize: 14,
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
            // 하단 영역
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // 전체 취소 버튼
                  if (cartProvider.items.isNotEmpty)
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => _showClearCartDialog(context),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: const BorderSide(color: Colors.red),
                        ),
                        child: const Text(
                          '전체취소',
                          style: TextStyle(fontSize: 16, color: Colors.red),
                        ),
                      ),
                    ),
                  const SizedBox(height: 12),
                  // 총 금액
                  Row(
                    children: [
                      const Text(
                        '주문금액',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
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
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        '주문완료',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
          title: const Text('전체취소'),
          content: const Text(
              '장바구니를 초기화하고\n대기화면으로 돌아가시겠습니까?\n\n장바구니에 담긴 내용은 저장되지 않습니다.\n로그인 된 멤버십 계정은 로그아웃 됩니다.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('예', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.read<CartProvider>().clearCart();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('아니오', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
