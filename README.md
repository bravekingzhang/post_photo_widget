# post_photo_widget

A new Flutter plugin that can send photos similar to WeChat moments 发送微信朋友圈九宫格照片

## Getting Started

![](https://github.com/bravekingzhang/post_photo_widget/blob/master/device-2020-01-22-172925.png)

```dart
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:post_photo_widget/post_photo_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('类微信朋友圈发送器'),
        ),
        body: PostPhotoView(
          addImgSrc: 'images/zhaopian_add_2x.png',
          widthPadding: 30,
        ),
      ),
    );
  }
}
```