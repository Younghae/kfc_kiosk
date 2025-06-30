import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/menu_provider.dart';
import '../widgets/top_header.dart';
import '../widgets/main_content_area.dart';
import '../widgets/cart_summary.dart';

class RightMainContent extends StatelessWidget {
  const RightMainContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 상단 헤더 (광고 이미지 + 버튼들)
        const TopHeader(),

        // 메인 콘텐츠 영역
        Expanded(
          child: Row(
            children: [
              // 상품 표시 영역
              Expanded(
                flex: 7,
                child: MainContentArea(),
              ),

              // 장바구니 영역
              SizedBox(
                width: 350,
                child: Container(
                  color: Colors.grey[50],
                  child: const CartSummary(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
