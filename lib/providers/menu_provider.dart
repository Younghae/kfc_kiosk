import 'package:flutter/material.dart';
import '../models/menu_item.dart';

class MenuProvider with ChangeNotifier {
  List<MenuItem> _menuItems = [];
  String _selectedCategory = '베스트 메뉴';
  final GlobalKey<State> _productGridKey = GlobalKey<State>();

  List<MenuItem> get menuItems => _menuItems;
  String get selectedCategory => _selectedCategory;
  GlobalKey<State> get productGridKey => _productGridKey;

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
        nameKr: '핫스낵',
        description: '바삭한 핫스낵',
        price: 2900,
        originalPrice: 5500,
        category: '사이드 스낵',
        imageUrl: 'assets/images/hot_snack.png',
        isNew: true,
        isRecommended: true,
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
      MenuItem(
        id: '7',
        name: 'Burger Deluxe',
        nameKr: '디럭스버거',
        description: '프리미엄 디럭스버거',
        price: 8900,
        originalPrice: 8900,
        category: '버거',
        imageUrl: 'assets/images/deluxe_burger.png',
        isRecommended: true,
      ),
      MenuItem(
        id: '8',
        name: 'Twister Wrap',
        nameKr: '트위스터랩',
        description: '맛있는 트위스터랩',
        price: 6500,
        originalPrice: 6500,
        category: '트위스터',
        imageUrl: 'assets/images/twister.png',
      ),
      MenuItem(
        id: '9',
        name: 'Chicken Rice Bowl',
        nameKr: '치킨라이스볼',
        description: '든든한 치킨라이스볼',
        price: 5900,
        originalPrice: 5900,
        category: '치밥',
        imageUrl: 'assets/images/chicken_rice.png',
      ),
      MenuItem(
        id: '10',
        name: 'Orange Juice',
        nameKr: '오렌지주스',
        description: '신선한 오렌지주스',
        price: 3200,
        originalPrice: 3200,
        category: '음료',
        imageUrl: 'assets/images/orange_juice.png',
      ),
      MenuItem(
        id: '11',
        name: 'Beer',
        nameKr: '맥주',
        description: '시원한 맥주',
        price: 4500,
        originalPrice: 4500,
        category: '주류',
        imageUrl: 'assets/images/beer.png',
      ),
      MenuItem(
        id: '12',
        name: 'Wings',
        nameKr: '윙',
        description: '매콤한 치킨윙',
        price: 7800,
        originalPrice: 7800,
        category: '치킨',
        imageUrl: 'assets/images/wings.png',
      ),
      // 베스트 메뉴에 추가할 5가지 메뉴
      MenuItem(
        id: '13',
        name: 'Crispy Chicken',
        nameKr: '크리스피치킨',
        description: '바삭바삭한 크리스피치킨',
        price: 16900,
        originalPrice: 19900,
        category: '치킨',
        imageUrl: 'assets/images/crispy_chicken.png',
        isRecommended: true,
        isNew: true,
      ),
      MenuItem(
        id: '14',
        name: 'Zinger Burger Set',
        nameKr: '징거버거세트',
        description: '징거버거 + 음료 + 감자튀김',
        price: 8900,
        originalPrice: 12400,
        category: '버거',
        imageUrl: 'assets/images/zinger_set.png',
        isRecommended: true,
        isHot: true,
      ),
      MenuItem(
        id: '15',
        name: 'Nashville Hot',
        nameKr: '내슈빌핫',
        description: '매콤한 내슈빌핫 치킨',
        price: 14900,
        originalPrice: 17900,
        category: '치킨',
        imageUrl: 'assets/images/nashville_hot.png',
        isRecommended: true,
        isHot: true,
      ),
      MenuItem(
        id: '16',
        name: 'Popcorn Chicken',
        nameKr: '팝콘치킨',
        description: '한입에 쏙 들어가는 팝콘치킨',
        price: 4900,
        originalPrice: 6500,
        category: '사이드 스낵',
        imageUrl: 'assets/images/popcorn_chicken.png',
        isRecommended: true,
        isNew: true,
      ),
      MenuItem(
        id: '17',
        name: 'Coleslaw Salad',
        nameKr: '코울슬로샐러드',
        description: '신선한 코울슬로샐러드',
        price: 2900,
        originalPrice: 3900,
        category: '사이드 스낵',
        imageUrl: 'assets/images/coleslaw.png',
        isRecommended: true,
      ),
    ];
    notifyListeners();
  }
}
