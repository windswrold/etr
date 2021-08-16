import 'dart:io';

import 'package:etrflying/component/positioned-text-component.dart';
import 'package:flutter/material.dart';

class ReleaseDynamic extends StatefulWidget {
  ReleaseDynamicState createState() => ReleaseDynamicState();
}

class ReleaseDynamicState extends State<ReleaseDynamic> {
  final path = "assets/img/release";
  final controller = TextEditingController();
  final focusNode = FocusNode();
  int count = 500;
  var photos = [];

  //最大内容长度限制
  // ignore: top_level_function_literal_block
  final Container Function(BuildContext, {int currentLength, bool isFocused, int? maxLength}) counterBuilder = (
    BuildContext context, {
    int? currentLength,
    int? maxLength,
    bool? isFocused,
  }) {
    return Container();
  };


  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        count = 500 - controller.text.length;
      });
    });
  }

  Widget getAddButton(bool isPhoto, File? file) {
    return Container(
      width: 112,
      height: 112,
      child: GestureDetector(
        child: isPhoto
            ? Image.file(
                file!,
                fit: BoxFit.cover,
              )
            : Image.asset(
                path + "/add-button-icon.png",
                fit: BoxFit.cover,
              ),
        onTap: () {
        },
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            //上面背景
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: Container(
                width: double.infinity,
                height: 88,
                color: Color(0xffF8F8FC),
              ),
            ),
            PositionedTextComponent(
              left: 14,
              top: 55,
              fontSize: 16,
              color: Color(0xff666666),
              text: "取消",
            ),
            PositionedTextComponent(
              left: 0,
              right: 0,
              top: 54,
              fontSize: 17,
              color: Color(0xff333333),
              text: "发布动态",
              textAlign: TextAlign.center,
              fontWeight: FontWeight.bold,
            ),
            Positioned(
              right: 14,
              top: 52,
              child: Container(
                width: 56,
                height: 28,
                child: Image.asset(path + "/release-icon.png"),
              ),
            ),
            Positioned(
              top: 88,
              left: 14,
              right: 14,
              child: Container(
                width: double.infinity,
                child: new TextField(
                  autofocus: true,
                  style: TextStyle(fontSize: 16, color: Color(0xff333333)),
                  maxLines: 3,
                  maxLength: 500,
                  controller: controller,
                  focusNode: focusNode,
                  buildCounter: counterBuilder,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.only(left: 14, right: 14, top: 12)),
                ),
              ),
            ),
            Positioned(
              top: 196,
              left: 0,
              right: 0,
              child: GridView.builder(
                  padding: EdgeInsets.only(left: 14, right: 14),
                  itemCount: photos.length == 0
                      ? 1
                      : photos.length < 6 ? photos.length + 1 : photos.length,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //横轴元素个数
                      crossAxisCount: 3,
                      //纵轴间距
                      mainAxisSpacing: 5.0,
                      //横轴间距
                      crossAxisSpacing: 5.0,
                      //子组件宽高长度比例
                      childAspectRatio: 1.0),
                  itemBuilder: (BuildContext context, int index) {
                    if (photos.length == 0 ||
                        (photos.length < 6 && index == photos.length)) {
                      return getAddButton(false, null);
                    }
                    return getAddButton(true, photos[index]);
                  }),
            ),
            //键盘顶上的背景
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                width: double.infinity,
                height: 58,
                color: Colors.white,
              ),
            ),
            Positioned(
              left: 22,
              bottom: 16,
              child: Container(
                width: 56,
                height: 28,
                child: GestureDetector(child:Image.asset(path + "/add-img-icon.png") ,onTap: (){
                },),
              ),
            ),
            PositionedTextComponent(
              right: 12,
              bottom: 15,
              fontSize: 14,
              text: count.toString(),
              color: Color(0xff999999),
            ),
          ],
        ),
      ),
    );
  }
}
