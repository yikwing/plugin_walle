import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PluginWalle {
  static const MethodChannel _channel =
      const MethodChannel('plugins.yikwing.com/flutter_walle_plugin');

  static Future<Map> getWalleChannelInfo() async {
    if (!Platform.isAndroid) {
      return null;
    }

    return await _channel.invokeMethod('getWalleChannelInfo');
  }

  static Future<String> getWalleChannel() async {
    if (!Platform.isAndroid) {
      return null;
    }

    return await _channel.invokeMethod('getWalleChannel');
  }
}
