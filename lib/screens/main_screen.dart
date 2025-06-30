import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/menu_provider.dart';
import '../widgets/left_sidebar.dart';
import '../widgets/main_content_with_banner.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MenuProvider>().loadMenuItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          // 왼쪽 사이드바 (로고 + 카테고리)
          const SizedBox(
            width: 300,
            child: LeftSidebar(),
          ),
          // 오른쪽 메인 콘텐츠 (배너 + 상품 + 장바구니)
          Expanded(
            child: MainContentWithBanner(),
          ),
        ],
      ),
    );
  }
}
