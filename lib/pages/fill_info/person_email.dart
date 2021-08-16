import 'package:etrflying/component/positioned-text-component.dart';
import 'package:etrflying/component/router-back.dart';
import 'package:etrflying/pages/fill_info/upload-head-img.dart';
import 'package:flutter/material.dart';
// import 'package:toast/toast.dart';

class PersonEmail extends StatefulWidget {
  PersonEmailState createState() => PersonEmailState();
}

class PersonEmailState extends State<PersonEmail> {
  final path = "assets/img/fill_info";
  bool showClear = false;
  bool showWarn = true;
  bool isAllow = false;
  bool canNext = false;
  TextEditingController controller = new TextEditingController();

  // 邮箱判断
  static bool isEmail(String? input) {
    String regexEmail =
        "^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}\$";
    if (input == null || input.isEmpty) return false;
    return new RegExp(regexEmail).hasMatch(input);
  }

  String? validate(value) {
    if (value.length < 0) {
      return "      请输入邮箱";
    }
    if (!isEmail(value)) {
      return "      请输入正确的邮箱格式";
    }
    return null;
  }

  void validateNext() {
    if (!showWarn && isAllow) {
      canNext = true;
      return;
    }
    canNext = false;
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        String text = controller.text;
        isEmail(text) ? showWarn = false : showWarn = true;
        validateNext();
        if (text.length > 0) {
          showClear = true;
          return;
        }
        showClear = false;
        return;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          BackComponet(),
          Positioned(
            right: 14,
            top: 59,
            child: Container(
              width: 52,
              height: 24,
              child: Image.asset(path + "/skip-icon.png"),
            ),
          ),
          PositionedTextComponent(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color(0xff333333),
            left: 40,
            top: 106,
            text: "请输入电子邮箱",
          ),
          PositionedTextComponent(
            fontSize: 14,
            color: Color(0xff666666),
            left: 40,
            top: 146,
            text: "平台的消息及时通知你",
          ),
          Positioned(
            left: 40,
            right: 40,
            top: 222,
            child: TextFormField(
              controller: controller,
              validator: validate,
              autovalidate: true,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff333333)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff333333)),
                ),
                suffixIcon: Container(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                            width: 16,
                            height: 17,
                            child: Listener(
                              child: showClear
                                  ? Image.asset(path + "/clear-icon.png",
                                      fit: BoxFit.cover)
                                  : null,
                              onPointerDown: (e) => {controller.clear()},
                            ))
                      ],
                    )),
                hintStyle: TextStyle(
                    fontSize: 14,
                    color: Color(0xffC0C0C0),
                    fontFamily: "PingFangSC"),
                hintText: "密码长度为8～32个字符，支持大小写字符/特殊符号",
              ),
              style: TextStyle(
                  fontFamily: "PingFangSC",
                  fontSize: 14,
                  color: Color(0xff333333)),
            ),
          ),
          Positioned(
            left: 40,
            top: 282,
            child: Container(
              width: 12,
              height: 12,
              child:
                  showWarn ? Image.asset(path + "/little-warn-icon.png") : null,
            ),
          ),
          //用户协议
          Positioned(
            left: 54,
            top: 361,
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
            top: 358,
            child: Text("我已经仔细阅读并同意",
                style: TextStyle(
                    fontSize: 12,
                    decoration: TextDecoration.none,
                    fontFamily: "PingFangSC",
                    color: Color(0xff666666))),
          ),
          Positioned(
            left: 192,
            top: 358,
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
            top: 385,
            text: "下一步",
            borderRadius: 22,
            textAlign: TextAlign.center,
            paddingTop: 8,
            event: () {
              if (canNext) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => UploadHeadImg()));
              } else {
                // throw ;
                // Toast.show(showWarn?"请填写正确的邮箱":"请确认并勾选《服务及隐私条款》", context,gravity: Toast.CENTER);
              }
            },
          ),
        ],
      ),
    );
  }
}
