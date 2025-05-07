import 'package:amerika_foods/src/presentation/cart/cart_page.dart';
import 'package:amerika_foods/src/presentation/dashboard/dashboard_page.dart';
import 'package:amerika_foods/src/presentation/search/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../core/utils/app_routes.dart';
import '../core/utils/custome_log_printer.dart';

// final goRouterRefreshProvider = Provider<GoRouterRefreshStream>((ref) {
//   return GoRouterRefreshStream(ref);
// });

final goRouterProvider = Provider<GoRouter>((ref) {

  // final refreshNotifier = ref.watch(goRouterRefreshProvider);

  return GoRouter(
    navigatorKey: AppRouter.navigatorKey,
    initialLocation: '/',
    // refreshListenable: refreshNotifier,
    errorBuilder: (context, state) {
      CustomLogPrinter.printLog('Route not found: ${state.uri.path}');
      return Scaffold(
        body: Center(child: SelectableText('${state.uri.path} Not Found')),
      );
    },
    // redirect: (context, state) {
    //   final loggedIn = authState.userModel != null;
    //   final loggingIn =
    //       state.matchedLocation == '/${LoginPage.routeName}' ||
    //       state.matchedLocation == '/${SignUpPage.routeName}' ||
    //       state.matchedLocation == '/${AuthPage.routeName}';
    //
    //   if (authState.isLoading) {
    //     return null;
    //   }
    //
    //   if (!loggedIn && !loggingIn) {
    //     return '/${AuthPage.routeName}';
    //   }
    //   if (loggedIn && loggingIn) {
    //     return '/';
    //   }
    //   return null;
    // },
    routes: [
      GoRoute(
        path: '/',
        name: DashboardPage.routeName,
        builder: (context, state) => const DashboardPage(),
      ),
      GoRoute(
        path: '/${SearchPage.routeName}',
        name: SearchPage.routeName,
        builder: (context, state) => const SearchPage(),
      ),
      GoRoute(
        path: '/${CartPage.routeName}',
        name: CartPage.routeName,
        builder: (context, state) => const CartPage(),
      ),
    ],
  );
});

// class GoRouterRefreshStream extends ChangeNotifier {
//   final Ref ref;
//
//   GoRouterRefreshStream(this.ref) {
//     ref.listen<AuthState>(authNotifierProvider, (_, __) => notifyListeners());
//   }
// }
