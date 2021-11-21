import 'package:dio/dio.dart';
import 'package:flutter_bloc_basic/common/typedefs.dart';
import 'package:flutter_bloc_basic/net/base_exceptions.dart';
import 'package:flutter_bloc_basic/net/error_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

enum Method { GET, POST, PUT, PATCH, DELETE, HEAD }

extension MethodExtension on Method {
  String get value => ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'HEAD'][index];
}

class BaseDio {
  static BaseDio get instance => BaseDio();

  factory BaseDio() {
    return _singleton;
  }

  static final BaseDio _singleton = BaseDio._internal();

  static late final Dio _dio;

  /// 暴露给应用层 response 成功转换器
  static late final ConverterResponseFromJsonOnSuccess
      converterResponseFromJsonOnSuccess;

  /// 暴露给应用层 response 失败转换器
  static late final ConverterResponseFromJsonOnFailed
      converterResponseFromJsonOnFailed;

  BaseDio._internal() {
    _dio = Dio();
    _dio.options = BaseOptions(
      receiveTimeout: 15 * 1000,
      connectTimeout: 15 * 1000,
      sendTimeout: 15 * 1000,
    );

    /// HTTP Log 拦截器
    _dio.interceptors.add(PrettyDioLogger(
      // 添加日志格式化工具类
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      compact: false,
    ));

    /// 错误处理拦截器
    _dio.interceptors.add(ErrorInterceptor());
  }

  configDio({
    required ConverterResponseFromJsonOnSuccess responseSuccessConvert,
    required ConverterResponseFromJsonOnFailed responseFailedConvert,
    required String baseUrl,
  }) {
    converterResponseFromJsonOnSuccess = responseSuccessConvert;
    converterResponseFromJsonOnFailed = responseFailedConvert;
    _dio.options.baseUrl = baseUrl;
  }

  /// 数据返回格式统一，统一处理异常
  Future request<T>(
    String method,
    String url, {
    Object? body,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    final _result = await _dio.request<Map<String, dynamic>>(
      url,
      data: body,
      queryParameters: queryParameters,
      options: _checkOptions(method, options),
      cancelToken: cancelToken,
    );
    try {
      final value = _result.data == null
          ? null
          : converterResponseFromJsonOnSuccess(_result.data!);
      return value;
    } on DioError catch (e) {
      return converterResponseFromJsonOnFailed.call(BaseException.create(e));
    }
  }

  Options _checkOptions(String method, Options? options) {
    options ??= Options();
    options.method = method;
    return options;
  }
}
