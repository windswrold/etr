import 'package:bip39/bip39.dart' as bip39;
import 'package:etrflying/component/custom_pageview.dart';
import 'package:etrflying/component/custom_textfield.dart';
import 'package:etrflying/component/router-back.dart';
import 'package:etrflying/model/mnemonic/mnemonic.dart';
import 'package:etrflying/model/tr_wallet.dart';
import 'package:etrflying/pages/guide/carousel.dart';
import 'package:flutter/material.dart';

import '../../public.dart';

class InputAccount extends StatefulWidget {
  InputAccountState createState() => InputAccountState();
}

class InputAccountState extends State<InputAccount> {
  final nickController = TextEditingController();
  final passwordController = TextEditingController();

  //显示清除昵称按钮
  bool showNickClear = false;

  //显示密码清除按钮
  bool showPasswordClear = false;

  //显示密码按钮
  bool showPassword = false;

  //是否同意协议
  bool isAllow = false;

  //是否可以下一步
  bool canNext = false;

  //是否显示昵称validate
  bool showNickWarn = true;

  //是否显示密码validate
  bool showPasswordWarn = true;

  String? validateNick(value) {
    if (value.length < 1) {
      return '请输入昵称';
    }
    if (value.length > 12) {
      return '昵称长度过长';
    }
    return null;
  }

  String? validatePassword(value) {
    if (value.length < 8) {
      return '密码不能少于8个字符';
    }
    if (value.length > 32) {
      return '密码不能大于32个字符';
    }
    return null;
  }

  void validateInfo() {
    int nickLength = nickController.text.trim().length;
    int passwordLength = passwordController.text.trim().length;
    if ((nickLength > 0 && nickLength < 13) &&
        (passwordLength > 7 && passwordLength < 33) &&
        isAllow) {
      setState(() {
        canNext = true;
      });
      return;
    }
    setState(() {
      canNext = false;
    });
  }

  void next() {
    if (canNext == false) {
      return;
    }
    final nick = nickController.text;
    final pwd = passwordController.text;
    final content = Mnemonic.generateMnemonic();
    TRWallet.importWallet(context,
        content: content,
        pin: pwd,
        walletName: nick,
        kCoinType: KCoinType.All,
        kLeadType: KLeadType.Memo);

    // Routers.push(context, Carousel());
  }

  @override
  void initState() {
    super.initState();
    nickController.addListener(() {
      setState(() {
        if (nickController.text.length > 0) {
          showNickClear = true;
          showNickWarn = false;
        } else {
          showNickClear = false;
          showNickWarn = true;
        }
      });
      validateInfo();
    });
    passwordController.addListener(() {
      setState(() {
        String password = passwordController.text;
        if (password.length > 0) {
          showPasswordClear = true;
        } else {
          showPasswordClear = false;
        }
        if (password.length < 8 || password.length > 32) {
          showPasswordWarn = true;
        } else {
          showPasswordWarn = false;
        }
        validateInfo();
      });
    });
  }

  @override
  void dispose() {
    nickController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPageView(
      // hiddenResizeToAvoidBottomInset: true,
      hiddenScrollView: true,
      child: Container(
        padding: EdgeInsets.only(left: 40.w, right: 40.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //标题
                  Padding(
                    padding: EdgeInsets.only(bottom: 18.w),
                    child: Text("创建身份",
                        style: TextStyle(
                            color: Color(0xff333333),
                            fontSize: 25.sp,
                            fontWeight: FontWeightHelper.semiBold)),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LoadAssetsImage(
                        "identity/warn-icon.png",
                        width: 16,
                        height: 16,
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 4),
                          // width: double.infinity,
                          child: Text(
                            "密码用于保护私钥和交易授权，强度非常重要，平台不储存密码，也无法帮你找回，请务必牢记。",
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: Color(0xffFF4D4F),
                                fontWeight: FontWeightHelper.regular),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //昵称提示
                  Padding(
                    padding: EdgeInsets.only(top: 50.h),
                    child: Text(
                      "昵称",
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: Color(0xff666666),
                          fontWeight: FontWeightHelper.regular),
                    ),
                  ),

                  CustomTextField(
                    controller: nickController,
                    style: TextStyle(
                      color: ColorUtil.rgba(153, 153, 153, 1),
                      fontSize: 14.sp,
                      fontWeight: FontWeightHelper.regular,
                    ),
                    decoration: CustomTextField.getUnderLineDecoration(
                      hintStyle: TextStyle(
                          fontSize: 12.sp,
                          color: Color(0xffC0C0C0),
                          fontWeight: FontWeightHelper.regular),
                      hintText: "1-12位字符，可包含中文、英文字符",
                      helperText: validateNick(nickController.text),
                      helperStyle: TextStyle(
                          fontSize: 11.sp,
                          color: ColorUtil.rgba(255, 77, 79, 1),
                          fontWeight: FontWeightHelper.regular),
                      suffixIconConstraints: BoxConstraints(maxWidth: 20),
                      suffixIcon: Container(
                        width: 16,
                        height: 17,
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => nickController.clear(),
                          child: showNickClear
                              ? LoadAssetsImage(
                                  "identity/clear-icon.png",
                                  width: 16,
                                  height: 17,
                                )
                              : null,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 40.w,
                    ),
                    child: Text(
                      "密码",
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: Color(0xff666666),
                          fontWeight: FontWeightHelper.regular),
                    ),
                  ),

                  CustomTextField(
                    controller: passwordController,
                    obscureText: !showPassword,
                    style: TextStyle(
                      color: ColorUtil.rgba(153, 153, 153, 1),
                      fontSize: 14.sp,
                      fontWeight: FontWeightHelper.regular,
                    ),
                    decoration: CustomTextField.getUnderLineDecoration(
                      hintStyle: TextStyle(
                          fontSize: 12.sp,
                          color: Color(0xffC0C0C0),
                          fontWeight: FontWeightHelper.regular),
                      hintText: "密码长度为8～32个字符，支持大小写字符/特殊符号",
                      helperText: validatePassword(passwordController.text),
                      helperStyle: TextStyle(
                          fontSize: 11.sp,
                          color: ColorUtil.rgba(255, 77, 79, 1),
                          fontWeight: FontWeightHelper.regular),
                      suffixIconConstraints: BoxConstraints(maxWidth: 50),
                      suffixIcon: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                              width: 16,
                              height: 17,
                              margin: EdgeInsets.only(right: 12),
                              child: Listener(
                                child: showPassword
                                    ? LoadAssetsImage(
                                        "identity/show-icon.png",
                                        fit: BoxFit.cover,
                                      )
                                    : LoadAssetsImage(
                                        "identity/noshow-icon.png",
                                        fit: BoxFit.cover),
                                onPointerDown: (e) => {
                                  setState(() {
                                    showPassword = !showPassword;
                                  })
                                },
                              )),
                          Container(
                              width: 16,
                              height: 17,
                              child: Listener(
                                child: showPasswordClear
                                    ? LoadAssetsImage("identity/clear-icon.png",
                                        fit: BoxFit.cover)
                                    : null,
                                onPointerDown: (e) =>
                                    {passwordController.clear()},
                              ))
                        ],
                      ),
                    ),
                  ),
                ]),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 0.h, bottom: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isAllow = !isAllow;
                              validateInfo();
                            });
                          },
                          child: isAllow
                              ? LoadAssetsImage(
                                  "identity/checked-icon.png",
                                  width: 14,
                                  height: 14,
                                )
                              : LoadAssetsImage(
                                  "identity/unchecked-icon.png",
                                  width: 14,
                                  height: 14,
                                ),
                        ),
                        6.rowOffset(),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isAllow = !isAllow;
                              validateInfo();
                            });
                          },
                          child: Container(
                            constraints: BoxConstraints(maxWidth: 300.w),
                            child: RichText(
                              maxLines: 10,
                              textAlign: TextAlign.left,
                              text: TextSpan(
                                text: '我已经仔细阅读并同意',
                                style: TextStyle(
                                  color: ColorUtil.rgba(102, 102, 102, 1),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeightHelper.regular,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '《服务及隐私条款》',
                                      // recognizer: _tapGestureRecognizer,
                                      style: TextStyle(
                                        color: ColorUtil.rgba(156, 108, 255, 1),
                                        fontSize: 12.sp,
                                        fontWeight: FontWeightHelper.regular,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 0.h, bottom: 117.h),
                    child: TRButton(
                      onTap: () {
                        next();
                      },
                      bgc: canNext
                          ? Color(0xff9C6CFF)
                          : Color(0xff9C6CFF).withOpacity(0.19),
                      borderRadius: 22,
                      height: 43.w,
                      text: "下一步",
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeightHelper.semiBold,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ]),
          ],
        ),
      ),
    );
  }
}
