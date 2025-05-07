import 'package:amerika_foods/src/core/sizes/sizes.dart';
import 'package:amerika_foods/src/core/theme/app_colors.dart';
import 'package:amerika_foods/src/core/utils/app_routes.dart';
import 'package:amerika_foods/src/core/utils/extensions.dart';
import 'package:amerika_foods/src/presentation/dashboard/widgets/action_icon_buttons.dart';
import 'package:amerika_foods/src/presentation/widgets/cart_bottom_tile.dart';
import 'package:amerika_foods/src/presentation/dashboard/widgets/product_tile.dart';
import 'package:amerika_foods/src/presentation/search/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../generated/assets.dart';
import '../../core/sizes/paddings.dart';
import '../../utils/dummy_data.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  static const routeName = 'dashboard';

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final recommendedItems = [];

  final ScrollController _scrollController = ScrollController();

  final StateProvider<int> selectedIndexProvider = StateProvider((ref) => 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            // pinned: true,
            // floating: true,
            // snap: true,
            title: Row(
              children: [
                Hero(
                  tag: 'back_bt',
                  child: ActionIconButton(
                    onTap: () {
                      AppRouter.pop();
                    },
                  ),
                ),
              ],
            ),
            actions: [
              Hero(
                tag: 'search_field',
                child: ActionIconButton(
                  onTap: () {
                    AppRouter.push(SearchPage.routeName);
                  },
                  iconData: Icons.search,
                ),
              ),
              Sizes.w16,
              ActionIconButton(onTap: () {}, iconData: Icons.share),
            ],
            actionsPadding: Paddings.p16.horizontally,
            expandedHeight: 180.h,
            flexibleSpace: Image.asset(
              Assets.imagesAppBarImage,
              width: double.infinity,
              fit: BoxFit.cover,
              height: double.infinity,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Sizes.h16,
              Padding(
                padding: Paddings.p16.horizontally,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Amerika Foods',
                            style: context.tl.copyWith(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        ActionIconButton(
                          onTap: () {},
                          iconData: Icons.favorite_border,
                          border: Border.all(color: AppColors.borderColor),
                        ),
                      ],
                    ),
                    const Text('American, Fast Food, Burgers'),
                    Sizes.h16,
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow, size: 18.w),
                        Sizes.w4,
                        Text(
                          '4.5',
                          style: context.lm.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Sizes.w16,
                        SizedBox(
                          height: 20.h,
                          child: const VerticalDivider(
                            width: 1,
                            color: AppColors.borderColor,
                            thickness: 1,
                          ),
                        ),
                        Sizes.w16,
                        Icon(
                          Icons.chat_outlined,
                          color: Colors.green,
                          size: 18.w,
                        ),
                        Sizes.w4,
                        Text(
                          '1K+ reviews',
                          style: context.lm.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Sizes.w16,
                        SizedBox(
                          height: 20.h,
                          child: const VerticalDivider(
                            width: 1,
                            color: AppColors.borderColor,
                            thickness: 1,
                          ),
                        ),
                        Sizes.w16,
                        Icon(
                          Icons.access_time,
                          color: Colors.blueAccent,
                          size: 18.w,
                        ),
                        Sizes.w4,
                        Text(
                          '15 mins',
                          style: context.lm.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Sizes.h16,
                    const Divider(
                      color: AppColors.borderColor,
                      indent: 0,
                      endIndent: 0,
                      height: 1,
                    ),
                  ],
                ),
              ),
              Sizes.h16,
              Consumer(
                builder: (context, ref, child) {
                  final selectedIndex = ref.watch(selectedIndexProvider);

                  return DefaultTabController(
                    length: categoriesList.length,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TabBar(
                          tabs: List.generate(
                            categoriesList.length,
                            (index) => Tab(text: categoriesList[index].name),
                          ),
                          isScrollable: true,
                          padding: EdgeInsets.zero,
                          labelStyle: context.bm.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryColor,
                          ),
                          unselectedLabelStyle: context.bm.copyWith(
                            color: AppColors.unSelectedColor,
                            fontWeight: FontWeight.w500,
                          ),
                          indicatorColor: AppColors.primaryColor,
                          tabAlignment: TabAlignment.start,
                          onTap: (index) {
                            ref.read(selectedIndexProvider.notifier).state =
                                index;
                          },
                        ),
                        ListView.separated(
                          itemCount: categoriesList[selectedIndex].items.length,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: Paddings.p16.horizontally,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  index == 0
                                      ? Paddings.p24.onlyTop
                                      : EdgeInsets.zero,
                              child: ProductTile(
                                productModel:
                                    categoriesList[selectedIndex].items[index],
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
                      ],
                    ),
                  );
                },
              ),
              Sizes.h100,
            ]),
          ),
        ],
      ),
      bottomSheet: const CartBottomTile(),
    );
  }
}
