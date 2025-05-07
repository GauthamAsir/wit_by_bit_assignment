import 'dart:convert';

import 'package:dio/dio.dart';

import '../../utils/custome_log_printer.dart';


class APIInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    CustomLogPrinter.printLog('*** Request ***');
    CustomLogPrinter.printLog('URI: ${options.uri}');
    CustomLogPrinter.printLog('Method: ${options.method}');
    CustomLogPrinter.printLog('Headers: ${options.headers}');
    CustomLogPrinter.printLog('Request: ${options.data.toString()}');
    handler.next(options); // continue
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    CustomLogPrinter.printLog('*** Response ***');
    CustomLogPrinter.printLog('Status Code: ${response.statusCode}');
    CustomLogPrinter.printLog('Headers: ${response.headers}');
    CustomLogPrinter.printLog('Response: ${jsonEncode(response.data)}');
    handler.next(response); // continue
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    CustomLogPrinter.printLog('*** Error ***');
    CustomLogPrinter.printLog('Error: ${err.error}');
    CustomLogPrinter.printLog('Response: ${err.response}');
    handler.next(err); // continue
  }
}
