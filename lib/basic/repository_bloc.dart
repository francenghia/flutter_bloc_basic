import 'package:flutter_bloc_basic/flutter_bloc_basic.dart';

class RepositoryBloc<E, S, R extends BaseRepository> extends Bloc<E, S> {
  R? repository;

  RepositoryBloc(initialState) : super(initialState);

  void injectRepository(R? repository) {
    this.repository = repository;
  }

  @override
  Future<void> close() {
    repository?.disposeDio();
    return super.close();
  }
}
