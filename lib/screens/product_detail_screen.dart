import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/menu_item.dart';
import '../providers/cart_provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final MenuItem menuItem;

  const ProductDetailScreen({super.key, required this.menuItem});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;
  List<MenuOption> selectedOptions = [];

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
                Text(
                  widget.menuItem.nameKr,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Text(
                  '₩${_formatPrice(widget.menuItem.price)}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 상품 이미지와 설명
                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: 300,
                          height: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey[200],
                          ),
                          child: const Icon(
                            Icons.fastfood,
                            size: 100,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          widget.menuItem.description,
                          style:
                              const TextStyle(fontSize: 16, color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // 원하시는 구성을 선택해 주세요!
                  const Text(
                    '원하시는 구성을 선택해 주세요!',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  // 옵션 그룹들 표시
                  if (widget.menuItem.optionGroups.isNotEmpty)
                    ...widget.menuItem.optionGroups.map((group) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              group.nameKr,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              height: 120,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: group.options.length,
                                itemBuilder: (context, index) {
                                  final option = group.options[index];
                                  final isSelected = selectedOptions
                                      .any((o) => o.id == option.id);

                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        // 같은 그룹의 다른 옵션들 제거
                                        selectedOptions.removeWhere((o) =>
                                            group.options.any((groupOption) =>
                                                groupOption.id == o.id));
                                        // 새 옵션 추가
                                        selectedOptions.add(option);
                                      });
                                    },
                                    child: Container(
                                      width: 100,
                                      margin: const EdgeInsets.only(right: 12),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: isSelected
                                              ? Colors.red
                                              : Colors.grey[300]!,
                                          width: isSelected ? 2 : 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              margin: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              child: const Icon(
                                                  Icons.local_drink,
                                                  size: 40),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Text(
                                              option.nameKr,
                                              style:
                                                  const TextStyle(fontSize: 12),
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          if (isSelected)
                                            Container(
                                              width: 20,
                                              height: 20,
                                              margin: const EdgeInsets.only(
                                                  bottom: 8),
                                              decoration: const BoxDecoration(
                                                color: Colors.red,
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.check,
                                                color: Colors.white,
                                                size: 14,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        )),

                  // 기존 옵션들도 표시 (backward compatibility)
                  if (widget.menuItem.options.isNotEmpty &&
                      widget.menuItem.optionGroups.isEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '런치킨박스 음료 교환',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 120,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.menuItem.options.length,
                            itemBuilder: (context, index) {
                              final option = widget.menuItem.options[index];
                              final isSelected =
                                  selectedOptions.contains(option);

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedOptions.clear();
                                    selectedOptions.add(option);
                                  });
                                },
                                child: Container(
                                  width: 100,
                                  margin: const EdgeInsets.only(right: 12),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: isSelected
                                          ? Colors.red
                                          : Colors.grey[300]!,
                                      width: isSelected ? 2 : 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          margin: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: const Icon(Icons.local_drink,
                                              size: 40),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                          option.nameKr,
                                          style: const TextStyle(fontSize: 12),
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      if (isSelected)
                                        Container(
                                          width: 20,
                                          height: 20,
                                          margin:
                                              const EdgeInsets.only(bottom: 8),
                                          decoration: const BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: 14,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),

                  // 같이 먹기 좋은 메뉴 추천드려요!
                  const Text(
                    '같이 먹기 좋은 메뉴 추천드려요!',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 120,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildRecommendationItem('닭껍질튀김', '+3,500'),
                        _buildRecommendationItem('포테이토', '+2,800'),
                        _buildRecommendationItem('버터비스켓', '+2,600'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 하단 버튼 영역
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
                // 이전 버튼
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
                // 장바구니에 담기 버튼
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: (selectedOptions.isNotEmpty ||
                            (widget.menuItem.options.isEmpty &&
                                widget.menuItem.optionGroups.isEmpty))
                        ? () {
                            context
                                .read<CartProvider>()
                                .addItem(widget.menuItem, selectedOptions);
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    '${widget.menuItem.nameKr}이(가) 장바구니에 추가되었습니다.'),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      '장바구니에 담기',
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

  Widget _buildRecommendationItem(String name, String price) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(Icons.fastfood, size: 40),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Text(
                  price,
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
