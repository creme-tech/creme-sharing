import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:creme_sharing/creme_sharing.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _cremeSharingPlugin = CremeSharing();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      _cremeSharingPlugin.shareToInstagramStories(
        backgroundImage:
            'https://images.ctfassets.net/4kdyp3e5mlne/2n7azZ2QJjY5f937HtdZQL/10d6e5de71721348185ac4df0973e1d4/Marie.jpg',
        backgroundTopColor: Colors.red,
        backgroundBottomColor: Colors.orange,
        stickerImage:
            'https://images.ctfassets.net/4kdyp3e5mlne/1XGsZB6hhvceAFM241dqGW/1fad3eab1a652a5276b5e0f55afea5e8/ThaiBasilGuacamoleImage.png',
      );
      platformVersion = 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
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
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
