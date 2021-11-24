import 'package:dio/dio.dart';
import 'package:flutter_bloc_basic/flutter_bloc_basic.dart';
import 'package:flutter_bloc_basic/net/base_dio.dart';
import 'package:flutter_bloc_basic/net/result.dart';

class BaseRepository {
  late CancelToken _cancelToken;

  BaseRepository() {
    _cancelToken = CancelToken();
  }

  Future<Result> requestApi<T>(
    Method method,
    String apiPathUrl, {
    Object? body,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    try {
      final baseResponse = await BaseDio.instance.request<T>(
          method.value, apiPathUrl,
          body: body,
          queryParameters: queryParameters,
          cancelToken: _cancelToken,
          options: options);
      if (baseResponse != null) {
        if (baseResponse.code != 200) {
          return Error.create(
              BusinessException(baseResponse.code, baseResponse.message));
        } else {
          return Success<T>.create(baseResponse.result);
        }
      } else {
        return Error.create(OtherException(-1, "没有返回数据"));
      }
    } on DioError catch (e) {
      return Error.create(BaseException.create(e));
    } on Exception catch (e) {
      return Error.create(OtherException(-1, e.toString()));
    }
  }

  /// 取消HTTP请求
  void disposeDio() {
    if (!_cancelToken.isCancelled) {
      _cancelToken.cancel();
    }
  }
}
