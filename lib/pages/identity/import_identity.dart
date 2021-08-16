// import 'package:bip39/bip39.dart' as bip39;
import 'package:etrflying/component/custom_pageview.dart';
import 'package:etrflying/component/positioned-text-component.dart';
import 'package:etrflying/component/router-back.dart';
import 'package:etrflying/component/text-component.dart';
import 'package:etrflying/component/textarea-component.dart';
import 'package:etrflying/model/mnemonic/mnemonic.dart';
import 'package:etrflying/model/tr_wallet.dart';
import 'package:etrflying/pages/guide/carousel.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../public.dart';
import 'import_setpwd.dart';

class ImportWallet extends StatefulWidget {
  ImportWalletState createState() => ImportWalletState();
}

class ImportWalletState extends State<ImportWallet> {
  String path = "assets/img/identity";
  bool isWord = true;
  bool wordRight = false;
  bool showSecretWarn = false;
  bool showWordWarn = true;
  bool canNext = false;
  String titleTips = "请填写您的助记词";
  int wordColor = 0xff333333;
  int secreColor = 0xff999999;

  ///验证是否可以下一步
  void validateNext() {
    setState(() {
      if (isWord) {
        if (Mnemonic.validateMnemonic(wordController.text)) {
          canNext = true;
        } else {
          canNext = false;
        }
        return;
      } else {
        if (secretController.text.checkPrv(KCoinType.ETH) == true) {
          canNext = true;
        } else {
          canNext = false;
        }
      }
    });
  }

  void checkWord() {
    setState(() {
      left = 40.w;
      isWord = true;
      showSecretWarn = false;
      titleTips = "请填写您的助记词";
      if (!Mnemonic.validateMnemonic(wordController.text)) {
        showWordWarn = true;
      }
      wordColor = 0xff333333;
      secreColor = 0xff999999;
      validateNext();
    });
  }

  void checkScret() {
    setState(() {
      left = 103.w;
      isWord = false;
      showWordWarn = false;
      titleTips = "请填写您的私钥";
      if (secretController.text.length < 1) {
        showSecretWarn = true;
      }
      wordColor = 0xff999999;
      secreColor = 0xff333333;
      validateNext();
    });
  }

  double left = 40.w;
  final wordController = TextEditingController();
  final secretController = TextEditingController();

  String? validateWord(value) {
    if (isWord) {
      if (!Mnemonic.validateMnemonic(value)) {
        wordRight = false;
        return "当前助记词输入错误，请检查";
      }
      wordRight = true;
      return null;
    }
    return null;
  }

  String? validateSecret(value) {
    if (!isWord) {
      if (value.length < 1) {
        return "请输入私钥";
      }
      return null;
    }
    return null;
  }

  void next() {
    if (canNext == false) {
      return;
    }
    String content = "";
    KLeadType leadType;
    if (isWord == true) {
      content = wordController.text;
      leadType = KLeadType.Memo;
    } else {
      content = secretController.text;
      leadType = KLeadType.Prvkey;
    }
    Routers.push(
        context, ImportSetPassword(content: content, leadType: leadType));
  }

  @override
  void initState() {
    super.initState();
    wordController.addListener(() {
      String word = wordController.text;
      if (!Mnemonic.validateMnemonic(word)) {
        setState(() {
          showWordWarn = true;
          validateNext();
        });
      } else {
        setState(() {
          showWordWarn = false;
          validateNext();
        });
      }
    });
    secretController.addListener(() {
      String word = secretController.text;
      if (word.length < 1) {
        setState(() {
          showSecretWarn = true;
          validateNext();
        });
      } else {
        setState(() {
          showSecretWarn = false;
          validateNext();
        });
      }
    });

    if (inProduction == false) {
      wordController.text =
          "coyote usage express mesh shoulder common web breeze country fan hope quiz";
      secretController.text =
          "40730f5ddc6b492688ce3897b9ff54e582f6ad8243a90ece21b060a46db46b44";
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomPageView(
      hiddenScrollView: true,
      child: Container(
        child: Stack(
          children: <Widget>[
            //导入钱包标题
            PositionedTextComponent(
                left: 40.w,
                right: 0,
                top: 0,
                width: double.infinity,
                text: "导入钱包",
                fontSize: 25.sp,
                fontWeight: FontWeightHelper.semiBold,
                color: Color(0xff333333)),

            PositionedTextComponent(
              left: 40.w,
              right: 0,
              top: 44.h,
              width: 42.w,
              text: "助记词",
              fontSize: 14.sp,
              color: Color(wordColor),
              fontWeight: FontWeight.w600,
              event: checkWord,
            ),
            PositionedTextComponent(
              left: 110.w,
              right: 0,
              top: 44.h,
              text: "私钥",
              fontSize: 14.sp,
              color: Color(secreColor),
              fontWeight: FontWeight.w600,
              event: checkScret,
            ),
            //选中下边栏
            Positioned(
              left: left,
              top: 68.w,
              child: Container(
                width: 42.w,
                decoration: BoxDecoration(
                    border: new Border.all(color: Color(0xff333333), width: 1)),
              ),
            ),
            //助记词填写title
            PositionedTextComponent(
                left: 40.w,
                top: 110.h,
                right: 0,
                fontSize: 14.sp,
                width: double.infinity,
                fontWeight: FontWeightHelper.regular,
                text: titleTips,
                color: Color(0xff333333)),
            isWord
                ? Textarea(
                    validate: validateWord,
                    controller: wordController,
                    labelText: "请填写您的助记词",
                  )
                : Textarea(
                    validate: validateSecret,
                    controller: secretController,
                    labelText: "请填写您的私钥",
                  ),

            // Positioned(
            //   left: 41.w,
            //   top: 345.h,
            //   child: Container(
            //     width: 14,
            //     height: 14,
            //     child: showWordWarn
            //         ? Image.asset(path + "/little-warn-icon.png")
            //         : null,
            //   ),
            // ),
            // Positioned(
            //   left: 41.w,
            //   top: 345.h,
            //   child: Container(
            //     width: 14,
            //     height: 14,
            //     child: showSecretWarn
            //         ? Image.asset(path + "/little-warn-icon.png")
            //         : null,
            //   ),
            // ),

            Positioned(
                bottom: 43.h,
                left: 40.w,
                right: 40.w,
                child: Listener(
                    child: Container(
                      width: double.infinity,
                      height: 43,
                      padding: EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                          color: canNext
                              ? Color(0xff9C6CFF)
                              : Color(0xff9C6CFF).withOpacity(0.19),
                          borderRadius: BorderRadius.circular(22),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 6),
                                blurRadius: 13,
                                color: Color.fromRGBO(156, 108, 255, 0.19)),
                          ]),
                      child: Text(
                        "确定",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "PingFangSC",
                          fontSize: 16,
                        ),
                      ),
                    ),
                    onPointerDown: (event) => {
                          next(),
                        }))
          ],
        ),
      ),
    );
  }
}
