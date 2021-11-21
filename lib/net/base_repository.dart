import 'package:dio/dio.dart';
import 'package:flutter_bloc_basic/net/base_dio.dart';

class BaseRepository {
  late CancelToken _cancelToken;

  BaseRepository() {
    _cancelToken = CancelToken();
  }

  Future requestApi<T>(
    Method method,
    String apiPathUrl, {
    Object? body,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) {
    return BaseDio.instance.request<T>(method.value, apiPathUrl,
        body: body,
        queryParameters: queryParameters,
        cancelToken: _cancelToken,
        options: options);
  }

  /// 取消HTTP请求
  void disposeDio() {
    if (!_cancelToken.isCancelled) {
      _cancelToken.cancel();
    }
  }
}
