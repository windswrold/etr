import 'dart:math';

import 'package:etrflying/component/positioned-text-component.dart';
import 'package:etrflying/component/router-back.dart';
import 'package:etrflying/pages/fill_info/validate_account.dart';
import 'package:flutter/material.dart';
// import 'package:toast/toast.dart';

class ValidateMnemonic extends StatefulWidget {
  final List<String>? word;

  const ValidateMnemonic({Key? key, this.word}) : super(key: key);

  @override
  _ValidateMnemonicState createState() => _ValidateMnemonicState();
}

class _ValidateMnemonicState extends State<ValidateMnemonic> {
  final path = "assets/img/fill_info";
  TextEditingController controller = new TextEditingController();
  int? index = null;
  String tips = "";
  List? showWord = null;
  bool canNext = false;

  String getTips(int? value) {
    switch (value) {
      case 1:
        return "请选择第一个单词";
      case 2:
        return "请选择第二个单词";
      case 3:
        return "请选择第三个单词";
      case 4:
        return "请选择第四个单词";
      case 5:
        return "请选择第五个单词";
      case 6:
        return "请选择第六个单词";
      case 7:
        return "请选择第七个单词";
      case 8:
        return "请选择第八个单词";
      case 9:
        return "请选择第九个单词";
      case 10:
        return "请选择第十个单词";
      case 11:
        return "请选择第十一个单词";
      case 12:
        return "请选择第十二个单词";
    }
    return "";
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      index = Random().nextInt(12);
      showWord = widget.word;
      showWord!.shuffle(Random());
      tips = getTips(index);
    });
    controller.addListener(() {
      if (!canNext) {
        if (controller.text == widget.word![index!]) {
          // Toast.show("验证成功!", context, gravity: Toast.CENTER);
          setState(() {
            canNext = true;
          });
        } else {
          // Toast.show("验证失败，请重试!", context, gravity: Toast.CENTER);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 812,
          child: Stack(
            children: <Widget>[
              BackComponet(),
              PositionedTextComponent(
                left: 40,
                top: 106,
                fontSize: 25,
                color: Color(0xff333333),
                fontWeight: FontWeight.bold,
                text: "验证助记词",
              ),
              PositionedTextComponent(
                left: 41,
                top: 146,
                fontSize: 14,
                color: Color(0xff666666),
                text: "确保您已备份好您的助记词，请验证如下问题：",
              ),
              PositionedTextComponent(
                left: 41,
                top: 219,
                fontSize: 16,
                color: Color(0xff9C6CFF),
                text: tips,
              ),
              Positioned(
                left: 40,
                right: 40,
                top: 268,
                child: TextField(
                  enabled: false,
                  controller: controller,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff333333)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff333333)),
                    ),
                  ),
                  style: TextStyle(
                      fontFamily: "PingFangSC",
                      fontSize: 14,
                      color: Color(0xff333333)),
                ),
              ),
              Positioned(
                left: 40,
                right: 40,
                top: 350,
                child: Container(
                    width: double.infinity,
                    child: GridView.builder(
                        itemCount: 12,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            //横轴元素个数
                            crossAxisCount: 3,
                            //纵轴间距
                            mainAxisSpacing: 6.0,
                            //横轴间距
                            crossAxisSpacing: 6.0,
                            //子组件宽高长度比例
                            childAspectRatio: 2.186),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            child: Container(
                              width: 94,
                              height: 43,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border: new Border.all(
                                      color: Color(0xffd9d9d9), width: 1)),
                              child: Stack(
                                children: <Widget>[
                                  PositionedTextComponent(
                                    left: 5,
                                    top: 3,
                                    fontSize: 10,
                                    color: Color(0xff999999),
                                    text: (index < 9 ? "0" : "") +
                                        (index + 1).toString(),
                                  ),
                                  PositionedTextComponent(
                                    left: 0,
                                    right: 0,
                                    top: 12,
                                    width: double.infinity,
                                    textAlign: TextAlign.center,
                                    fontSize: 16,
                                    color: Color(0xff333333),
                                    text: showWord![index],
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              controller.text = showWord![index];
                            },
                          );
                        })),
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
                top: 630,
                text: "确认",
                borderRadius: 22,
                textAlign: TextAlign.center,
                paddingTop: 8,
                event: () {
//              if(canNext){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => ValidateAccount()));
//              }else{
//                Toast.show(img==null?"请上传你的照片":"请确认并勾选《服务及隐私条款》", context,gravity: Toast.CENTER);
//              }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
