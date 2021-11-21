import 'package:dio/dio.dart';
import 'package:flutter_bloc_basic/net/base_exceptions.dart';

/// 错误处理拦截器
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    err.error = BaseException.create(err);
    handler.next(err);
  }
}
