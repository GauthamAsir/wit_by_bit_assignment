import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/custom_router.dart';
import '../theme/app_colors.dart';

class AppRouter {
  static final AppRouter _instance = AppRouter._internal();

  factory AppRouter() => _instance;

  AppRouter._internal();

  static late WidgetRef _ref;

  // Initialize with ref (Call this in main.dart)
  static void init(WidgetRef ref) {
    _ref = ref;
  }

  /// Scaffold Messenger key for showing snackbars
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  /// Shows a loading dialog
  static Future<T?> showLoadingDialog<T>([String text = 'Loading']) {
    if (navigatorKey.currentState?.overlay?.context == null) {
      return Future<T>.value();
    }
    return showDialog<T>(
      context: navigatorKey.currentState!.overlay!.context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        final Size size = MediaQuery.of(context).size;
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: SizedBox(
            height: size.height * 0.1,
            width: size.width * 0.2,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                const CircularProgressIndicator(),
                Text(
                  text,
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Shows an error snackbar
  static void showErrorSnackbar([String message = 'Error..']) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
        content: Row(
          children: <Widget>[
            Icon(Icons.cancel, size: 24.sp, color: Colors.red),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                message,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.backgroundColor,
      ),
    );
  }

  /// Shows a success snackbar
  static void showSuccessSnackbar([String message = 'Success']) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
        content: Row(
          children: <Widget>[
            Icon(
              Icons.check_circle,
              size: 24.sp,
              color: AppColors.primaryColor,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.backgroundColor,
      ),
    );
  }

  /// Pushes a new page using GoRouter
  static void push(String path, {Map<String, String>? params, Object? extra}) {
    final router = _ref.read(goRouterProvider);
    router.pushNamed(
      path,
      extra: extra,
      pathParameters: params ?? <String, String>{},
    );
  }

  static void goNamed(String path, {Map<String, String>? params}) {
    final router = _ref.read(goRouterProvider);
    router.goNamed(path, pathParameters: params ?? <String, String>{});
  }

  /// Pops the current page
  static void pop() {
    final router = _ref.read(goRouterProvider);
    if (router.canPop()) {
      router.pop();
    }
  }

  /// Checks if the current page can be popped
  static bool canPop() {
    final router = _ref.read(goRouterProvider);
    return router.canPop();
  }
}
