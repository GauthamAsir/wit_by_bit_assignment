import 'package:amerika_foods/src/data/models/product_model.dart';

class CategoryModel {
  final String name;
  final List<ProductModel> items;

  CategoryModel({required this.name, required this.items});

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      name: map['name'] ?? '',
      items: List<ProductModel>.from(
        (map['items'] as List).map((item) => ProductModel.fromMap(item)),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'items': items.map((item) => item.toMap()).toList()};
  }
}
