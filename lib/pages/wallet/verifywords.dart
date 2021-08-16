import 'dart:math';

import 'package:etrflying/component/custom_dialog.dart';
import 'package:etrflying/component/custom_textfield.dart';
import 'package:etrflying/component/positioned-text-component.dart';
import 'package:etrflying/pages/tabbar/tabbar.dart';

import '../../public.dart';

class VerifyWords extends StatefulWidget {
  VerifyWords({Key? key, required this.words}) : super(key: key);

  final String words;

  @override
  _VerifyWordsState createState() => _VerifyWordsState();
}

class _VerifyWordsState extends State<VerifyWords> {
  double width = 0;
  int _index = Random().nextInt(12) + 1;

  final wordsED = TextEditingController();
  @override
  void initState() {
    super.initState();
    double screenWidth = ScreenUtil().screenWidth;
    width = (screenWidth - 80.w - 14.w) / 3;
  }

  _next() {
    final input = wordsED.text;
    final word = widget.words.split(" ")[_index - 1];
    bool state = input == word;

    HWToast.showText(
      text: state == true ? "验证成功!" : "验证失败!",
      contentColor: ColorUtil.rgba(30, 0, 92, 1),
      align: Alignment.topCenter,
      textStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeightHelper.regular,
          color: Colors.white),
      contentPadding: EdgeInsets.fromLTRB(44.w, 12, 44.w, 12),
      borderRadius: BorderRadius.circular(23),
    );
    if (state) {
      Provider.of<CurrentChooseWalletState>(context, listen: false)
          .updateBackWalletState(KAccountState.authed);
      Future.delayed(Duration(seconds: 3)).then((value) => {
            Routers.push(context, HomeTabbar(), clearStack: true),
          });
    }
  }

  Widget _getVerifyWidget() {
    return Container(
      margin: EdgeInsets.only(top: 53.h),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "请选择第$_index个单词",
            style: TextStyle(
                color: ColorUtil.rgba(156, 108, 255, 1),
                fontSize: 16.sp,
                fontWeight: FontWeightHelper.regular),
          ),
          CustomTextField(
            controller: wordsED,
            padding: EdgeInsets.only(top: 15.w),
            style: TextStyle(
                color: ColorUtil.rgba(51, 51, 48, 1),
                fontSize: 16.sp,
                fontWeight: FontWeightHelper.regular),
            decoration: CustomTextField.getUnderLineDecoration(),
          )
        ],
      ),
    );
  }

  Widget _getWordsWidget() {
    List<String> memos = widget.words.split(" ");
    memos.shuffle(Random());
    List<Widget> children = memos
        .map((e) => GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                wordsED.text = e;
              },
              child: Container(
                height: 43.w,
                width: width,
                // padding: EdgeInsets.fromLTRB(27.w, 0, 27.w, 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: ColorUtil.rgba(217, 217, 217, 1),
                    )),
                child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: AlignmentDirectional.topStart,
                        margin: EdgeInsets.only(left: 5, top: 5),
                        child: Text(
                          (memos.indexOf(e) + 1).toString(),
                          style: TextStyle(
                              color: ColorUtil.rgba(153, 153, 153, 1),
                              fontSize: 10.sp,
                              fontWeight: FontWeightHelper.regular),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          e,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: ColorUtil.rgba(51, 51, 51, 1),
                              fontSize: 16.sp,
                              fontWeight: FontWeightHelper.regular),
                        ),
                      ),
                    ]),
              ),
            ))
        .toList();

    return Container(
      margin: EdgeInsets.only(
        top: 92.h,
      ),
      child: Wrap(
        spacing: 7.w,
        runSpacing: 7.w,
        children: children,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomPageView(
      title: CustomPageView.getTitle(title: "验证助记词"),
      hiddenScrollView: true,
      child: Container(
        margin: EdgeInsets.only(left: 40.w, right: 40.w),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "验证助记词",
                style: TextStyle(
                  color: ColorUtil.rgba(51, 51, 51, 1),
                  fontSize: 25.sp,
                  fontWeight: FontWeightHelper.semiBold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 4.w),
              alignment: Alignment.centerLeft,
              child: Text(
                "确保您已备份好您的助记词，请验证如下问题：",
                style: TextStyle(
                  color: ColorUtil.rgba(102, 102, 102, 1),
                  fontSize: 14.sp,
                  fontWeight: FontWeightHelper.regular,
                ),
              ),
            ),
            _getVerifyWidget(),
            _getWordsWidget(),
            Padding(
              padding: EdgeInsets.only(top: 74.h),
              child: TRButton(
                onTap: () {
                  _next();
                },
                bgc: Color(0xff9C6CFF),
                borderRadius: 22,
                height: 43.w,
                text: "确认",
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
