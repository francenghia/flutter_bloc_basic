import 'package:flutter/material.dart';
import 'package:flutter_bloc_basic/flutter_bloc_basic.dart';

/// 需要注入数据仓库的state
/// W => StatefulWidget
/// E => Bloc.Event Bloc事件
/// S => Bloc.State Bloc状态
/// R => Repository 数据仓库
/// RB => RepositoryBloc 含有数据仓库的Bloc
abstract class BaseRepositoryState<
    W extends StatefulWidget,
    E,
    S,
    R extends BaseRepository,
    RB extends RepositoryBloc<E, S, R>> extends BaseState<W, E, S, RB> {
  @override
  RB createBloc() {
    return createRepositoryBloc()
      ..injectRepository(RepositoryProvider.of<R>(context));
  }

  RB createRepositoryBloc();
}
