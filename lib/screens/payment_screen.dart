import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/order_provider.dart';
import 'order_complete_screen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedPaymentMethod = 'card';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 헤더
          Container(
            height: 100,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, size: 32),
                ),
                const SizedBox(width: 20),
                const Text(
                  '결제하기',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 주문 요약
                  const Text(
                    '주문 내역',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Consumer<CartProvider>(
                    builder: (context, cartProvider, child) {
                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Column(
                          children: [
                            ...cartProvider.items.map((item) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '${item.menuItem.nameKr} x ${item.quantity}',
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      Text(
                                        '₩${_formatPrice(item.totalPrice)}',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                )),
                            const Divider(),
                            Row(
                              children: [
                                const Text(
                                  '총 결제금액',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Spacer(),
                                Text(
                                  '₩${_formatPrice(cartProvider.totalPrice)}',
                                  style: const TextStyle(
                                    fontSize: 20,
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
                  const SizedBox(height: 30),

                  // 결제 방법 선택
                  const Text(
                    '결제 방법 선택',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildPaymentMethodCard(
                          'card',
                          '카드 결제',
                          Icons.credit_card,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildPaymentMethodCard(
                          'qr',
                          'QR 결제',
                          Icons.qr_code,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // 하단 버튼
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
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: Colors.grey),
                    ),
                    child: const Text(
                      '이전',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () => _processPayment(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      '결제하기',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }

  Widget _buildPaymentMethodCard(String method, String title, IconData icon) {
    final isSelected = selectedPaymentMethod == method;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = method;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? Colors.red[50] : Colors.white,
          border: Border.all(
            color: isSelected ? Colors.red : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 40,
              color: isSelected ? Colors.red : Colors.grey[600],
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.red : Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _processPayment() {
    // 결제 처리 로직
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                selectedPaymentMethod == 'card'
                    ? '카드 결제 진행 중...'
                    : 'QR 결제 진행 중...',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        );
      },
    );

    // 3초 후 결제 완료 처리
    Future.delayed(const Duration(seconds: 3), () async {
      Navigator.of(context).pop(); // 로딩 다이얼로그 닫기

      // 주문 완료 처리
      final success = await context.read<OrderProvider>().completeOrder(
            context.read<CartProvider>().items,
            selectedPaymentMethod,
          );

      if (success) {
        // 장바구니 비우기
        context.read<CartProvider>().clearCart();

        // 주문 완료 화면으로 이동
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const OrderCompleteScreen(),
          ),
        );
      } else {
        // 에러 처리
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('주문 처리 중 오류가 발생했습니다. 다시 시도해주세요.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }
}
