import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_basic/router/app_router.dart';
import 'package:flutter_bloc_basic/router/router_provider.dart';
import 'package:flutter_bloc_basic/router/routes.dart';

/// @Author:         wangxing

class BaseApp extends StatefulWidget {
  final Widget home;

  /// 路由
  final List<RouterProvider> routerProviders;

  /// 数据仓库
  final List<RepositoryProvider> repositoryProviders;

  /// 全局BlocProvider
  final List<BlocProvider> globalBlocProviders;

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
      providers: widget.repositoryProviders,
      child: MultiBlocProvider(
        providers: widget.globalBlocProviders,
        child: MaterialApp(
          home: widget.home,
          onGenerateRoute: AppRouter.router.generator,
        ),
      ),
    );
  }
}
