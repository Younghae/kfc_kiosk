import 'package:flutter/material.dart';
import '../models/menu_item.dart';

class MenuProvider with ChangeNotifier {
  List<MenuItem> _menuItems = [];
  String _selectedCategory = '베스트 메뉴';

  List<MenuItem> get menuItems => _menuItems;
  String get selectedCategory => _selectedCategory;

  List<MenuItem> get filteredMenuItems {
    if (_selectedCategory == '베스트 메뉴') {
      return _menuItems.where((item) => item.isRecommended).toList();
    }
    return _menuItems
        .where((item) => item.category == _selectedCategory)
        .toList();
  }

  List<String> get categories => [
        '베스트 메뉴',
        '버거',
        '트위스터',
        '치밥',
        '치킨',
        '사이드 스낵',
        '음료',
        '주류',
      ];

  void setSelectedCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void loadMenuItems() {
    _menuItems = [
      MenuItem(
        id: '1',
        name: 'Ranch Kin Box',
        nameKr: '런치킨박스',
        description: '한정판 정거데블다운콩다리 런치킨박스',
        price: 10900,
        originalPrice: 15600,
        category: '치킨',
        imageUrl: 'assets/images/lunch_kin_box.png',
        isRecommended: true,
        isNew: true,
        optionGroups: [
          OptionGroup(
            id: 'drinks',
            name: 'Drinks',
            nameKr: '음료 선택',
            isRequired: true,
            options: [
              MenuOption(
                  id: 'drink1',
                  name: 'Cola M',
                  nameKr: '콜라 M',
                  additionalPrice: 0),
              MenuOption(
                  id: 'drink2',
                  name: 'Diet Pepsi Cola M',
                  nameKr: '다이어트펩시콜라 M',
                  additionalPrice: 0),
              MenuOption(
                  id: 'drink3',
                  name: 'Sprite M',
                  nameKr: '스프라이트 M',
                  additionalPrice: 0),
              MenuOption(
                  id: 'drink4',
                  name: 'Hot Coffee M',
                  nameKr: '핫커피 M',
                  additionalPrice: 0),
            ],
          ),
        ],
        options: [
          MenuOption(
              id: 'drink1', name: 'Cola M', nameKr: '콜라 M', additionalPrice: 0),
          MenuOption(
              id: 'drink2',
              name: 'Diet Pepsi Cola M',
              nameKr: '다이어트펩시콜라 M',
              additionalPrice: 0),
          MenuOption(
              id: 'drink3',
              name: 'Sprite M',
              nameKr: '스프라이트 M',
              additionalPrice: 0),
          MenuOption(
              id: 'drink4',
              name: 'Hot Coffee M',
              nameKr: '핫커피 M',
              additionalPrice: 0),
        ],
      ),
      MenuItem(
        id: '2',
        name: 'Zinger Burger',
        nameKr: '징거버거',
        description: '매콤한 징거버거',
        price: 7600,
        originalPrice: 7600,
        category: '치밥',
        imageUrl: 'assets/images/zinger_burger.png',
        isHot: true,
      ),
      MenuItem(
        id: '3',
        name: 'Original Chicken',
        nameKr: '오리지널치킨',
        description: 'KFC 대표 오리지널치킨',
        price: 18900,
        originalPrice: 27600,
        category: '치킨',
        imageUrl: 'assets/images/original_chicken.png',
        isRecommended: true,
      ),
      MenuItem(
        id: '4',
        name: 'Hot Snack',
        nameKr: '핫스낵 ₩2,900',
        description: '바삭한 핫스낵',
        price: 2900,
        originalPrice: 5500,
        category: '사이드 스낵',
        imageUrl: 'assets/images/hot_snack.png',
        isNew: true,
      ),
      MenuItem(
        id: '5',
        name: 'Cola',
        nameKr: '콜라',
        description: '시원한 콜라',
        price: 2300,
        originalPrice: 2300,
        category: '음료',
        imageUrl: 'assets/images/cola.png',
      ),
      MenuItem(
        id: '6',
        name: 'French Fries',
        nameKr: '포테이토',
        description: '바삭한 감자튀김',
        price: 2800,
        originalPrice: 2800,
        category: '사이드 스낵',
        imageUrl: 'assets/images/fries.png',
      ),
    ];
    notifyListeners();
  }
}
