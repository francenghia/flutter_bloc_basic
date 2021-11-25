# Flutter Bloc Basic 说明

基于 Bloc 框架封装的快速开发架构

##### 工程结构

```
|-- flutter_bloc_basic
    |-- flutter_bloc_basic.dart           # library 定义
    |-- global.dart                       # 全局初始化类  三方库初始化调用处
    |-- basic                             # 基类目录
    |   |-- base_app.dart                 # MaterialApp基类
    |   |-- base_repository_state.dart    # 自动注入Repository的StatefulWidget->State基类
    |   |-- base_state.dart               # 不需要Repository的StatefulWidget->State基类
    |   |-- repository_bloc.dart          # 需要使用Repository的Bloc需使用此基类
    |-- common                            # 通用包
    |   |-- typedefs.dart                 # typedef方法定义
    |   |-- theme_bloc                    # 主题切换Bloc
    |       |-- theme_bloc.dart
    |       |-- theme_event.dart
    |       |-- theme_state.dart
    |-- net                               # Http相关
    |   |-- base_dio.dart                 # Dio默认实例
    |   |-- base_exceptions.dart          # 自定义异常类,异常处理
    |   |-- base_repository.dart          # Repository基类,管理Http请求,dispose生命周期内自动取消
    |   |-- base_response.dart            # Response基类
    |   |-- base_response_converter.dart  # Response基类 数据转换器
    |   |-- net.dart                      # net Export类
    |   |-- result.dart                   # 返回给调用层数据结构
    |-- router
    |   |-- app_router.dart               # 路由管理实例
    |   |-- not_found_page.dart           # 路由NotFound返回页
    |   |-- router_provider.dart          # 定义路由回调抽象类
    |   |-- routes.dart                   # 配置路由
    |-- utils
        |-- local_storage_util.dart       # SharedPreferences工具类
        |-- log_util.dart                 # 打印日志工具类
        |-- navigator_util.dart           # 导航工具类
        |-- screen                        #屏幕自动适配工具类
            |-- auto_size.dart
            |-- auto_size_screen_util.dart
            |-- binding.dart
```

