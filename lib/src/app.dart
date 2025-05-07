import 'package:amerika_foods/src/utils/custom_router.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/theme/themes.dart';
import 'core/utils/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return OrientationBuilder(
            builder: (BuildContext context, Orientation orientation) {
              return ScreenUtilInit(
                // designSize: const Size(375, 812),
                designSize: Size(
                  constraints.maxWidth > 0 ? constraints.maxWidth : 1360,
                  constraints.maxHeight > 0 ? constraints.maxHeight : 768,
                ),
                minTextAdapt: true,
                splitScreenMode: true,
                builder: (BuildContext context, Widget? child) {
                  return const MedicoApp();
                },
              );
            },
          );
        },
      ),
    );
  }
}

class MedicoApp extends ConsumerStatefulWidget {
  const MedicoApp({super.key});

  @override
  ConsumerState<MedicoApp> createState() => _MedicoAppState();
}

class _MedicoAppState extends ConsumerState<MedicoApp> {

  @override
  void initState() {
    super.initState();
    AppRouter.init(ref);
  }

  @override
  Widget build(BuildContext context) {

    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      title: 'Medico',
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: AppRouter.scaffoldMessengerKey,
      builder: BotToastInit(),
      locale: const Locale('en', ''),
      theme: ref.watch(lightTheme),
      darkTheme: ref.watch(darkTheme),
      themeMode: ref.watch(themeMode).themeMode,
    );
  }
}
