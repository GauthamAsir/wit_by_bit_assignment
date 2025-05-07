import 'package:amerika_foods/src/core/data/sources/request_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/custome_log_printer.dart';
import 'api_intercepter.dart';
import '../models/api_response_model.dart';

final apiHandlerProvider = Provider((_) => ApiHandler());

class ApiHandler {
  var dio = Dio();
  ApiResponseModel apiResponseModel = ApiResponseModel();
  final helper = RequestHelper();

  Future<ApiResponseModel> getRequest(
    String url, {
    Map<String, dynamic>? headers,
  }) async {
    final ApiResponseModel apiResponseModel = ApiResponseModel();

    if (!dio.interceptors.any((i) => i.runtimeType == APIInterceptor)) {
      dio.interceptors.add(APIInterceptor());
    }

    try {
      final response = await dio.request(
        url,
        options: Options(
          method: 'GET',
          headers: headers ?? helper.generateHeaders(),
        ),
      );

      final data = response.data;

      if (data is! Map) {
        apiResponseModel.data = data;
        apiResponseModel.isSuccess = false;
        apiResponseModel.status = "F";
        apiResponseModel.errors = [
          Errors(message: 'Invalid response', extensions: {}, code: '00'),
        ];
        return apiResponseModel;
      }

      apiResponseModel.data = data["body"];
      apiResponseModel.isSuccess = data["isSuccess"];
      apiResponseModel.metaData = data["meta"];
      apiResponseModel.errors =
          (data.containsKey('errors') && (data['errors'] != null))
              ? List.generate(
                data.length,
                (index) => Errors.fromJson(data['errors'][index]),
              )
              : [];

      return apiResponseModel;
    } on DioException catch (e) {
      CustomLogPrinter.printDebugLog("ApiHandlerError", e);
      apiResponseModel.data = e.response?.data;
      apiResponseModel.isSuccess = false;
      apiResponseModel.errors = [
        Errors(
          message: e.response?.data['error'] ?? "",
          extensions: {},
          code: '00',
        ),
      ];
      apiResponseModel.status = "F";
      return apiResponseModel;
    }
  }

  Future<ApiResponseModel> postRequest(
    String url,
    Map<String, dynamic> req, {
    Map<String, dynamic>? headers,
  }) async {
    final ApiResponseModel apiResponseModel = ApiResponseModel();

    if (!dio.interceptors.any((i) => i.runtimeType == APIInterceptor)) {
      dio.interceptors.add(APIInterceptor());
    }

    try {
      final response = await dio.request(
        url,
        options: Options(
          method: 'POST',
          headers: headers ?? helper.generateHeaders(),
        ),
        data: req,
      );

      final data = response.data;

      if (data is! Map) {
        apiResponseModel.data = data;
        apiResponseModel.isSuccess = false;
        apiResponseModel.status = "F";
        apiResponseModel.errors = [
          Errors(message: 'Invalid response', extensions: {}, code: '00'),
        ];
        return apiResponseModel;
      }

      apiResponseModel.data = data["body"];
      apiResponseModel.isSuccess = data["isSuccess"];
      apiResponseModel.metaData = data["meta"];
      apiResponseModel.errors =
          (data.containsKey('errors') && (data['errors'] != null))
              ? List.generate(
                data.length,
                (index) => Errors.fromJson(data['errors'][index]),
              )
              : [];

      return apiResponseModel;
    } on DioException catch (e) {
      return parseDioException(e);
    } catch (e, stackTrace) {
      return parseException(e, stackTrace);
    }
  }

  Future<ApiResponseModel> patchRequest(
      String url,
      Map<String, dynamic> req, {
        Map<String, dynamic>? headers,
      }) async {
    final ApiResponseModel apiResponseModel = ApiResponseModel();

    if (!dio.interceptors.any((i) => i.runtimeType == APIInterceptor)) {
      dio.interceptors.add(APIInterceptor());
    }

    try {
      final response = await dio.request(
        url,
        options: Options(
          method: 'PATCH',
          headers: headers ?? helper.generateHeaders(),
        ),
        data: req,
      );

      final data = response.data;

      if (data is! Map<String, dynamic>) {
        apiResponseModel
          ..data = data
          ..isSuccess = false
          ..status = "F"
          ..errors = [
            Errors(message: 'Invalid response', extensions: {}, code: '00'),
          ];
        return apiResponseModel;
      }

      apiResponseModel
        ..data = data["body"]
        ..isSuccess = data["isSuccess"]
        ..metaData = data["meta"]
        ..errors = (data['errors'] is List)
            ? (data['errors'] as List)
            .map((e) => Errors.fromJson(e))
            .toList()
            : [];

      return apiResponseModel;
    } on DioException catch (e) {
      return parseDioException(e);
    } catch (e, stackTrace) {
      return parseException(e, stackTrace);
    }
  }

  Future<ApiResponseModel> deleteRequest(
    String url,
    Map<String, dynamic> req, {
    Map<String, dynamic>? headers,
  }) async {
    final ApiResponseModel apiResponseModel = ApiResponseModel();

    if (!dio.interceptors.any((i) => i.runtimeType == APIInterceptor)) {
      dio.interceptors.add(APIInterceptor());
    }

    try {
      final response = await dio.request(
        url,
        options: Options(
          method: 'DELETE',
          headers: headers ?? helper.generateHeaders(),
        ),
        data: req,
      );

      final data = response.data;

      if (data is! Map) {
        apiResponseModel.data = data;
        apiResponseModel.isSuccess = false;
        apiResponseModel.status = "F";
        apiResponseModel.errors = [
          Errors(message: 'Invalid response', extensions: {}, code: '00'),
        ];
        return apiResponseModel;
      }

      apiResponseModel.data = data["body"];
      apiResponseModel.isSuccess = data["isSuccess"];
      apiResponseModel.metaData = data["meta"];
      apiResponseModel.errors =
          (data.containsKey('errors') && (data['errors'] != null))
              ? List.generate(
                data.length,
                (index) => Errors.fromJson(data['errors'][index]),
              )
              : [];

      return apiResponseModel;
    } on DioException catch (e) {
      return parseDioException(e);
    } catch (e, stackTrace) {
      return parseException(e, stackTrace);
    }
  }

  Future<ApiResponseModel> postMultipartRequest(
    String url, {
    FormData? bodyFormData,
    Map<String, dynamic>? headers,
    List<Map<String, dynamic>>? files,
  }) async {
    final ApiResponseModel apiResponseModel = ApiResponseModel();

    if (!dio.interceptors.any((i) => i.runtimeType == APIInterceptor)) {
      dio.interceptors.add(APIInterceptor());
    }

    try {

      final response = await dio.request(
        url,
        options: Options(
          method: 'POST',
          headers: headers ?? RequestHelper().generateHeaders(),
        ),
        data: bodyFormData,
      );

      final data = response.data;

      if (data is! Map<String, dynamic>) {
        apiResponseModel
          ..data = data
          ..isSuccess = false
          ..status = "F"
          ..errors = [
            Errors(
              message: 'Invalid response format',
              extensions: {},
              code: '00',
            ),
          ];
        return apiResponseModel;
      }

      apiResponseModel
        ..data = data["body"]
        ..isSuccess = data["isSuccess"] ?? false
        ..metaData = data["meta"]
        ..errors = (data['errors'] is List)
            ? (data['errors'] as List)
            .map((e) => Errors.fromJson(e))
            .toList()
            : [];

      return apiResponseModel;
    } on DioException catch (e) {
      return Future.error(parseDioException(e));
    } catch (e, stackTrace) {
      return Future.error(parseException(e, stackTrace));
    }
  }

  ApiResponseModel parseDioException(DioException e) {
    CustomLogPrinter.printDebugLog("ApiHandlerError", e.error, e.stackTrace);

    final errorData = e.response?.data;
    apiResponseModel.data = errorData;
    apiResponseModel.isSuccess = false;

    final errorsList = errorData?['errors'];
    if (errorsList is List && errorsList.isNotEmpty) {
      apiResponseModel.errors =
          errorsList.map((e) => Errors.fromJson(e)).toList();
    } else {
      apiResponseModel.errors = [
        Errors(
          message: (e.error ?? "Unknown error").toString(),
          extensions: {},
          code: '00',
        ),
      ];
    }

    apiResponseModel.status = "F";
    return apiResponseModel;
  }

  ApiResponseModel parseException(e, stackTrace) {
    CustomLogPrinter.printDebugLog("ApiHandler UnexpectedError", e, stackTrace);

    return ApiResponseModel(
      isSuccess: false,
      status: "F",
      errors: [Errors(message: e.toString(), extensions: {}, code: '99')],
    );
  }
}
