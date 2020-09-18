import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:plugin_walle/plugin_walle.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _channel = 'Unknown';
  Map<String, dynamic> _channelInfo = {};

  @override
  void initState() {
    super.initState();

    getChannel();
    getChannelInfo();
  }

  Future<void> getChannel() async {
    String channel;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      channel = await PluginWalle.getWalleChannel();
    } on PlatformException {
      channel = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _channel = channel;
    });
  }

  Future<void> getChannelInfo() async {
    Map<String, dynamic> channelInfo;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      channelInfo =
          Map<String, dynamic>.from(await PluginWalle.getWalleChannelInfo());
    } on PlatformException {
      channelInfo = {};
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _channelInfo = channelInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('Running on: $_channel\n'),
              Text('Running on: ${_channelInfo.toString()}\n'),
            ],
          ),
        ),
      ),
    );
  }
}
