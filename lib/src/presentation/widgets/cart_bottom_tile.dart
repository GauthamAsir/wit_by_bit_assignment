import 'package:amerika_foods/src/core/theme/app_colors.dart';
import 'package:amerika_foods/src/core/utils/app_routes.dart';
import 'package:amerika_foods/src/core/utils/extensions.dart';
import 'package:amerika_foods/src/presentation/cart/cart_page.dart';
import 'package:amerika_foods/src/presentation/cart/view_model/cart_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/sizes/paddings.dart';

class CartBottomTile extends ConsumerWidget {
  const CartBottomTile({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final cartList = ref.watch(cartProvider);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      child:
          cartList.isEmpty
              ? const SizedBox.shrink()
              : Container(
                padding: Paddings.p16.copyWith(
                  bottom: Paddings.p16.top,
                  top: Paddings.p16.top,
                ),
                decoration: const BoxDecoration(color: Colors.white),
                child: Row(
                  children: [
                    Text(
                      '${ref.read(cartProvider.notifier).totalItems} item${ref.read(cartProvider.notifier).totalItems == 1 ? '' : 's'}',
                      style: context.ll.copyWith(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 20.h,
                      child: VerticalDivider(
                        color: AppColors.borderColor,
                        width: 16.w,
                      ),
                    ),
                    Text(
                      ref
                          .read(cartProvider.notifier)
                          .getTotalPrice()
                          .toString()
                          .toIndianCurrency(),
                      style: context.ll.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const Spacer(),
                    Flexible(
                      child: Hero(
                        tag: 'cart_checkout_bt',
                        child: ElevatedButton(
                          onPressed: () {
                            AppRouter.push(CartPage.routeName);
                          },
                          child: const Text('View cart'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}
