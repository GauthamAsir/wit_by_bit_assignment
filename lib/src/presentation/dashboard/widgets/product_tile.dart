import 'package:amerika_foods/src/core/sizes/sizes.dart';
import 'package:amerika_foods/src/core/theme/app_colors.dart';
import 'package:amerika_foods/src/core/utils/extensions.dart';
import 'package:amerika_foods/src/data/models/product_model.dart';
import 'package:amerika_foods/src/presentation/cart/view_model/cart_notifier.dart';
import 'package:amerika_foods/src/presentation/dashboard/widgets/action_icon_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../generated/assets.dart';
import '../../../core/sizes/paddings.dart';

class ProductTile extends ConsumerWidget {
  const ProductTile({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context, ref) {
    final cartList = ref.watch(cartProvider);
    final index = cartList.indexWhere(
      (e) => e.productModel.id == productModel.id,
    );
    final int count = index != -1 ? cartList[index].count : 0;

    return Row(
      children: [
        Container(
          height: 120.w,
          width: 120.w,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Image.asset(Assets.imagesChiBurger),
        ),
        Sizes.w16,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productModel.title,
                style: context.ll.copyWith(fontWeight: FontWeight.w700),
              ),
              Sizes.h8,
              Text(
                productModel.description,
                style: context.lm.copyWith(fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 30.h),
              Row(
                children: [
                  Text(
                    productModel.price.toString().toIndianCurrency(
                      decimalDigits: 0,
                    ),
                    style: context.ll.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const Spacer(),
                  ActionIconButton(
                    onTap: () {
                      ref.read(cartProvider.notifier).decrement(productModel);
                    },
                    border: Border.all(
                      color:
                          count == 0
                              ? AppColors.borderColor
                              : AppColors.primaryColor,
                    ),
                    color:
                        count == 0
                            ? Colors.transparent
                            : AppColors.primaryColor.withValues(
                              alpha: .10,
                            ),
                    iconColor:
                        count == 0
                            ? AppColors.borderColor
                            : AppColors.primaryColor,
                    iconData: Icons.remove,
                  ),
                  Padding(
                    padding: Paddings.p16.horizontally,
                    child: Text(
                      count.toString(),
                      style: context.ll.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                  ActionIconButton(
                    onTap: () {
                      ref.read(cartProvider.notifier).increment(productModel);
                    },
                    border: Border.all(color: AppColors.primaryColor),
                    color: AppColors.primaryColor.withValues(alpha: .10),
                    iconColor: AppColors.primaryColor,
                    iconData: Icons.add,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
