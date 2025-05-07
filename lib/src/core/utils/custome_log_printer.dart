import 'dart:developer';

import 'package:flutter/foundation.dart';

class CustomLogPrinter {

  CustomLogPrinter._();

  static bool logOnly = kDebugMode;

  static void printDebugLog(dynamic val, [dynamic er, StackTrace? st]) {
    try {
      if (logOnly) {
        log(val, error: er, stackTrace: st);
      }
    } catch (e) {
      log('printDebugLog Exception ==>$e');
    }
  }

  static void printLog(dynamic val) {
    try {
      if (logOnly) {
        log(val);
      }
    } catch (e) {
      log('printDebugLog Exception ==>$e');
    }
  }
}
