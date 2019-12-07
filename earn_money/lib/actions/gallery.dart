import 'dart:io';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class GalleryController extends StatefulWidget {
  @override
  _GalleryControllerState createState() => new _GalleryControllerState();
}

class _GalleryControllerState extends State<GalleryController> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  getGetImagesList() async {
    var result = await PhotoManager.requestPermission();
    if (result) {
      List<AssetPathEntity> list = await PhotoManager.getAssetPathList();
      List<AssetEntity> assetsList = await list[0].assetList;
      return getFilesList(assetsList);
    } else {
      PhotoManager.openSetting();
    }
  }

  getFilesList(assetsList) async {
    List<File> imagesList = [];
    for (AssetEntity imageProvider in assetsList) {
      File file = await imageProvider.file;
      imagesList.add(file);
    }
    return imagesList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getGetImagesList(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<File> imagesList = snapshot.data;
          return Container(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: imagesList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.all(2),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      FadeInImage(
                        image: FileImage(imagesList[index]),
                        placeholder: MemoryImage(kTransparentImage),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      Container(
                        color: Colors.black.withOpacity(0.7),
                        height: 30,
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            imagesList.elementAt(index).parent.path,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Regular'),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
