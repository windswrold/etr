import 'package:bip39/bip39.dart';
import 'package:bip39/bip39.dart';
import 'package:etrflying/component/positioned-text-component.dart';
import 'package:etrflying/component/router-back.dart';
import 'package:etrflying/pages/fill_info/validate_mnemonic.dart';
import 'package:flutter/material.dart';
import 'package:bip39/bip39.dart' as bip39;

class MnemonicSave extends StatefulWidget {
  MnemonicSaveState createState() => MnemonicSaveState();
}

class MnemonicSaveState extends State<MnemonicSave> {
  final wordsString = bip39.generateMnemonic();
  final path = "assets/img/fill_info";
  bool showTips = true;
  @override
  Widget build(BuildContext context) {
    List words = wordsString.split(" ");
    return new Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          height: 812,
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
                text: "备份身份助记词",
              ),
              PositionedTextComponent(
                left: 44,
                top: 146,
                right: 48,
                width: double.infinity,
                fontSize: 14,
                color: Color(0xff333333),
                text: "请按照顺序抄下下方12个助记词，我们将在下一步验证",
              ),
              Positioned(
                left: 40,
                right: 40,
                top: 228,
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
                        return Container(
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
                                text: words[index],
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ),
              Positioned(
                left: 40,
                right: 40,
                top: 490,
                child: Container(
                  height: 169,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(path + "/tips-icon.png"),
                          fit: BoxFit.fill)),
                  child: Stack(
                    children: <Widget>[
                      PositionedTextComponent(
                        text: "注意：",
                        left: 16,
                        top: 29,
                        fontSize: 14,
                        color: Color(0xffF86A0E),
                        fontWeight: FontWeight.bold,
                      ),
                      PositionedTextComponent(
                        text: "请勿将助记词透露给任何人",
                        left: 16,
                        top: 59,
                        fontSize: 12,
                        color: Color(0xffF86A0E),
                      ),
                      PositionedTextComponent(
                        text: "助记词一旦丢失，资产将无法恢复",
                        left: 16,
                        top: 85,
                        fontSize: 12,
                        color: Color(0xffF86A0E),
                      ),
                      PositionedTextComponent(
                        text: "请勿通过截屏、网络传输的方式进行备份保存",
                        left: 16,
                        top: 110,
                        fontSize: 12,
                        color: Color(0xffF86A0E),
                      ),
                      PositionedTextComponent(
                        text: "遇到任何情况，请不要轻易卸载钱包APP",
                        left: 16,
                        top: 136,
                        fontSize: 12,
                        color: Color(0xffF86A0E),
                      ),
                    ],
                  ),
                ),
              ),
              PositionedTextComponent(
                fontSize: 16,
                color: Colors.white,
                left: 40,
                right: 40,
                width: double.infinity,
                height: 43,
                backgroundColor: Color(0xff9C6CFF),
                top: 690,
                text: "确认",
                borderRadius: 22,
                textAlign: TextAlign.center,
                paddingTop: 8,
                event: () {
//              if(canNext){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ValidateMnemonic(word: words as List<String>?)));
//              }else{
//                Toast.show(img==null?"请上传你的照片":"请确认并勾选《服务及隐私条款》", context,gravity: Toast.CENTER);
//              }
                },
              ),
              showTips
                  ? Positioned(
                      left: 0,
                      right: 0,
                      child: Container(
                        width: double.infinity,
                        height: 812,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    )
                  : Container(),
              showTips
                  ? Positioned(
                      left: 25,
                      right: 25,
                      top: 181,
                      child: Container(
                        width: double.infinity,
                        height: 418,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              top: 40,
                              left: 138,
                              right: 135,
                              child: Container(
                                width: double.infinity,
                                height: 72,
                                child: Image.asset(
                                  path + "/no-screenshot-icon.png",
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            PositionedTextComponent(
                              text: "安全提醒",
                              left: 0,
                              right: 0,
                              width: double.infinity,
                              textAlign: TextAlign.center,
                              top: 142,
                              fontSize: 17,
                              color: Color(0xff161A27),
                            ),
                            PositionedTextComponent(
                              text: "为您的资产安全考虑，请勿截屏。",
                              left: 30,
                              top: 181,
                              fontSize: 14,
                              color: Color(0xff666666),
                            ),
                            PositionedTextComponent(
                              text: "截屏存入相册后，有可能同步至云端，导致助记词泄露。",
                              left: 30,
                              right: 54,
                              width: double.infinity,
                              top: 211,
                              fontSize: 14,
                              color: Color(0xff666666),
                            ),
                            PositionedTextComponent(
                              text: "建议您将助记词备份到断网的物理介质上，",
                              left: 30,
                              top: 263,
                              fontSize: 14,
                              color: Color(0xff666666),
                            ),
                            PositionedTextComponent(
                              text: "例如手抄在白纸上，并妥善保存。",
                              left: 30,
                              top: 285,
                              fontSize: 14,
                              color: Color(0xff666666),
                            ),
                            PositionedTextComponent(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                              left: 86,
                              right: 87,
                              width: double.infinity,
                              height: 43,
                              gradient: LinearGradient(
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft,
                                  colors: [
                                    Color(0xffcba5ff),
                                    Color(0xff9c6cff)
                                  ]),
                              top: 335,
                              text: "确认",
                              borderRadius: 22,
                              textAlign: TextAlign.center,
                              paddingTop: 8,
                              event: () {
                                setState(() {
                                  showTips = false;
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
