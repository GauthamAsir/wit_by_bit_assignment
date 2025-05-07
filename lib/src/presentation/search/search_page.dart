import 'package:amerika_foods/src/core/sizes/paddings.dart';
import 'package:amerika_foods/src/core/theme/app_colors.dart';
import 'package:amerika_foods/src/core/utils/extensions.dart';
import 'package:amerika_foods/src/presentation/widgets/cart_bottom_tile.dart';
import 'package:amerika_foods/src/presentation/search/view_model/search_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/sizes/sizes.dart';
import '../../core/utils/app_routes.dart';
import '../dashboard/widgets/action_icon_buttons.dart';
import '../dashboard/widgets/product_tile.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  static const routeName = 'search';

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final TextEditingController searchController = TextEditingController();

  final searchRecommendations = [
    'Burgers',
    'Chicken',
    'Pizza',
    'Drinks',
    'Desserts',
    'Sides',
  ];

  @override
  void initState() {
    super.initState();
    searchController.addListener(_searchListener);
  }

  void _searchListener() {
    ref.read(searchProvider.notifier).search(searchController.text);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchList = ref.watch(searchProvider);

    return PopScope(
      onPopInvokedWithResult: (_, __) {
        ref.invalidate(searchProvider);
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              floating: true,
              snap: true,
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
                  Sizes.w8,
                  Expanded(
                    child: Hero(
                      tag: 'search_field',
                      child: Material(
                        color: Colors.transparent,
                        child: TextFormField(
                          controller: searchController,
                          style: context.ll,
                          decoration: InputDecoration(
                            hintText: 'Search',
                            constraints: BoxConstraints(maxHeight: 40.h),
                            contentPadding: Paddings.p12.horizontally,
                            prefixIconConstraints: BoxConstraints(
                              minWidth: 38.w,
                            ),
                            isDense: true,
                            prefixIcon: Icon(Icons.search, size: 18.h),
                            suffixIcon: Icon(
                              Icons.mic_none_outlined,
                              size: 18.w,
                            ),
                            hintStyle: context.ll.copyWith(
                              color: AppColors.secondaryColor.withValues(
                                alpha: .5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Sizes.h16,
                Padding(
                  padding: Paddings.p16.horizontally,
                  child: Text(
                    searchList.isEmpty
                        ? 'Search recommendations'
                        : '${searchList.length} Search results...',
                    style: context.ts.copyWith(fontWeight: FontWeight.w400),
                  ),
                ),
                searchList.isEmpty ? Sizes.h24 : const SizedBox.shrink(),
                searchList.isNotEmpty
                    ? const SizedBox.shrink()
                    : Padding(
                      padding: Paddings.p16.horizontally,
                      child: Wrap(
                        spacing: 8.w,
                        runSpacing: 4.h,
                        children: List.generate(searchRecommendations.length, (
                          index,
                        ) {
                          return FilterChip(
                            label: Text(searchRecommendations[index]),
                            visualDensity: VisualDensity.compact,
                            labelPadding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            elevation: 0,
                            showCheckmark: false,
                            labelStyle: context.bm.copyWith(
                              color: AppColors.primaryColor,
                            ),
                            onSelected: (val) {
                              searchController.clear();
                              searchController.text =
                                  searchRecommendations[index];
                            },
                            padding: EdgeInsets.zero,
                            side: BorderSide.none,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            backgroundColor: AppColors.primaryColor.withValues(
                              alpha: .08,
                            ),
                          );
                        }),
                      ),
                    ),
                searchList.isEmpty
                    ? AspectRatio(
                      aspectRatio: 1,
                      child: Center(
                        child: Text('No items found', style: context.ll),
                      ),
                    )
                    : ListView.separated(
                      itemCount: searchList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: Paddings.p16.horizontally,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding:
                              index == 0
                                  ? Paddings.p24.onlyTop
                                  : EdgeInsets.zero,
                          child: ProductTile(productModel: searchList[index]),
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
              ]),
            ),
          ],
        ),
        bottomSheet: const CartBottomTile(),
      ),
    );
  }
}
