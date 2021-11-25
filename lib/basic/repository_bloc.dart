import 'package:flutter_bloc_basic/flutter_bloc_basic.dart';

class RepositoryBloc<E, S, R extends BaseRepository> extends Bloc<E, S> {
  R? repository;

  late CancelToken _cancelToken;

  RepositoryBloc(initialState) : super(initialState) {
    _cancelToken = CancelToken();
  }

  void injectRepository(R? repository) {
    this.repository = repository;
  }

  @override
  Future<void> close() {
    if (!_cancelToken.isCancelled) {
      _cancelToken.cancel();
    }
    return super.close();
  }
}
