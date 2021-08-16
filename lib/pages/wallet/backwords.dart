import 'package:etrflying/component/custom_dialog.dart';
import 'package:etrflying/component/positioned-text-component.dart';
import 'package:etrflying/pages/wallet/verifywords.dart';

import '../../public.dart';

class BackWords extends StatefulWidget {
  BackWords({Key? key, required this.words}) : super(key: key);

  final String words;

  @override
  _BackWordsState createState() => _BackWordsState();
}

class _BackWordsState extends State<BackWords> {
  double width = 0;
  @override
  void initState() {
    super.initState();
    double screenWidth = ScreenUtil().screenWidth;
    width = (screenWidth - 80.w - 14.w) / 3;

    _showAlertView();
  }

  _showAlertView() {
    Future.delayed(Duration(milliseconds: 200)).then((value) => {
          showBackWarningAlertView(
              context: context, cancelPressed: () {}, confirmPressed: () {}),
        });
  }

  _getTip() {
    return Container(
      margin: EdgeInsets.fromLTRB(40.w, 26.w, 40.w, 0),
      height: 169,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(ASSETS_IMG + "fill_info/tips-icon.png"),
              fit: BoxFit.fill)),
      child: Stack(
        children: <Widget>[
          PositionedTextComponent(
            text: "注意：",
            left: 16.w,
            top: 29.w,
            fontSize: 14.sp,
            color: Color(0xffF86A0E),
            fontWeight: FontWeightHelper.semiBold,
          ),
          PositionedTextComponent(
            text: "请勿将助记词透露给任何人",
            left: 16.w,
            top: 59.w,
            fontSize: 12.sp,
            color: Color(0xffF86A0E),
          ),
          PositionedTextComponent(
            text: "助记词一旦丢失，资产将无法恢复",
            left: 16.w,
            top: 85.w,
            fontSize: 12.sp,
            color: Color(0xffF86A0E),
          ),
          PositionedTextComponent(
            text: "请勿通过截屏、网络传输的方式进行备份保存",
            left: 16.w,
            top: 110.w,
            fontSize: 12.sp,
            color: Color(0xffF86A0E),
          ),
          PositionedTextComponent(
            text: "遇到任何情况，请不要轻易卸载钱包APP",
            left: 16.w,
            top: 136.w,
            fontSize: 12.sp,
            color: Color(0xffF86A0E),
          ),
        ],
      ),
    );
  }

  Widget _getWordsWidget() {
    List<String> memos = widget.words.split(" ");

    List<Widget> children = memos
        .map((e) => Container(
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
            ))
        .toList();

    return Container(
      margin: EdgeInsets.only(left: 40.w, top: 32.w, right: 40.w),
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
      title: CustomPageView.getTitle(title: "备份钱包"),
      hiddenScrollView: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            Container(
              height: 12.w,
              color: ColorUtil.rgba(248, 248, 252, 1),
            ),
            Visibility(
              visible:
                  Provider.of<CurrentChooseWalletState>(context, listen: false)
                          .isNeedAuth() ==
                      KAccountState.init,
              child: Container(
                padding: EdgeInsets.only(
                  left: 14.w,
                  top: 16.w,
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  "请按照顺序抄下下方12个助记词，我们将在下\n一步验证",
                  style: TextStyle(
                    color: ColorUtil.rgba(51, 51, 51, 1),
                    fontSize: 14.sp,
                    fontWeight: FontWeightHelper.regular,
                  ),
                ),
              ),
            ),
            _getWordsWidget(),
            _getTip(),
          ]),
          Padding(
            padding: EdgeInsets.only(
                top: 0.h, bottom: 59.h, left: 14.w, right: 14.w),
            child: TRButton(
              onTap: () {
                if (Provider.of<CurrentChooseWalletState>(context,
                            listen: false)
                        .isNeedAuth() ==
                    KAccountState.init) {
                  Routers.push(context, VerifyWords(words: widget.words));
                } else {
                  HWToast.showText(text: "备份成功");
                  Future.delayed(Duration(seconds: 3)).then((value) => {
                        Routers.goBack(context),
                      });
                }
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
    );
  }
}
