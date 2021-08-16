import 'dart:async';

import 'package:etrflying/component/positioned-text-component.dart';
import 'package:etrflying/component/router-back.dart';
import 'package:flutter/material.dart';

import 'face-auth-complete.dart';
class FaceAuth extends StatefulWidget {
  @override
  _FaceAuthState createState() => _FaceAuthState();
}

class _FaceAuthState extends State<FaceAuth> {
  final String path="assets/img/immortal_auth";
  int seconds=10;


  @override
  void initState() {
    super.initState();
    const timeout = const Duration(seconds: 1);
    Timer.periodic(timeout, (timer) { //callback function
      setState(() {
        seconds--;
        if(seconds==0){
          timer.cancel();
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => FaceAuthComplete()));
        }
      });
      // 取消定时器
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          BackComponet(),
          PositionedTextComponent(left: 0,right: 0,top: 54,textAlign: TextAlign.center,fontSize: 17,fontWeight: FontWeight.bold,color: Color(0xff333333),text: "面容识别",),
          PositionedTextComponent(left: 0,right: 0,top: 138,textAlign: TextAlign.center,fontSize: 20,fontWeight: FontWeight.w500,color: Color(0xff333333),text: "请保持正脸在取景框内",),
          Positioned(
            left: 74,
            right: 72,
            top:218,
            child: Container(
              width: 229,
              height: 229,
              child: Image.asset(path+"/stance-icon.png"),
            ),
          ),
          PositionedTextComponent(left: 150,right: 147,height:42,paddingTop:12,top: 556,textAlign: TextAlign.center,fontSize: 16,color: Color(0xff999999),text: seconds.toString()+"s",backgroundColor: Colors.white,
          borderRadius: 21,shadow: BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 9,
                color: Color.fromRGBO(150,98,255,0.23)),),
        ],
      ),
    );
  }
}
