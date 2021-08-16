import 'package:etrflying/component/positioned-text-component.dart';
import 'package:etrflying/component/router-back.dart';
import 'package:etrflying/pages/fill_info/upload-head-img.dart';
import 'package:etrflying/pages/immortal_auth/face-auth-tips.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import 'package:photo/photo.dart';
// import 'package:photo_manager/photo_manager.dart';
// import 'package:toast/toast.dart';
class UploadImg extends StatefulWidget {
  @override
  _UploadImgState createState() => _UploadImgState();
}

class _UploadImgState extends State<UploadImg> {
  final String path = "assets/img/immortal_auth";
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffF8F8FC),
      child: Stack(
        children: <Widget>[
          //头部背景
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              color: Colors.white,
              width: double.infinity,
              height: 88,
            ),
          ),
          BackComponet(),
          PositionedTextComponent(
            left: 0,
            right: 0,
            top: 54,
            textAlign: TextAlign.center,
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Color(0xff333333),
            text: "真人认证",
          ),
          //流程背景
          Positioned(
            left: 14,
            right: 14,
            top: 100,
            child: Container(
              width: double.infinity,
              height: 91,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 3),
                        blurRadius: 6,
                        color: Color.fromRGBO(138, 138, 138, 0.10)),
                  ]),
            ),
          ),
          Positioned(
            left: 43,
            top: 116,
            child: Container(
              width: 30,
              height: 30,
              child: Image.asset(path + "/upload-flow-icon.png"),
            ),
          ),
          PositionedTextComponent(
            left: 34,
            top: 158,
            fontSize: 12,
            color: Color(0xff9662FF),
            text: "上传照片",
          ),

          Positioned(
            left: 173,
            top: 116,
            child: Container(
              width: 30,
              height: 30,
              child: Image.asset(path + "/face-discern-icon.png"),
            ),
          ),
          PositionedTextComponent(
            left: 165,
            top: 158,
            fontSize: 12,
            color: Color(0xff999999),
            text: "面容识别",
          ),

          Positioned(
            left: 302,
            top: 116,
            child: Container(
              width: 30,
              height: 30,
              child: Image.asset(path + "/complete-icon.png"),
            ),
          ),
          PositionedTextComponent(
            left: 293,
            top: 158,
            fontSize: 12,
            color: Color(0xff999999),
            text: "认证完成",
          ),

          //上传照片背景
          Positioned(
            left: 14,
            right: 14,
            top: 203,
            child: Container(
              width: double.infinity,
              height: 328,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          PositionedTextComponent(
            left: 0,
            right: 0,
            top: 231,
            textAlign: TextAlign.center,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xff333333),
            text: "上传你的照片",
          ),
          Positioned(
            left: 148,
            right: 147,
            top: 282,
            child: GestureDetector(
              child: Container(
                width: 80,
                height: 81,
                child: Image.asset(path + "/upload-button-icon.png"),
              ),
              onTap: () {
                debugPrint(11111.toString());
                // _pickAsset(PickType.onlyImage);
              },
            ),
          ),
          PositionedTextComponent(
            left: 100,
            top: 387,
            fontSize: 12,
            color: Color(0xff555555),
            text: "1.请上传一张形象良好的正面照片",
          ),
          PositionedTextComponent(
            left: 104,
            top: 410,
            fontSize: 12,
            color: Color(0xff555555),
            text: "2.保证照片像素清晰，五官可见",
          ),
          PositionedTextComponent(
            left: 80,
            top: 433,
            fontSize: 12,
            color: Color(0xff555555),
            text: "3.通过认证后，此照片将上传到你的相册",
          ),
          PositionedTextComponent(
            fontSize: 16,
            color: Colors.white,
            left: 40,
            right: 40,
            width: double.infinity,
            height: 43,
            backgroundColor: Color(0xff9C6CFF),
            bottom: 69,
            text: "下一步",
            borderRadius: 22,
            textAlign: TextAlign.center,
            paddingTop: 8,
            event: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => FaceAuthTips()));
            },
          )
        ],
      ),
    );
  }
}


  // @override
  // Widget buildBigImageLoading(
  //     BuildContext context, AssetEntity entity, Color themeColor) {
  //   return Center(
  //     child: Container(
  //       width: 50.0,
  //       height: 50.0,
  //       child: CupertinoActivityIndicator(
  //         radius: 25.0,
  //       ),
  //     ),
  //   );
  // }

  // @override
  // Widget buildPreviewLoading(
  //     BuildContext context, AssetEntity entity, Color themeColor) {
  //   return Center(
  //     child: Container(
  //       width: 50.0,
  //       height: 50.0,
  //       child: CupertinoActivityIndicator(
  //         radius: 25.0,
  //       ),
  //     ),
  //   );
  // }

  // void _pickAsset(PickType type, {List<AssetPathEntity> pathList}) async {
  //   /// context is required, other params is optional.
  //   /// context is required, other params is optional.
  //   /// context is required, other params is optional.

  //   List<AssetEntity> imgList = await PhotoPicker.pickAsset(
  //     // BuildContext required
  //     context: context,

  //     /// The following are optional parameters.
  //     themeColor: Colors.green,
  //     // the title color and bottom color

  //     textColor: Colors.white,
  //     // text color
  //     padding: 1.0,
  //     // item padding
  //     dividerColor: Colors.grey,
  //     // divider color
  //     disableColor: Colors.grey.shade300,
  //     // the check box disable color
  //     itemRadio: 0.88,
  //     // the content item radio
  //     maxSelected: 1,
  //     // max picker image count
  //     // provider: I18nProvider.english,
  //     provider: I18nProvider.chinese,
  //     // i18n provider ,default is chinese. , you can custom I18nProvider or use ENProvider()
  //     rowCount: 3,
  //     // item row count

  //     thumbSize: 150,
  //     // preview thumb size , default is 64
  //     sortDelegate: SortDelegate.common,
  //     // default is common ,or you make custom delegate to sort your gallery
  //     checkBoxBuilderDelegate: DefaultCheckBoxBuilderDelegate(
  //       activeColor: Colors.white,
  //       unselectedColor: Colors.white,
  //       checkColor: Colors.green,
  //     ),
  //     // default is DefaultCheckBoxBuilderDelegate ,or you make custom delegate to create checkbox

  //     loadingDelegate: this,
  //     // if you want to build custom loading widget,extends LoadingDelegate, [see example/lib/main.dart]

  //     badgeDelegate: const DurationBadgeDelegate(),
  //     // badgeDelegate to show badge widget

  //     pickType: type,

  //     photoPathList: pathList,
  //   );

  //   if (imgList == null || imgList.isEmpty) {
  //     Toast.show("请选择图片", context, gravity: Toast.CENTER);
  //     return;
  //   }
  //   setState(() {});
  // }
// }
