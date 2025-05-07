import 'dart:async';

import 'package:amerika_foods/src/data/models/product_model.dart';
import 'package:amerika_foods/src/utils/dummy_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchNotifier extends StateNotifier<List<ProductModel>> {
  final Ref ref;
  Timer? _debounce;

  SearchNotifier(this.ref) : super([]);

  void search(String query) {
    _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      final allProducts = List<ProductModel>.from(searchableProductList);

      final result = allProducts.where((product) {
        return product.title.toLowerCase().contains(query.toLowerCase());
      }).toList();

      state = result;
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}

final searchProvider =
StateNotifierProvider<SearchNotifier, List<ProductModel>>((ref) {
  return SearchNotifier(ref);
});