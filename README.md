# post_photo_widget

A new Flutter plugin that can send photos similar to WeChat moments 发送微信朋友圈九宫格照片

## Getting Started

![](https://github.com/bravekingzhang/post_photo_widget/blob/master/device-2020-01-22-172925.png)
![](https://github.com/bravekingzhang/post_photo_widget/blob/master/2020-01-23.png)

```dart
import 'package:flutter/material.dart';
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
          imageChooseCallback: (images){
            //上传图片参考 https://sh1d0w.github.io/multi_image_picker/#/upload
            List<Asset> imageList = images;
          },
        ),
      ),
    );
  }
}

```

### android
无需配置任何权限，直接可以奔跑，因为在插件工程中申请了权限。

### ios

>Specs satisfying the `multi_image_picker (from `.symlinks/plugins/multi_image_picker/ios`)` dependency were found, but they required a higher minimum deployment target.
 

表示需要把deployment target 升高，默认是8.0，亲测升级到12.1ok。

另外，ios工程中需要加上权限，插件工程没申请入口，交给使用者补充。

```
<key>NSCameraUsageDescription</key>
<string>Allows you to take a picture</string>
<key>NSMicrophoneUsageDescription</key>
<string>Allows you to record a voice</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>Allows you to choose a picture</string>
```