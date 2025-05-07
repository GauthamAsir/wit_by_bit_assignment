import 'package:amerika_foods/src/core/utils/app_routes.dart';
import 'package:amerika_foods/src/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.actions,
    this.titleStyle,
    this.backgroundColor,
    this.elevation,
  });

  final String? title;
  final TextStyle? titleStyle;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title == null ? null : Text(title ?? ''),
      titleTextStyle: titleStyle,
      elevation: elevation,
      backgroundColor: backgroundColor,
      // leadingWidth: 60.w,
      leading:
          AppRouter.canPop()
              ? IconButton(
                icon: Icon(Icons.chevron_left, color: context.cs.secondary),
                onPressed: () => AppRouter.pop(),
              )
              : null,
      automaticallyImplyLeading: false,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    super.key,
    this.title,
    this.actions,
    this.titleStyle,
    this.backgroundColor,
    this.elevation,
  });

  final String? title;
  final TextStyle? titleStyle;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: title == null ? null : Text(title!),
      titleTextStyle: titleStyle,
      elevation: elevation,
      floating: true,
      backgroundColor: backgroundColor,
      leading:
          AppRouter.canPop()
              ? IconButton(
                icon: Icon(Icons.chevron_left, color: context.cs.secondary),
                onPressed: () => AppRouter.pop(),
              )
              : null,
      automaticallyImplyLeading: false,
      actions: actions,
    );
  }
}
