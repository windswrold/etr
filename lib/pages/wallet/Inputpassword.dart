import 'package:etrflying/component/custom_textfield.dart';
import 'package:etrflying/model/tr_wallet.dart';
import 'package:etrflying/pages/index/index.dart';
import 'package:etrflying/pages/transfer/help.dart';

import '../../public.dart';
import 'backwords.dart';

class InputPassword extends StatefulWidget {
  InputPassword({Key? key, required this.inputType}) : super(key: key);
  final InputPasswordType inputType;

  @override
  _InputPasswordState createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  final pwdED = TextEditingController();
  bool canNext = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    pwdED.addListener(() {
      setState(() {
        if (pwdED.text.length > 0) {
          canNext = true;
        } else {
          canNext = false;
        }
      });
    });
  }

  void next() {
    if (canNext == false) {
      return;
    }
    TRWallet wallet =
        Provider.of<CurrentChooseWalletState>(context, listen: false)
            .wallets
            .first;
    wallet.lockPin(
        text: pwdED.text,
        ok: (value) {
          if (widget.inputType == InputPasswordType.DelWallet) {
            Provider.of<CurrentChooseWalletState>(context, listen: false)
                .delWallets();
            Routers.push(context, Index());
          } else {
            final memo = wallet.exportMemo(pin: value!)!;
            Routers.push(context, BackWords(words: memo));
          }
        },
        wrong: () {
          HWToast.showText(text: "密码错误!");
        });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPageView(
      title: CustomPageView.getTitle(
          title: widget.inputType == InputPasswordType.authWallet
              ? "备份钱包"
              : widget.inputType == InputPasswordType.DelWallet
                  ? "删除钱包"
                  : "备份钱包"),
      backgroundColor: ColorUtil.rgba(248, 248, 252, 1),
      child: Column(
        children: [
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
                      "请输入安全密码",
                      style: TextStyle(
                        color: ColorUtil.rgba(51, 51, 51, 1),
                        fontSize: 16.sp,
                        fontWeight: FontWeightHelper.regular,
                      ),
                    ),
                  ),
                  Expanded(
                    child: CustomTextField(
                      controller: pwdED,
                      obscureText: true,
                      style: TextStyle(
                        color: ColorUtil.rgba(51, 51, 51, 1),
                        fontSize: 16.sp,
                        fontWeight: FontWeightHelper.regular,
                      ),
                      decoration: CustomTextField.getNormalDecoration(
                        hintText: "请填写安全密码",
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
              Routers.push(context, HelpPage());
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 14.w, right: 14.w),
              margin: EdgeInsets.only(bottom: 16.w),
              height: 44.w,
              alignment: Alignment.centerLeft,
              child: Text(
                "忘记密码怎么办？",
                style: TextStyle(
                  color: ColorUtil.rgba(55, 0, 108, 1),
                  fontSize: 12.sp,
                  fontWeight: FontWeightHelper.regular,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 14.w, right: 14.w),
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
    );
  }
}
