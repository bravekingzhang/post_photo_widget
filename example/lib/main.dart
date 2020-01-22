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
