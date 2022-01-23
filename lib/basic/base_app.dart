import 'package:flutter/material.dart';
import 'package:flutter_bloc_basic/flutter_bloc_basic.dart';
import 'package:flutter_bloc_basic/router/app_router.dart';
import 'package:flutter_bloc_basic/router/routes.dart';

class BaseApp extends StatefulWidget {
  /// 程序入口页
  final Widget home;

  /// 路由
  final List<RouterProvider> routerProviders;

  /// 全局BlocProvider
  final CreateGlobalBlocProviders createGlobalBlocProviders;

  /// 数据仓库
  final CreateRepositoryProviders createRepositoryProviders;

  /// http url
  final String baseUrl;

  /// response转换器
  final BaseResponseConverter baseResponseConverter;

  /// 设计稿中设备的尺寸(单位随意,建议dp,但在使用过程中必须保持一致)
  final Size designSize;

  /// 支持分屏尺寸
  final bool splitScreenMode;

  /// 是否根据宽度和高度的最小值来适应文本
  final bool minTextAdapt;

  /// 默认主题
  ThemeState defaultThemeState =
      ThemeState(themeData: ThemeData.light(), themeModel: "light");

  BaseApp({
    Key? key,
    required this.home,
    required this.routerProviders,
    required this.createGlobalBlocProviders,
    required this.createRepositoryProviders,
    required this.baseUrl,
    required this.baseResponseConverter,
    required this.defaultThemeState,
    this.designSize = ScreenUtil.defaultSize,
    this.splitScreenMode = true,
    this.minTextAdapt = false,
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
    return ScreenUtilInit(
      designSize: widget.designSize,
      splitScreenMode: widget.splitScreenMode,
      minTextAdapt: widget.minTextAdapt,
      builder: () => MultiRepositoryProvider(
        providers: widget.createRepositoryProviders.call(),
        child: MultiBlocProvider(
          providers: widget.createGlobalBlocProviders.call(),
          child: BlocProvider(
            create: (_) => ThemeBloc(defaultTheme: widget.defaultThemeState),
            child: BlocBuilder<ThemeBloc, ThemeState>(
              builder: (BuildContext context, state) {
                return MaterialApp(
                  home: widget.home,
                  theme: state.themeData,
                  debugShowCheckedModeBanner: false,
                  onGenerateRoute: AppRouter.router.generator,
                  builder: (context, widget) {
                    ScreenUtil.setContext(context);
                    return MediaQuery(
                      //Setting font does not change with system font size
                      data:
                          MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                      child: widget!,
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
