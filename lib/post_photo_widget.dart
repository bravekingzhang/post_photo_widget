import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:post_photo_widget/asset_provider.dart';
import 'package:toast/toast.dart';
export 'package:multi_image_picker/multi_image_picker.dart';

class PostPhotoView extends StatefulWidget {
  final String addImgSrc;
  final double widthPadding;
  final int crossAxisCount; //每行展示几张
  final int imageCount; //最大选几张
  final ValueChanged imageChooseCallback;

  PostPhotoView(
      {@required this.addImgSrc,
      @required this.widthPadding,
      this.crossAxisCount = 3,
      this.imageCount = 9,
      this.imageChooseCallback})
      : assert(crossAxisCount > 0),
        assert(imageCount > 0),
        assert(imageChooseCallback != null);

  @override
  _PostPhotoViewState createState() => _PostPhotoViewState();
}

class _PostPhotoViewState extends State<PostPhotoView> {
  List<Asset> images = List<Asset>();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runAlignment: WrapAlignment.spaceEvenly,
      children: <Widget>[
        ...buildListItem(),
        images.length >= widget.imageCount
            ? SizedBox()
            : InkWell(
                onTap: loadAssets,
                child: Image.asset(
                  widget.addImgSrc,
                  width: (MediaQuery.of(context).size.width -
                          widget.widthPadding) /
                      widget.crossAxisCount,
                  height: (MediaQuery.of(context).size.width -
                          widget.widthPadding) /
                      widget.crossAxisCount,
                ),
              ),
      ],
    );
  }

  Future<void> loadAssets() async {
    await PermissionHandler().requestPermissions([
      PermissionGroup.storage,
      PermissionGroup.photos,
      PermissionGroup.camera
    ]);

    List<Asset> resultList = List<Asset>();
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);
    PermissionStatus permission2 =
        await PermissionHandler().checkPermissionStatus(PermissionGroup.photos);
    PermissionStatus permission3 =
        await PermissionHandler().checkPermissionStatus(PermissionGroup.camera);

    if (permission == PermissionStatus.granted &&
        permission2 == PermissionStatus.granted &&
        permission3 == PermissionStatus.granted) {
      try {
        resultList = await MultiImagePicker.pickImages(
          maxImages: widget.imageCount,
          enableCamera: true,
          selectedAssets: images,
          cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
          materialOptions: MaterialOptions(
            actionBarTitle: "选择照片",
            allViewTitle: "所有照片",
            useDetailsView: false,
            selectCircleStrokeColor: "#000000",
          ),
        );
        if (!mounted) return;
        setState(() {
          images = resultList;
        });
        this.widget.imageChooseCallback(images);
      } on Exception catch (e) {
        Toast.show(e.toString(), context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }
    } else {
      Toast.show('访问相册需要权限', context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      await Future.delayed(Duration(milliseconds: 1500));
      await PermissionHandler().openAppSettings();
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
  }

  List<Widget> buildListItem() {
//    List<CachedNetworkImage> list = [];
//    return list;
    return List.generate(images.length, (index) {
      Asset asset = images[index];
      return Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          Image(
            fit: BoxFit.cover,
            image: AssetImageProvider(
              asset,
              width:
                  (MediaQuery.of(context).size.width - widget.widthPadding) ~/
                      widget.crossAxisCount,
              height:
                  (MediaQuery.of(context).size.width - widget.widthPadding) ~/
                      widget.crossAxisCount,
            ),
            width: (MediaQuery.of(context).size.width - widget.widthPadding) /
                widget.crossAxisCount,
            height: (MediaQuery.of(context).size.width - widget.widthPadding) /
                widget.crossAxisCount,
          ),
          InkWell(
            onTap: () {
              setState(() {
                images.remove(asset);
              });
            },
            child: CircleAvatar(
              radius: 11,
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 10,
              ),
              backgroundColor: Colors.black.withOpacity(0.5),
            ),
          )
        ],
      );
    });
  }
}
