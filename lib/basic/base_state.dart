import 'package:flutter/material.dart';
import 'package:flutter_bloc_basic/flutter_bloc_basic.dart';

/// 不需要数据仓库注入的state
/// W => StatefulWidget
/// E => Bloc.Event Bloc事件
/// S => Bloc.State Bloc状态
/// B => Bloc
abstract class BaseState<W extends StatefulWidget, E, S, B extends Bloc<E, S>>
    extends State<W> with AutomaticKeepAliveClientMixin<W> {
  /// 控制顶层BlocConsumer reBuild 默认不随States变化重新构建
  late bool _reBuild = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider<B>(
      create: (context) => createBloc(),
      child: BlocConsumer<B, S>(
        buildWhen: (previous, current) => _reBuild,
        builder: blocWidgetBuilder,
        listener: onStateChangeListener,
      ),
    );
  }

  @override
  bool get wantKeepAlive => false;

  /// 创建Bloc
  B createBloc();

  /// States变化监听
  void onStateChangeListener(BuildContext context, S state);

  /// 构建组件
  Widget blocWidgetBuilder(BuildContext context, S state);

  /// 设置顶层BlocConsumer reBuild
  void pageReBuildWhitStatesChanged(bool reBuild) {
    _reBuild = reBuild;
  }
}
