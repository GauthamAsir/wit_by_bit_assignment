import 'dart:convert';

import 'package:amerika_foods/src/data/models/product_model.dart';
import 'package:uuid/uuid.dart';

class CartItemModel {
  int count;
  final String id;
  final ProductModel productModel;

  CartItemModel({required this.count, required this.productModel, String? id})
    : id = id ?? const Uuid().v4();

  CartItemModel copyWith({int? count}) {
    return CartItemModel(
      count: count ?? this.count,
      productModel: productModel,
    );
  }

  Map<String, dynamic> toJson() {
    return {'count': count, 'productModel': productModel.toMap()};
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      count: json['count'],
      productModel: ProductModel.fromMap(json['productModel']),
    );
  }

  static List<CartItemModel> listFromJson(String jsonStr) {
    final decoded = jsonDecode(jsonStr) as List<dynamic>;
    return decoded.map((e) => CartItemModel.fromJson(e)).toList();
  }

  static String listToJson(List<CartItemModel> list) {
    final encoded = list.map((e) => e.toJson()).toList();
    return jsonEncode(encoded);
  }
}
