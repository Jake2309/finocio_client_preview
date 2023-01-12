class Result<T> {
  bool success;
  T? data;
  int? code;
  String? message;

  Result({this.success = false, this.data, this.code = 0, this.message = ''});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result<T>(
        success: json['success'], code: json['code'], message: json['message']);
  }
}
