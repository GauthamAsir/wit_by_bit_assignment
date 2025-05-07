import 'package:amerika_foods/src/core/utils/shared_pref_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/cart_item_model.dart';
import '../../../data/models/product_model.dart';

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItemModel>>((ref) {
  return CartNotifier(ref);
});


class CartNotifier extends StateNotifier<List<CartItemModel>> {

  final Ref ref;

  static const _cartKey = 'cart_items';

  CartNotifier(this.ref) : super([]) {
    _loadFromPrefs();
  }

  int getTotalPrice() {
    return state.fold(0, (total, item) => total + (item.count * item.productModel.price));
  }

  int get totalItems => state.fold(0, (sum, item) => sum + item.count);

  Future<void> _loadFromPrefs() async {
    final prefs = await ref.read(sharedPrefProvider.future);
    final jsonStr = prefs.getString(_cartKey);
    if (jsonStr != null) {
      state = CartItemModel.listFromJson(jsonStr);
    }
  }

  int getCount(ProductModel product) {
    final index = state.indexWhere((e) => e.productModel.id == product.id);
    return index != -1 ? state[index].count : 0;
  }

  Future<void> _saveToPrefs() async {
    final prefs = await ref.read(sharedPrefProvider.future);
    await prefs.setString(_cartKey, CartItemModel.listToJson(state));
  }

  void increment(ProductModel product) async {
    final index = state.indexWhere((e) => e.productModel.id == product.id);
    if (index != -1) {
      final item = state[index];
      if (item.count < 10) {
        state = [
          for (int i = 0; i < state.length; i++)
            if (i == index) item.copyWith(count: item.count + 1) else state[i],
        ];
      }
    } else {
      state = [...state, CartItemModel(count: 1, productModel: product)];
    }
    await _saveToPrefs();
  }

  void decrement(ProductModel product) async {
    final index = state.indexWhere((e) => e.productModel.id == product.id);
    if (index != -1) {
      final item = state[index];
      if (item.count > 1) {
        state = [
          for (int i = 0; i < state.length; i++)
            if (i == index) item.copyWith(count: item.count - 1) else state[i],
        ];
      } else {
        state = state.where((e) => e.productModel.id != product.id).toList();
      }
      await _saveToPrefs();
    }
  }
}
