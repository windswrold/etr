import 'package:etrflying/component/positioned-img.dart';
import 'package:etrflying/component/positioned-text-component.dart';
import 'package:etrflying/component/router-back.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:photo/photo.dart';
// import 'package:photo_manager/photo_manager.dart';
// import 'package:toast/toast.dart';

import 'mnemonic.dart';

class UploadHeadImg extends StatefulWidget {
  UploadHeadImgState createState() => UploadHeadImgState();
}

class UploadHeadImgState extends State<UploadHeadImg> {
  final path = "assets/img/fill_info";
  bool canNext = false;
  bool isAllow = false;
  String? img = null;
  void validateNext() {
    if (img != null && isAllow) {
      canNext = true;
      return;
    }
    canNext = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          BackComponet(),
          PositionedTextComponent(
            height: 36,
            left: 40,
            top: 106,
            fontSize: 25,
            color: Color(0xff333333),
            fontWeight: FontWeight.bold,
            text: "上传一些你的照片",
          ),
          PositionedTextComponent(
            height: 20,
            left: 40,
            top: 146,
            fontSize: 14,
            color: Color(0xff666666),
            text: "体验更好服务，否则部分功能将受限",
          ),
          PositionedImg(
            src: path + "/default-head-icon.png",
            width: 100,
            height: 100,
            left: 40,
            top: 208,
            isNetwork: false,
            event: () {
              // _pickAsset(PickType.onlyImage);
            },
          ),
          PositionedTextComponent(
            height: 20,
            left: 40,
            top: 382,
            fontSize: 14,
            color: Color(0xff333333),
            text: "上传清晰真人头像，配对绿增加80%",
          ),
          PositionedTextComponent(
            height: 20,
            left: 40,
            top: 506,
            fontSize: 14,
            color: Color(0xff999999),
            text: "清晰正面照片",
          ),
          PositionedTextComponent(
            height: 20,
            left: 168,
            right: 151,
            top: 506,
            fontSize: 14,
            color: Color(0xff999999),
            textAlign: TextAlign.center,
            text: "面部遮挡",
            width: double.infinity,
          ),
          PositionedTextComponent(
            height: 20,
            right: 30,
            top: 506,
            fontSize: 14,
            color: Color(0xff999999),
            text: "非真人照片",
          ),
          //用户协议
          Positioned(
            left: 54,
            top: 587,
            child: Listener(
              child: Container(
                width: 14,
                height: 14,
                child: isAllow
                    ? Image.asset(path + "/checked-icon.png")
                    : Image.asset(path + "/unchecked-icon.png"),
              ),
              onPointerDown: (e) => {
                setState(() {
                  isAllow = !isAllow;
                  validateNext();
                })
              },
            ),
          ),
          Positioned(
            left: 72,
            top: 585,
            child: Text("我已经仔细阅读并同意",
                style: TextStyle(
                    fontSize: 12,
                    decoration: TextDecoration.none,
                    fontFamily: "PingFangSC",
                    color: Color(0xff666666))),
          ),
          Positioned(
            left: 192,
            top: 585,
            child: Text("《服务及隐私条款》",
                style: TextStyle(
                    fontSize: 12,
                    decoration: TextDecoration.none,
                    fontFamily: "PingFangSC",
                    color: Color(0xff9C6CFF))),
          ),

          PositionedTextComponent(
            fontSize: 16,
            color: Colors.white,
            left: 40,
            right: 40,
            width: double.infinity,
            height: 43,
            backgroundColor: canNext
                ? Color(0xff9C6CFF)
                : Color(0xff9C6CFF).withOpacity(0.35),
            top: 612,
            text: "下一步",
            borderRadius: 22,
            textAlign: TextAlign.center,
            paddingTop: 8,
            event: () {
//              if(canNext){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => MnemonicSave()));
//              }else{
//                Toast.show(img==null?"请上传你的照片":"请确认并勾选《服务及隐私条款》", context,gravity: Toast.CENTER);
//              }
            },
          )
        ],
      ),
    );
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
}
