import 'package:flutter/material.dart';
import 'package:flutter_bloc_basic/flutter_bloc_basic.dart';

/// 不需要数据仓库注入的state
/// W => StatefulWidget
/// E => Bloc.Event Bloc事件
/// S => Bloc.State Bloc状态
/// R => Repository 数据仓库
/// RB => RepositoryBloc 含有数据仓库的Bloc
abstract class BaseState<W extends StatefulWidget, E, S, B extends Bloc<E, S>>
    extends State<W> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<B>(
      create: (context) => createBloc(),
      child: blocWidgetBuilder(context),
    );
  }

  B createBloc();

  Widget blocWidgetBuilder(BuildContext context);
}
