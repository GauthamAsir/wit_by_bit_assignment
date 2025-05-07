class ApiResponseModel {
  String? status;
  dynamic data;
  List<Errors>? errors;
  dynamic metaData;
  int? statusCode;
  bool? isSuccess;

  ApiResponseModel({
    this.status,
    this.data,
    this.errors,
    this.metaData,
    this.statusCode,
    this.isSuccess,
  });

  factory ApiResponseModel.fromJson(Map<String, dynamic> json) =>
      ApiResponseModel(
        status: json["status"],
        data: json["body"],
        statusCode: json["statusCode"],
        isSuccess: json["isSuccess"],
        errors:
            (json['errors'] != null)
                ? List.generate(
                  json['errors'].length,
                  (index) => Errors.fromJson(json['errors'][index]),
                )
                : null,
        metaData: json['metaData'],
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data,
    "statusCode": statusCode,
    "isSuccess": isSuccess,
    'errors': errors?.map((error) => error.toJson()).toList(),
  };
}

class Errors {
  String message;
  String code;
  Map<String, dynamic> extensions;

  Errors({required this.message, required this.extensions, required this.code});

  factory Errors.fromJson(Map<String, dynamic> json) {
    return Errors(
      message: json['message'].toString(),
      extensions: json['extensions'] ?? {},
      code: (json['extensions']?['code'] ?? '00'),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['extensions'] = extensions;
    data['code'] = code;
    return data;
  }
}
