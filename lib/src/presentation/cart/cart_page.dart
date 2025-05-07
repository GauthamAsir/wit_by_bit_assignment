import 'package:amerika_foods/src/core/presentation/widgets/custom_app_bar.dart';
import 'package:amerika_foods/src/core/sizes/sizes.dart';
import 'package:amerika_foods/src/core/utils/extensions.dart';
import 'package:amerika_foods/src/presentation/cart/view_model/cart_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/sizes/paddings.dart';
import '../../core/theme/app_colors.dart';
import '../widgets/product_tile.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  static const routeName = 'cart';

  @override
  Widget build(BuildContext context, ref) {
    final cartList = ref.watch(cartProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const CustomSliverAppBar(title: 'Cart'),
          SliverList(
            delegate: SliverChildListDelegate([
              cartList.isEmpty
                  ? AspectRatio(
                    aspectRatio: .7,
                    child: Center(
                      child: Text('No items added in cart', style: context.ts),
                    ),
                  )
                  : ListView.separated(
                    itemCount: cartList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: Paddings.p16.horizontally,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            index == 0 ? Paddings.p24.onlyTop : EdgeInsets.zero,
                        child: ProductTile(
                          productModel: cartList[index].productModel,
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        color: AppColors.borderColor,
                        height: 48.h,
                      );
                    },
                  ),
              Sizes.h100,
              Sizes.h100,
            ]),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: Paddings.p16.copyWith(
          bottom: Paddings.p16.top,
          top: Paddings.p16.top,
        ),
        decoration: const BoxDecoration(color: Colors.white),
        child: Hero(
          tag: 'cart_checkout_bt',
          child: ElevatedButton(
            onPressed: cartList.isEmpty ? null : () {},
            child: const Text('Proceed to checkout'),
          ),
        ),
      ),
    );
  }
}
