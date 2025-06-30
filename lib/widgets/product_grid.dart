import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/menu_provider.dart';
import '../widgets/product_card.dart';

class ProductGrid extends StatefulWidget {
  const ProductGrid({super.key});

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  int currentPage = 0;
  final int itemsPerPage = 6; // 한 페이지당 6개 아이템 (2행 x 3열)

  @override
  void didUpdateWidget(ProductGrid oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 카테고리가 변경되면 첫 페이지로 리셋
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          currentPage = 0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MenuProvider>(
      builder: (context, menuProvider, child) {
        final allItems = menuProvider.filteredMenuItems;
        final totalPages =
            allItems.isEmpty ? 1 : (allItems.length / itemsPerPage).ceil();

        // 현재 페이지가 총 페이지 수를 초과하면 마지막 페이지로 조정
        if (currentPage >= totalPages) {
          currentPage = totalPages - 1;
        }

        // 현재 페이지의 아이템들
        final startIndex = currentPage * itemsPerPage;
        final endIndex = (startIndex + itemsPerPage).clamp(0, allItems.length);
        final currentPageItems = allItems.sublist(startIndex, endIndex);

        if (allItems.isEmpty) {
          return const Center(
            child: Text(
              '해당 카테고리에 상품이 없습니다.',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }

        return Column(
          children: [
            // 상품 그리드
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(), // 스크롤 비활성화
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: currentPageItems.length,
                  itemBuilder: (context, index) {
                    return ProductCard(menuItem: currentPageItems[index]);
                  },
                ),
              ),
            ),

            // 페이지네이션 영역
            Container(
              height: 80,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Colors.grey[300]!, width: 1),
                  bottom: BorderSide(color: Colors.grey[300]!, width: 1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 이전 버튼
                  SizedBox(
                    width: 90,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: currentPage > 0
                          ? () {
                              setState(() {
                                currentPage--;
                              });
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[600],
                        disabledBackgroundColor: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.chevron_left,
                            color: Colors.white,
                            size: 16,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '이전',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // 페이지 인디케이터 (중앙)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(totalPages, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        width: index == currentPage ? 12 : 8,
                        height: index == currentPage ? 12 : 8,
                        decoration: BoxDecoration(
                          color: index == currentPage
                              ? Colors.black
                              : Colors.grey[400],
                          shape: BoxShape.circle,
                        ),
                      );
                    }),
                  ),

                  // 다음 버튼
                  SizedBox(
                    width: 90,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: currentPage < totalPages - 1
                          ? () {
                              setState(() {
                                currentPage++;
                              });
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[600],
                        disabledBackgroundColor: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '다음',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 2),
                          Icon(
                            Icons.chevron_right,
                            color: Colors.white,
                            size: 16,
                          ),
                        ],
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
}
