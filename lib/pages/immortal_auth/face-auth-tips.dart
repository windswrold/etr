import 'package:etrflying/component/positioned-text-component.dart';
import 'package:etrflying/component/router-back.dart';
import 'package:flutter/material.dart';

import 'face-auth.dart';
class FaceAuthTips extends StatefulWidget {
  @override
  _FaceAuthTipsState createState() => _FaceAuthTipsState();
}

class _FaceAuthTipsState extends State<FaceAuthTips> {
  final String path="assets/img/immortal_auth";
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Container(
      color: Color(0xffF8F8FC),
      height: 680,
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
              child: Image.asset(path+"/complete-icon.png"),
            ),
          ),
          PositionedTextComponent(left: 293,top: 158,fontSize: 12,color: Color(0xff999999),text: "认证完成",),

          //上传照片背景
          Positioned(
            left: 14,
            right: 14,
            top: 203,
            child: Container(
              width: double.infinity,
              height: 385,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Positioned(
            left: 77,
            right: 75,
            top:237,
            child: Container(
              width: 223,
              height: 224,
              child: Image.asset(path+"/face-Illustration-icon.png"),
            ),
          ),
          PositionedTextComponent(left: 148,top: 482,fontSize: 12,color: Color(0xff555555),text: "1.不要遮挡眼睛",),
          PositionedTextComponent(left: 158,top: 505,fontSize: 12,color: Color(0xff555555),text: "2.不要戴帽",),
          PositionedTextComponent(left: 146,top: 528,fontSize: 12,color: Color(0xff555555),text: "3.光线不要太暗",),
          PositionedTextComponent(
            fontSize: 16,
            color: Colors.white,
            left: 40,
            right: 40,
            width: double.infinity,
            height: 43,
            backgroundColor:  Color(0xff9C6CFF),
            top: 610,
            text: "开始面容识别",
            borderRadius: 22,
            textAlign: TextAlign.center,
            paddingTop: 8,
            event: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => FaceAuth()));
            },
          )
        ],
      ),
    ),);
  }
}
