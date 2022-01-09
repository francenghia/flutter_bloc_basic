import 'package:flutter/material.dart';
import 'package:flutter_bloc_basic/flutter_bloc_basic.dart';
import 'package:flutter_bloc_basic/router/app_router.dart';

/// 路由导航工具类
class NavigatorUtil {
  static void push(BuildContext context, String path,
      {bool replace = false, bool clearStack = false}) {
    FocusScope.of(context).unfocus();
    AppRouter.router.navigateTo(context, path,
        replace: replace,
        clearStack: clearStack,
        transition: TransitionType.native);
  }

  static void pushResult(
      BuildContext context, String path, Function(Object) function,
      {bool replace = false, bool clearStack = false}) {
    FocusScope.of(context).unfocus();
    AppRouter.router
        .navigateTo(context, path,
            replace: replace,
            clearStack: clearStack,
            transition: TransitionType.native)
        .then((value) {
      if (value == null) {
        return;
      }
      function(value);
    }).catchError((onError) {});
  }

  static void pushArgumentResult(BuildContext context, String path,
      Object argument, Function(Object) function,
      {bool replace = false, bool clearStack = false}) {
    AppRouter.router
        .navigateTo(context, path,
            routeSettings: RouteSettings(arguments: argument),
            replace: replace,
            clearStack: clearStack)
        .then((value) {
      if (value == null) {
        return;
      }
      function(value);
    }).catchError((onError) {});
  }

  static void pushArgument(BuildContext context, String path, Object argument,
      {bool replace = false, bool clearStack = false}) {
    AppRouter.router.navigateTo(context, path,
        routeSettings: RouteSettings(arguments: argument),
        replace: replace,
        clearStack: clearStack);
  }

  static void goBack(BuildContext context) {
    FocusScope.of(context).unfocus();
    Navigator.pop(context);
  }

  static void goBackWithParams(BuildContext context, result) {
    FocusScope.of(context).unfocus();
    Navigator.pop(context, result);
  }

  static String changeToNavigatorPath(String registerPath,
      {required Map params}) {
    if (params.isEmpty) {
      return registerPath;
    }
    StringBuffer bufferStr = StringBuffer();
    params.forEach((key, value) {
      bufferStr
        ..write(key)
        ..write("=")
        ..write(Uri.encodeComponent(value))
        ..write("&");
    });
    String paramStr = bufferStr.toString();
    paramStr = paramStr.substring(0, paramStr.length - 1);
    return "$registerPath?$paramStr";
  }
}
