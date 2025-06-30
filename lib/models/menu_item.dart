class MenuItem {
  final String id;
  final String name;
  final String nameKr;
  final String description;
  final int price;
  final int originalPrice;
  final String category;
  final String imageUrl;
  final List<MenuOption> options;
  final List<OptionGroup> optionGroups;
  final bool isRecommended;
  final bool isNew;
  final bool isHot;

  MenuItem({
    required this.id,
    required this.name,
    required this.nameKr,
    required this.description,
    required this.price,
    required this.originalPrice,
    required this.category,
    required this.imageUrl,
    this.options = const [],
    this.optionGroups = const [],
    this.isRecommended = false,
    this.isNew = false,
    this.isHot = false,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      nameKr: json['nameKr'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? 0,
      originalPrice: json['originalPrice'] ?? 0,
      category: json['category'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      options: (json['options'] as List<dynamic>?)
              ?.map((option) => MenuOption.fromJson(option))
              .toList() ??
          [],
      optionGroups: (json['optionGroups'] as List<dynamic>?)
              ?.map((group) => OptionGroup.fromJson(group))
              .toList() ??
          [],
      isRecommended: json['isRecommended'] ?? false,
      isNew: json['isNew'] ?? false,
      isHot: json['isHot'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nameKr': nameKr,
      'description': description,
      'price': price,
      'originalPrice': originalPrice,
      'category': category,
      'imageUrl': imageUrl,
      'options': options.map((option) => option.toJson()).toList(),
      'optionGroups': optionGroups.map((group) => group.toJson()).toList(),
      'isRecommended': isRecommended,
      'isNew': isNew,
      'isHot': isHot,
    };
  }
}

class OptionGroup {
  final String id;
  final String name;
  final String nameKr;
  final bool isRequired;
  final List<MenuOption> options;

  OptionGroup({
    required this.id,
    required this.name,
    required this.nameKr,
    required this.isRequired,
    required this.options,
  });

  factory OptionGroup.fromJson(Map<String, dynamic> json) {
    return OptionGroup(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      nameKr: json['nameKr'] ?? '',
      isRequired: json['isRequired'] ?? false,
      options: (json['options'] as List<dynamic>?)
              ?.map((option) => MenuOption.fromJson(option))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nameKr': nameKr,
      'isRequired': isRequired,
      'options': options.map((option) => option.toJson()).toList(),
    };
  }
}

class MenuOption {
  final String id;
  final String name;
  final String nameKr;
  final int additionalPrice;
  final bool isRequired;

  MenuOption({
    required this.id,
    required this.name,
    required this.nameKr,
    required this.additionalPrice,
    this.isRequired = false,
  });

  factory MenuOption.fromJson(Map<String, dynamic> json) {
    return MenuOption(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      nameKr: json['nameKr'] ?? '',
      additionalPrice: json['additionalPrice'] ?? 0,
      isRequired: json['isRequired'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nameKr': nameKr,
      'additionalPrice': additionalPrice,
      'isRequired': isRequired,
    };
  }
}
