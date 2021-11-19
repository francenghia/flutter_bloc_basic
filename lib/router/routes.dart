import 'package:fluro/fluro.dart';
import 'package:flutter_bloc_basic/router/not_found_page.dart';
import 'package:flutter_bloc_basic/router/router_provider.dart';

/// 全局命名路由配置类
class Routes {
  static String webViewPage = '/webViewPage';

  static final List<RouterProvider> _listRouter = [];

  static void configureRoutes(
      FluroRouter router, List<RouterProvider> routerProviders) {
    router.notFoundHandler =
        Handler(handlerFunc: (context, parameters) => const WidgetNotFound());

    // 统一管理路由
    _listRouter.addAll(routerProviders);

    // 初始化路由
    for (var routerProvider in _listRouter) {
      routerProvider.initRouter(router);
    }
  }
}
