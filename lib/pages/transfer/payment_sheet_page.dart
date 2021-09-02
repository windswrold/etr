import 'package:etrflying/component/custom_textfield.dart';
import 'package:etrflying/pages/transfer/help.dart';

import '../../public.dart';

class PaymentSheetText {
  String? title;
  TextStyle? titleStyle;
  String? content;
  TextStyle? contentStyle;

  PaymentSheetText({
    this.title,
    this.content,
    this.contentStyle,
    this.titleStyle,
  });
}

class PaymentSheet extends StatefulWidget {
  PaymentSheet(
      {Key? key,
      required this.datas,
      required this.amount,
      required this.nextAction,
      required this.token})
      : super(key: key);

  final List<PaymentSheetText> datas;
  final String amount;
  final String token;

  final Function(String) nextAction;

  @override
  _PaymentSheetState createState() => _PaymentSheetState();

  static List<PaymentSheetText> getTransStyleList(
      {String? from = "",
      String to = "",
      String remark = "",
      String? fee = "",
      String? details = ""}) {
    TextStyle title = TextStyle(
      color: ColorUtil.rgba(153, 153, 153, 1),
      fontSize: 14.sp,
      fontWeight: FontWeightHelper.regular,
    );
    TextStyle content = TextStyle(
      color: ColorUtil.rgba(51, 51, 51, 1),
      fontSize: 12.sp,
      fontWeight: FontWeightHelper.regular,
    );

    List<PaymentSheetText> datas = [
      PaymentSheetText(
          title: "支付信息",
          content: details,
          titleStyle: title,
          contentStyle: TextStyle(
            color: ColorUtil.rgba(0, 0, 0, 1),
            fontSize: 14.sp,
            fontWeight: FontWeightHelper.regular,
          )),
      PaymentSheetText(
          title: "接收地址", content: to, titleStyle: title, contentStyle: content),
      PaymentSheetText(
          title: "付款地址",
          content: from,
          titleStyle: title,
          contentStyle: content),
      PaymentSheetText(
          title: "矿工费",
          content: fee,
          titleStyle: title,
          contentStyle: TextStyle(
            color: ColorUtil.rgba(51, 51, 51, 1),
            fontSize: 14.sp,
            fontWeight: FontWeightHelper.regular,
          )),
    ];

    return datas;
  }
}

class _PaymentSheetState extends State<PaymentSheet> {
  bool isSend = false;
  bool canNext = false;
  final pwdED = TextEditingController();

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

  void _next() {
    setState(() {
      isSend = true;
    });
  }

  void _complation() {
    if (canNext == false) {
      return;
    }
    Provider.of<CurrentChooseWalletState>(context, listen: false)
        .currentWallet
        .lockPin(
            text: pwdED.text,
            ok: (value) {
              Navigator.pop(context);
              widget.nextAction(value!);
            },
            wrong: () {
              HWToast.showText(text: "密码错误!");
            });
  }

  void sheetClose() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isSend == false ? 540.w : 300.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          color: Colors.white),
      padding: EdgeInsets.only(
        top: 16.w,
        left: 14.w,
        right: 14.w,
      ),
      child: isSend == false
          ? Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                    ),
                    Text(
                      "确认信息",
                      style: TextStyle(
                          color: ColorUtil.rgba(51, 51, 51, 1),
                          fontSize: 16.sp,
                          fontWeight: FontWeightHelper.regular),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => {sheetClose()},
                      child: LoadAssetsImage(
                        "home/close-icon.png",
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 34.w),
                  child: Text(
                    "转账金额",
                    style: TextStyle(
                      color: ColorUtil.rgba(153, 153, 153, 1),
                      fontSize: 14.sp,
                      fontWeight: FontWeightHelper.regular,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.w, bottom: 8.w),
                  child: RichText(
                    text: TextSpan(
                        text: widget.amount,
                        style: TextStyle(
                          color: ColorUtil.rgba(51, 51, 51, 1),
                          fontSize: 25.sp,
                          fontWeight: FontWeightHelper.bold,
                        ),
                        children: [
                          TextSpan(
                            text: " " + widget.token,
                            style: TextStyle(
                              color: ColorUtil.rgba(51, 51, 51, 1),
                              fontSize: 14.sp,
                              fontWeight: FontWeightHelper.regular,
                            ),
                          ),
                        ]),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.datas.length,
                    itemBuilder: (BuildContext context, int index) {
                      PaymentSheetText sheet = widget.datas[index];
                      return Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 24.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child:
                                  Text(sheet.title!, style: sheet.titleStyle),
                            ),
                            Expanded(
                              child: Text(
                                sheet.content!,
                                style: sheet.contentStyle,
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                TRButton(
                  onTap: _next,
                  text: "发送",
                  bgc: ColorUtil.rgba(156, 108, 255, 1),
                  height: 40.w,
                  borderRadius: 22,
                  margin: EdgeInsets.only(
                    bottom: 58.w,
                    left: 40.w,
                    right: 40.w,
                  ),
                  textStyle: TextStyle(
                      fontWeight: FontWeightHelper.semiBold,
                      fontSize: 16.sp,
                      color: Colors.white),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                    ),
                    Text(
                      "密码",
                      style: TextStyle(
                          color: ColorUtil.rgba(51, 51, 51, 1),
                          fontSize: 16.sp,
                          fontWeight: FontWeightHelper.regular),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => {sheetClose()},
                      child: LoadAssetsImage(
                        "home/close-icon.png",
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 53.w),
                  child: Text(
                    "请输入安全密码",
                    style: TextStyle(
                        color: ColorUtil.rgba(51, 51, 51, 1),
                        fontSize: 16.sp,
                        fontWeight: FontWeightHelper.regular),
                  ),
                ),
                CustomTextField(
                  padding: EdgeInsets.only(top: 12.w),
                  obscureText: true,
                  controller: pwdED,
                  autofocus: true,
                  style: TextStyle(
                    color: ColorUtil.rgba(153, 153, 153, 1),
                    fontSize: 14.sp,
                    fontWeight: FontWeightHelper.regular,
                  ),
                  decoration: CustomTextField.getBorderLineDecoration(
                    hintText: "输入安全密码",
                    hintStyle: TextStyle(
                      color: ColorUtil.rgba(0, 0, 0, 0.25),
                      fontSize: 14.sp,
                      fontWeight: FontWeightHelper.regular,
                    ),
                    contentPadding: EdgeInsets.fromLTRB(14, 12, 14, 12),
                  ),
                ),
                TRButton(
                  onTap: _complation,
                  text: "发送",
                  bgc: canNext
                      ? Color(0xff9C6CFF)
                      : Color(0xff9C6CFF).withOpacity(0.19),
                  height: 40.w,
                  borderRadius: 22,
                  margin: EdgeInsets.only(
                      top: 31.w, left: 40.w, right: 40.w, bottom: 12.w),
                  textStyle: TextStyle(
                      fontWeight: FontWeightHelper.semiBold,
                      fontSize: 16.sp,
                      color: Colors.white),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Routers.push(context, HelpPage());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoadAssetsImage(
                        "wallet/question.png",
                        width: 15,
                        height: 15,
                      ),
                      4.rowOffset(),
                      Text(
                        "忘记密码怎么办",
                        style: TextStyle(
                          color: ColorUtil.rgba(150, 98, 255, 1),
                          fontSize: 12.sp,
                          fontWeight: FontWeightHelper.regular,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
