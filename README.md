# QuartzDoc 石英文档

一个开源的Flutter文档处理库

## 注意

该项目尚未开发完毕, 请勿下载
## 上手指南

以下指南将帮助你在本地项目上引用该项目，进行开发和测试。

- 您的设备上需要配置好Flutter开发环境，详见[Flutter官网](https://flutter-io.cn/docs/get-started/install)。

- 请下载本项目，并将它解压。

- 将解压后的文件夹放入 您的项目文件夹/plugins

- 在pubspec.yaml中加入: 
```yaml
flutter_quartz:
    path: plugins/quartz_doc
```

- 执行 Packages Get

- 在您的AndroidManifest.xml中加入:
```xml
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
```

- 在您代码合适的地方加入外部存储的动态权限申请，这里推荐插件[permission_handler](https://pub.flutter-io.cn/packages/permission_handler)

- iOS 11.0以下的版本不支持文件选取功能，请在初始化QuartzPage中将supportFilePicker设置为false，就像这样
```dart
QuartzPage(
  supportFilePicker: false,
  ...
);
```

- 使用以下语句导入本库:
```dart
import 'package:quartz_doc/quartz_doc.dart';
```

- 使用QuartzDoc进行开发吧！

## 结尾

本篇README如有任何错误，请立刻指出，谢谢！