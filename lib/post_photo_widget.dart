import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:post_photo_widget/asset_provider.dart';

class PostPhotoView extends StatefulWidget {
  final String addImgSrc;
  final double widthPadding;
  final int crossAxisCount;//每行展示几张
  final int imageCount;//最大选几张

  PostPhotoView(
      {@required this.addImgSrc, @required this.widthPadding, this.crossAxisCount = 3,this.imageCount = 9})
      : assert(crossAxisCount > 0),assert(imageCount > 0);

  @override
  _PostPhotoViewState createState() => _PostPhotoViewState();
}

class _PostPhotoViewState extends State<PostPhotoView> {
  List<Asset> images = List<Asset>();
  String _error = 'No Error Dectected';

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
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';
    Map<PermissionGroup, PermissionStatus> _ = await PermissionHandler()
        .requestPermissions([PermissionGroup.camera,PermissionGroup.mediaLibrary,PermissionGroup.photos]);
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.photos);
    if (permission == PermissionStatus.granted) {
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
      } on Exception catch (e) {
        error = e.toString();
      }
    } else {

    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    setState(() {
      images = resultList;
      _error = error;
    });
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
