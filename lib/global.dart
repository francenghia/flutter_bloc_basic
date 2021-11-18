import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_autosize_screen/auto_size_util.dart';
import 'package:flutter_bloc_basic/utils/local_storage_util.dart';

class Global {
  //初始化全局信息
  static Future init(VoidCallback callback, [double designWidth = 360]) async {
    WidgetsFlutterBinding.ensureInitialized();
    await LocalStorageUtil.instance();
    AutoSizeUtil.setStandard(designWidth, isAutoTextSize: true);
    callback();
    if (Platform.isAndroid) {
      // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
      SystemUiOverlayStyle systemUiOverlayStyle =
          const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }
}
