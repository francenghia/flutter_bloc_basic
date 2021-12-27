
import 'package:flutter/material.dart';
import 'package:flutter_bloc_basic/utils/local_storage_util.dart';

class Global {
  /// 初始化全局信息
  static Future init(VoidCallback callback,
      {VoidCallback? needInitialize}) async {
    WidgetsFlutterBinding.ensureInitialized();
    await LocalStorageUtil.instance();
    needInitialize?.call();
    callback();
  }
}
