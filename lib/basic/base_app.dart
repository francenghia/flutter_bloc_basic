import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_basic/common/theme_bloc/theme_bloc.dart';
import 'package:flutter_bloc_basic/net/base_repository.dart';
import 'package:flutter_bloc_basic/router/app_router.dart';
import 'package:flutter_bloc_basic/router/router_provider.dart';
import 'package:flutter_bloc_basic/router/routes.dart';

/// @Author:         wangxing

class BaseApp extends StatefulWidget {
  final Widget home;

  /// 路由
  final List<RouterProvider> routerProviders;

  /// 数据仓库
  final List<BaseRepository> repositoryProviders;

  /// 全局BlocProvider
  final List<Bloc> globalBlocProviders;

  const BaseApp(
      {Key? key,
      required this.home,
      required this.routerProviders,
      required this.repositoryProviders,
      required this.globalBlocProviders})
      : super(key: key);

  @override
  _BaseAppState createState() => _BaseAppState();
}

class _BaseAppState extends State<BaseApp> {
  _BaseAppState() {
    /// 初始化路由配置
    final router = FluroRouter();
    AppRouter.router = router;
    Routes.configureRoutes(router, widget.routerProviders);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: _mapRepositoryProviders(),
      child: MultiBlocProvider(
        providers: _mapGlobalBlocProviders(),
        child: BlocBuilder<ThemeBloc, ThemeState>(
          bloc: ThemeBloc(),
          buildWhen: (previous, current) =>
              // 只有主题模式不一样是才builder
              previous.themeModel != current.themeModel,
          builder: (context, state) {
            return MaterialApp(
              home: widget.home,
              theme: state.themeData,
              onGenerateRoute: AppRouter.router.generator,
            );
          },
        ),
      ),
    );
  }

  _mapRepositoryProviders() => widget.repositoryProviders
      .map((e) => RepositoryProvider(create: (BuildContext context) => e));

  _mapGlobalBlocProviders() => widget.globalBlocProviders
      .map((e) => BlocProvider(create: (BuildContext context) => e));
}
