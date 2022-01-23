class BaseResponse<T> {
  T? result;
  int? code;
  String? message;
  bool? success;
  int? timestamp;

  BaseResponse(
      {required this.result,
      required this.code,
      required this.message,
      required this.success,
      required this.timestamp});

  BaseResponse.fromJson(Map<String, dynamic> json, T convertData) {
    result = convertData;
    code = json['code'];
    message = json['message'];
    success = json['success'];
    timestamp = json['timestamp'];
  }
}
