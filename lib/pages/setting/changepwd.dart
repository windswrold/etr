import 'package:etrflying/component/custom_textfield.dart';
import 'package:etrflying/model/tr_wallet.dart';
import 'package:etrflying/pages/index/index.dart';
import 'package:etrflying/pages/transfer/help.dart';

import '../../public.dart';

class ChangePWD extends StatefulWidget {
  ChangePWD({
    Key? key,
  }) : super(key: key);

  @override
  _ChangePWDState createState() => _ChangePWDState();
}

class _ChangePWDState extends State<ChangePWD> {
  final oldED = TextEditingController();
  final newpwdED = TextEditingController();
  final againED = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  showAlet(String text) {
    HWToast.showText(
      text: text,
      contentColor: ColorUtil.rgba(30, 0, 92, 1),
      align: Alignment.topCenter,
      textStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeightHelper.regular,
          color: Colors.white),
      contentPadding: EdgeInsets.fromLTRB(44.w, 12, 44.w, 12),
      borderRadius: BorderRadius.circular(23),
    );
  }

  void next() {
    final oldtext = oldED.text;
    final newText = newpwdED.text;
    final againText = againED.text;

    if (oldtext.length == 0 || newText.length == 0 || againText.length == 0) {
      showAlet("请输入密码");
      return;
    }
    if (newText != againText) {
      showAlet("新密码输入不一致");
      return;
    }
    if (newText.checkPassword() == false) {
      showAlet("新密码过于简单");
      return;
    }

    TRWallet wallet =
        Provider.of<CurrentChooseWalletState>(context, listen: false)
            .wallets
            .first;
    wallet.lockPin(
        text: oldED.text,
        ok: (value) {
          //旧的解密
          //新的将私钥助记词加密
          Provider.of<CurrentChooseWalletState>(context, listen: false)
              .updateWalletPwd(value!, newText);
          showAlet("修改成功");
          Future.delayed(Duration(seconds: 3)).then((value) => {
                Routers.goBack(context),
              });
        },
        wrong: () {
          showAlet("密码错误!");
        });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPageView(
      title: CustomPageView.getTitle(title: "修改安全密码"),
      backgroundColor: ColorUtil.rgba(248, 248, 252, 1),
      hiddenScrollView: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            Container(
              margin: EdgeInsets.only(left: 14.w, top: 14.w, right: 14.w),
              padding: EdgeInsets.fromLTRB(10.w, 8.w, 16.w, 18.w),
              color: Color(0xfffdfaea),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LoadAssetsImage(
                    "identity/warn-icon.png",
                    width: 16,
                    height: 16,
                  ),
                  5.rowOffset(),
                  Expanded(
                    child: Text(
                      "密码用于保护私钥和交易授权，强度非常重要，品台不储存密码，也无法棒你找回，请务必牢记",
                      style: TextStyle(
                        color: ColorUtil.rgba(248, 106, 14, 1),
                        fontSize: 12.sp,
                        fontWeight: FontWeightHelper.regular,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 14.w),
                color: Colors.white,
                padding: EdgeInsets.only(left: 14.w, right: 14.w),
                height: 52.w,
                child: Row(
                  children: [
                    Container(
                      width: 140.w,
                      child: Text(
                        "旧密码",
                        style: TextStyle(
                          color: ColorUtil.rgba(51, 51, 51, 1),
                          fontSize: 16.sp,
                          fontWeight: FontWeightHelper.regular,
                        ),
                      ),
                    ),
                    Expanded(
                      child: CustomTextField(
                        controller: oldED,
                        obscureText: true,
                        style: TextStyle(
                          color: ColorUtil.rgba(51, 51, 51, 1),
                          fontSize: 16.sp,
                          fontWeight: FontWeightHelper.regular,
                        ),
                        decoration: CustomTextField.getNormalDecoration(
                          hintText: "请填写旧密码",
                          hintStyle: TextStyle(
                            color: ColorUtil.rgba(153, 153, 153, 0.55),
                            fontSize: 16.sp,
                            fontWeight: FontWeightHelper.regular,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            Container(
              color: ColorUtil.rgba(241, 241, 241, 1),
              margin: EdgeInsets.only(left: 14.w, right: 14.w),
              height: 1,
              alignment: Alignment.center,
            ),
            Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: 14.w, right: 14.w),
                height: 52.w,
                child: Row(
                  children: [
                    Container(
                      width: 140.w,
                      child: Text(
                        "新密码",
                        style: TextStyle(
                          color: ColorUtil.rgba(51, 51, 51, 1),
                          fontSize: 16.sp,
                          fontWeight: FontWeightHelper.regular,
                        ),
                      ),
                    ),
                    Expanded(
                      child: CustomTextField(
                        controller: newpwdED,
                        obscureText: true,
                        style: TextStyle(
                          color: ColorUtil.rgba(51, 51, 51, 1),
                          fontSize: 16.sp,
                          fontWeight: FontWeightHelper.regular,
                        ),
                        decoration: CustomTextField.getNormalDecoration(
                          hintText: "请填写新密码",
                          hintStyle: TextStyle(
                            color: ColorUtil.rgba(153, 153, 153, 0.55),
                            fontSize: 16.sp,
                            fontWeight: FontWeightHelper.regular,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            Container(
              color: ColorUtil.rgba(241, 241, 241, 1),
              margin: EdgeInsets.only(left: 14.w, right: 14.w),
              height: 1,
              alignment: Alignment.center,
            ),
            Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: 14.w, right: 14.w),
                height: 52.w,
                child: Row(
                  children: [
                    Container(
                      width: 140.w,
                      child: Text(
                        "重复新密码",
                        style: TextStyle(
                          color: ColorUtil.rgba(51, 51, 51, 1),
                          fontSize: 16.sp,
                          fontWeight: FontWeightHelper.regular,
                        ),
                      ),
                    ),
                    Expanded(
                      child: CustomTextField(
                        controller: againED,
                        obscureText: true,
                        style: TextStyle(
                          color: ColorUtil.rgba(51, 51, 51, 1),
                          fontSize: 16.sp,
                          fontWeight: FontWeightHelper.regular,
                        ),
                        decoration: CustomTextField.getNormalDecoration(
                          hintText: "请填写新密码",
                          hintStyle: TextStyle(
                            color: ColorUtil.rgba(153, 153, 153, 0.55),
                            fontSize: 16.sp,
                            fontWeight: FontWeightHelper.regular,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            Container(
              color: ColorUtil.rgba(241, 241, 241, 1),
              margin: EdgeInsets.only(left: 14.w, right: 14.w),
              height: 1,
              alignment: Alignment.center,
            ),
            GestureDetector(
              onTap: () {
                // Routers.push(context, HelpPage());
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: 14.w, right: 14.w),
                margin: EdgeInsets.only(bottom: 16.w),
                height: 44.w,
                alignment: Alignment.centerLeft,
                child: Text(
                  "密码至少有8~32位大小写字母、数字、字符组合",
                  style: TextStyle(
                    color: ColorUtil.rgba(153, 153, 153, 1),
                    fontSize: 14.sp,
                    fontWeight: FontWeightHelper.regular,
                  ),
                ),
              ),
            ),
          ]),
          Container(
            padding: EdgeInsets.only(left: 14.w, right: 14.w),
            margin: EdgeInsets.only(bottom: 69.w),
            child: TRButton(
              onTap: () {
                next();
              },
              bgc: Color(0xff9C6CFF),
              borderRadius: 22,
              height: 43.w,
              text: "确定",
              textStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeightHelper.semiBold,
                fontSize: 16.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
