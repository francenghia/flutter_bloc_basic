import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_basic/common/theme_bloc/theme_bloc.dart';
import 'package:flutter_bloc_basic/common/typedefs.dart';
import 'package:flutter_bloc_basic/flutter_bloc_basic.dart';
import 'package:flutter_bloc_basic/net/base_dio.dart';
import 'package:flutter_bloc_basic/net/base_response_converter.dart';
import 'package:flutter_bloc_basic/router/app_router.dart';
import 'package:flutter_bloc_basic/router/router_provider.dart';
import 'package:flutter_bloc_basic/router/routes.dart';
import 'package:flutter_bloc_basic/utils/screen/auto_size.dart';

class BaseApp extends StatefulWidget {
  /// 程序入口页
  final Widget home;

  /// 路由
  final List<RouterProvider> routerProviders;

  /// 全局BlocProvider
  final CreateGlobalBlocProviders createGlobalBlocProviders;

  /// 数据仓库
  final CreateRepositoryProviders createRepositoryProviders;

  final String baseUrl;

  final BaseResponseConverter baseResponseConverter;

  BaseApp({
    Key? key,
    required this.home,
    required this.routerProviders,
    required this.createGlobalBlocProviders,
    required this.createRepositoryProviders,
    required this.baseUrl,
    required this.baseResponseConverter,
  }) : super(key: key) {
    /// 初始化路由配置
    final router = FluroRouter();
    AppRouter.router = router;
    Routes.configureRoutes(router, routerProviders);

    /// 初始化HTTP客户端
    BaseDio.instance.configDio(
        baseUrl: baseUrl, baseResponseConverter: baseResponseConverter);
  }

  @override
  _BaseAppState createState() => _BaseAppState();
}

class _BaseAppState extends State<BaseApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: widget.createRepositoryProviders.call(),
      child: MultiBlocProvider(
        providers: widget.createGlobalBlocProviders.call(),
        child: BlocProvider(
          create: (_) => ThemeBloc(),
          child: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (BuildContext context, state) => MaterialApp(
              home: widget.home,
              theme: state.themeData,
              debugShowCheckedModeBanner: false,
              builder: AutoSize.appBuilder,
              onGenerateRoute: AppRouter.router.generator,
            ),
          ),
        ),
      ),
    );
  }
}
