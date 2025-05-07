class ApiUrls {
  ApiUrls._();

  static const String serverBaseUrl =
      'https://7447-182-48-230-72.ngrok-free.app/api/v1';
  static const String loginUrl = '$serverBaseUrl/employee/login/email';
  static const String signUpUrl = '$serverBaseUrl/employee/signup';
  static const String guestTokenUrl = '$serverBaseUrl/token/generate';
  static const String employeeDetailsUrl = '$serverBaseUrl/employee';
  static const String reportDetailsUrl = '$serverBaseUrl/report/detail';
  static const String reportListUrl = '$serverBaseUrl/report/list';
}
