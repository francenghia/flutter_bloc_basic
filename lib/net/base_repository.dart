import 'package:flutter_bloc_basic/flutter_bloc_basic.dart';

class BaseRepository {
  /// 根据不同接口创建request
  RequestOptions createApiRequest(
    Method method,
    String apiPathUrl, {
    Object? body,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) =>
      BaseDio.instance.createRequestOptions(method, apiPathUrl,
          body: body,
          queryParameters: queryParameters,
          cancelToken: cancelToken,
          options: options);
}
