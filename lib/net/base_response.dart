class BaseResponse<T> {
  T? result;
  int? code;
  String? message;

  BaseResponse({this.result, this.code, this.message});

  BaseResponse.fromJson(Map<String, dynamic> json, T convertData) {
    result = convertData;
    code = json['code'];
    message = json['message'];
  }
}
