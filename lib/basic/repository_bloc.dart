import 'package:flutter_bloc_basic/flutter_bloc_basic.dart';

class RepositoryBloc<E, S, R extends BaseRepository> extends Bloc<E, S> {
  R? _repository;

  R? get repository => _repository;

  late CancelToken _cancelToken;

  RepositoryBloc(initialState) : super(initialState) {
    _cancelToken = CancelToken();
  }

  void injectRepository(R repository) {
    _repository = repository;
  }

  Future<Result> executeApiRequest<T>(RequestOptions options) async {
    try {
      options.copyWith(cancelToken: _cancelToken);
      final baseResponse = await BaseDio.instance.executeRequest(options);
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

  @override
  Future<void> close() {
    if (!_cancelToken.isCancelled) {
      _cancelToken.cancel();
    }
    return super.close();
  }
}
