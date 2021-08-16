import 'package:etrflying/component/custom_textfield.dart';
import 'package:etrflying/model/tr_wallet.dart';
import 'package:etrflying/pages/guide/carousel.dart';

import '../../public.dart';

class ImportSetPassword extends StatefulWidget {
  ImportSetPassword({Key? key, this.content, this.leadType}) : super(key: key);
  final String? content;
  final KLeadType? leadType;

  @override
  _ImportSetPasswordState createState() => _ImportSetPasswordState();
}

class _ImportSetPasswordState extends State<ImportSetPassword> {
  final passwordController = TextEditingController();
  bool showPasswordClear = false;
  //显示密码按钮
  bool showPassword = false;
  bool canNext = false;
  bool showPasswordWarn = true;

  String? validatePassword(value) {
    if (value.length < 8) {
      return '密码不能少于8个字符';
    }
    if (value.length > 32) {
      return '密码不能大于32个字符';
    }
    return null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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

  void validateInfo() {
    int passwordLength = passwordController.text.trim().length;
    if ((passwordLength > 7 && passwordLength < 33)) {
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
    final pwd = passwordController.text;
    TRWallet.importWallet(context,
        content: widget.content!,
        pin: pwd,
        walletName: "",
        kCoinType: KCoinType.All,
        kLeadType: widget.leadType!);
  }

  @override
  Widget build(BuildContext context) {
    return CustomPageView(
      title: CustomPageView.getTitle(title: "设置安全密码"),
      hiddenScrollView: true,
      child: Container(
        padding: EdgeInsets.only(left: 40.w, right: 40.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                                  : LoadAssetsImage("identity/noshow-icon.png",
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
              ],
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
      ),
    );
  }
}
