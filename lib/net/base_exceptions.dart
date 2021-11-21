import 'package:dio/dio.dart';

/// 自定义异常
class BaseException implements Exception {
  final String? message;
  final int? code;

  BaseException(this.code, this.message);

  @override
  String toString() {
    return 'BaseException{message: $message, code: $code}';
  }

  factory BaseException.create(DioError error) {
    switch (error.type) {
      case DioErrorType.cancel:
        {
          return TcpException(-1, "请求取消");
        }
      case DioErrorType.connectTimeout:
        {
          return TcpException(-1, "连接超时");
        }
      case DioErrorType.sendTimeout:
        {
          return TcpException(-1, "请求超时");
        }
      case DioErrorType.receiveTimeout:
        {
          return TcpException(-1, "响应超时");
        }
      case DioErrorType.response:
        {
          try {
            int? errCode = error.response?.statusCode;
            switch (errCode) {
              case 400:
                {
                  return TcpException(errCode, "错误的请求");
                }
              case 401:
                {
                  return ServerException(errCode, "没有权限");
                }
              case 403:
                {
                  return ServerException(errCode, "服务器拒绝执行");
                }
              case 404:
                {
                  return ServerException(errCode, "无法连接服务器");
                }
              case 405:
                {
                  return ServerException(errCode, "请求方法被禁止");
                }
              case 500:
                {
                  return ServerException(errCode, "服务器内部错误");
                }
              case 502:
                {
                  return ServerException(errCode, "无效的请求");
                }
              case 503:
                {
                  return ServerException(errCode, "服务器不可用");
                }
              case 505:
                {
                  return ServerException(errCode, "不支持HTTP协议请求");
                }
              default:
                {
                  return BaseException(errCode, error.response?.statusMessage);
                }
            }
          } on Exception catch (_) {
            return BaseException(-1, "未知错误");
          }
        }
      default:
        {
          return BaseException(-1, error.message);
        }
    }
  }
}

/// 连接异常
class TcpException extends BaseException {
  TcpException(int? code, String? message) : super(code, message);
}

/// 服务器异常
class ServerException extends BaseException {
  ServerException(int? code, String? message) : super(code, message);
}
