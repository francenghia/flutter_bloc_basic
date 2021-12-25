import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc_basic/utils/local_storage_util.dart';

class Global {
  /// 初始化全局信息
  static Future init(VoidCallback callback,
      {SystemUiOverlayStyle? androidStatusBarStyle,
      VoidCallback? needInitialize}) async {
    WidgetsFlutterBinding.ensureInitialized();
    await LocalStorageUtil.instance();
    needInitialize?.call();
    callback();
    if (Platform.isAndroid) {
      androidStatusBarStyle ??= const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark);
      SystemChrome.setSystemUIOverlayStyle(androidStatusBarStyle);
    }
  }
}
