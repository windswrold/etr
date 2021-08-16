import 'package:etrflying/component/positioned-text-component.dart';
import 'package:etrflying/component/router-back.dart';
import 'package:flutter/material.dart';
class FaceAuthComplete extends StatefulWidget {
  @override
  _FaceAuthCompleteState createState() => _FaceAuthCompleteState();
}

class _FaceAuthCompleteState extends State<FaceAuthComplete> {
  final String path="assets/img/immortal_auth";
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
          PositionedTextComponent(left: 0,right: 0,top: 54,textAlign: TextAlign.center,fontSize: 17,fontWeight: FontWeight.bold,color: Color(0xff333333),text: "真人认证",),
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
                        color: Color.fromRGBO(138,138,138, 0.10)),
                  ]
              ),
            ),
          ),
          Positioned(
            left: 43,
            top:116,
            child: Container(
              width: 30,
              height: 30,
              child: Image.asset(path+"/upload-flow-icon.png"),
            ),
          ),
          PositionedTextComponent(left: 34,top: 158,fontSize: 12,color: Color(0xff9662FF),text: "上传照片",),

          Positioned(
            left: 173,
            top:116,
            child: Container(
              width: 30,
              height: 30,
              child: Image.asset(path+"/face-discerning-icon.png"),
            ),
          ),
          PositionedTextComponent(left: 165,top: 158,fontSize: 12,color: Color(0xff9662FF),text: "面容识别",),

          Positioned(
            left: 302,
            top:116,
            child: Container(
              width: 30,
              height: 30,
              child: Image.asset(path+"/completed-icon.png"),
            ),
          ),
          PositionedTextComponent(left: 293,top: 158,fontSize: 12,color: Color(0xff9662FF),text: "认证完成",),

          //上传照片背景
          Positioned(
            left: 14,
            right: 14,
            top: 203,
            child: Container(
              width: double.infinity,
              height: 217,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Positioned(
            left: 158,
            right: 157,
            top:239,
            child: Container(
              width: 60,
              height: 60,
              child: Image.asset(path+"/completed-button-icon.png"),
            ),
          ),
          PositionedTextComponent(left: 0,right: 0,top: 321,textAlign: TextAlign.center,fontSize: 18,color: Color(0xff333333),text: "认证完成",),
        ],
      ),
    );
  }
}
