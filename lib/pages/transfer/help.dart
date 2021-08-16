import '../../public.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPageView(
      child: Container(
        margin: EdgeInsets.only(left: 20.w, right: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.only(top: 44.w, bottom: 35.w),
                child: Text(
                  "安全密码忘记了怎么办？",
                  style: TextStyle(
                    color: ColorUtil.rgba(51, 51, 51, 1),
                    fontSize: 25.sp,
                    fontWeight: FontWeightHelper.semiBold,
                  ),
                )),
            Container(
              child: RichText(
                text: TextSpan(
                  text: "钱包",
                  style: TextStyle(
                    color: ColorUtil.rgba(51, 51, 51, 1),
                    fontSize: 14.sp,
                    fontWeight: FontWeightHelper.regular,
                  ),
                  children: [
                    TextSpan(
                      text: "不支持",
                      style: TextStyle(
                        color: ColorUtil.rgba(51, 51, 51, 1),
                        fontSize: 14.sp,
                        fontWeight: FontWeightHelper.semiBold,
                      ),
                    ),
                    TextSpan(
                      text: "找回密码。但你可用过",
                      style: TextStyle(
                        color: ColorUtil.rgba(51, 51, 51, 1),
                        fontSize: 14.sp,
                        fontWeight: FontWeightHelper.regular,
                      ),
                    ),
                    TextSpan(
                      text: "导入钱包重置密码",
                      style: TextStyle(
                        color: ColorUtil.rgba(51, 51, 51, 1),
                        fontSize: 14.sp,
                        fontWeight: FontWeightHelper.semiBold,
                      ),
                    ),
                    TextSpan(
                      text: "，新密码会覆盖旧密码。",
                      style: TextStyle(
                        color: ColorUtil.rgba(51, 51, 51, 1),
                        fontSize: 14.sp,
                        fontWeight: FontWeightHelper.regular,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 12.w),
              child: RichText(
                text: TextSpan(
                  text: "如果你",
                  style: TextStyle(
                    color: ColorUtil.rgba(51, 51, 51, 1),
                    fontSize: 14.sp,
                    fontWeight: FontWeightHelper.regular,
                  ),
                  children: [
                    TextSpan(
                      text: "未备份",
                      style: TextStyle(
                        color: ColorUtil.rgba(51, 51, 51, 1),
                        fontSize: 14.sp,
                        fontWeight: FontWeightHelper.semiBold,
                      ),
                    ),
                    TextSpan(
                      text: "对应的助记词或私钥，可以",
                      style: TextStyle(
                        color: ColorUtil.rgba(51, 51, 51, 1),
                        fontSize: 14.sp,
                        fontWeight: FontWeightHelper.regular,
                      ),
                    ),
                    TextSpan(
                      text: "反复输入密码尝试",
                      style: TextStyle(
                        color: ColorUtil.rgba(51, 51, 51, 1),
                        fontSize: 14.sp,
                        fontWeight: FontWeightHelper.semiBold,
                      ),
                    ),
                    TextSpan(
                      text: "，没有次数限制。",
                      style: TextStyle(
                        color: ColorUtil.rgba(51, 51, 51, 1),
                        fontSize: 14.sp,
                        fontWeight: FontWeightHelper.regular,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 44.w),
              child: TRButton(
                text: "我知道了",
                width: 107.w,
                height: 42.w,
                borderRadius: 20,
                onTap: () {
                  Routers.goBack(context);
                },
                border: Border.all(
                  color: ColorUtil.rgba(51, 51, 51, 1),
                ),
                textStyle: TextStyle(
                    color: ColorUtil.rgba(51, 51, 51, 1),
                    fontWeight: FontWeightHelper.regular,
                    fontSize: 16.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
