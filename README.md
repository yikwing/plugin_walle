# flutter 动态注入

### 利用美团walle 通过打包插入动态代码.

### 使用本插件前应看一下[walle]( https://github.com/Meituan-Dianping/walle) 开发文档



## 项目内使用

- 获取渠道信息

```dart
Future<void> getChannel() async {
    String channel;
    try {
      channel = await PluginWalle.getWalleChannel();
    } on PlatformException {
      channel = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _channel = channel;
    });
}
```

- 获取额外信息

```dart
Future<void> getChannelInfo() async {
    Map<String, dynamic> channelInfo;
    try {
      channelInfo =
          Map<String, dynamic>.from(await PluginWalle.getWalleChannelInfo());
    } on PlatformException {
      channelInfo = {};
    }

    if (!mounted) return;

    setState(() {
      _channelInfo = channelInfo;
    });
}
```



## 使用Walle-cil 插入



### 获取信息

显示当前apk中的渠道和额外信息：

```shell
java -jar walle-cli-all.jar show app.apk
```



### 写入信息

写入渠道

```shell
java -jar walle-cli-all.jar put -c meituan app.apk
```

写入额外信息，不提供渠道时不写入渠道

```shell
java -jar walle-cli-all.jar put -c meituan -e buildtime=20161212,hash=xxxxxxx app.apk
```

指定输出文件，自定义名称。 不指定时默认与原apk包同目录。

```shell
java -jar walle-cli-all.jar put -c meituan app.apk app-new.apk
```



更多用法参考 https://github.com/Meituan-Dianping/walle/blob/master/walle-cli/README.md


