import 'package:amerika_foods/src/app.dart';
import 'package:amerika_foods/src/core/utils/custome_log_printer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

void main() async {
  try {

    WidgetsFlutterBinding.ensureInitialized();

    await ScreenUtil.ensureScreenSize();

    GoRouter.optionURLReflectsImperativeAPIs = true;
    // usePathUrlStrategy();

    runApp(const MyApp());
  } catch (e, s) {
    CustomLogPrinter.printDebugLog('Main', e, s);
  }
}

