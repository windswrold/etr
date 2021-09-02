import 'package:etrflying/component/dialog-component.dart';
import 'package:etrflying/pages/immortal_auth/upload-img.dart';
import 'package:flutter/cupertino.dart';
import '../public.dart';

showBackUpAlertView({
  required BuildContext context,
  required VoidCallback cancelPressed,
  required VoidCallback confirmPressed,
}) {
  updateBackupState();
  showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            width: 300.w,
            height: 260.w,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: LoadAssetsImage(
                      "home/close-icon.png",
                      width: 24.w,
                      height: 24.w,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: LoadAssetsImage(
                    "home/sorry-icon.png",
                    width: 56.w,
                    height: 56.w,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 17.w, bottom: 50.w),
                  alignment: Alignment.center,
                  child: Text(
                    "您需要先备份身份",
                    style: TextStyle(
                        color: ColorUtil.rgba(51, 51, 51, 1),
                        fontSize: 14.sp,
                        fontWeight: FontWeightHelper.medium),
                  ),
                ),
                TRButton(
                  text: "去备份",
                  borderRadius: 20,
                  onTap: () {
                    Navigator.pop(context);
                    confirmPressed();
                  },
                  width: 190.w,
                  height: 40.w,
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeightHelper.medium),
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xff9c6cff),
                        Color(0xffcba5ff),
                      ]),
                ),
              ],
            ),
          ),
        );
      });
}

showBackWarningAlertView({
  required BuildContext context,
  required VoidCallback cancelPressed,
  required VoidCallback confirmPressed,
}) {
  showDialog(
      context: context,
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              width: 325.w,
              height: 418.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 40.w),
                    child: LoadAssetsImage(
                      "fill_info//no-screenshot-icon.png",
                      width: 75.w,
                      height: 72.w,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 26.w),
                    alignment: Alignment.center,
                    child: Text(
                      "安全提醒",
                      style: TextStyle(
                          color: ColorUtil.rgba(22, 26, 39, 1),
                          fontSize: 17.sp,
                          fontWeight: FontWeightHelper.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 11.w, left: 30.w, right: 30.w),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "为您的资产安全考虑，请勿截屏。",
                      style: TextStyle(
                          color: ColorUtil.rgba(51, 51, 51, 1),
                          fontSize: 14.sp,
                          fontWeight: FontWeightHelper.regular),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 11.w, left: 30.w, right: 30.w),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "截屏存入相册后，有可能同步至云端，导致助记词泄露。",
                      style: TextStyle(
                          color: ColorUtil.rgba(51, 51, 51, 1),
                          fontSize: 14.sp,
                          fontWeight: FontWeightHelper.regular),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: 11.w, left: 30.w, right: 30.w, bottom: 37.w),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "建议您将助记词备份到断网的物理介质上，例如手抄在白纸上，并妥善保存。",
                      style: TextStyle(
                          color: ColorUtil.rgba(51, 51, 51, 1),
                          fontSize: 14.sp,
                          fontWeight: FontWeightHelper.regular),
                    ),
                  ),
                  TRButton(
                    text: "确认",
                    borderRadius: 20,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    width: 152.w,
                    height: 43.w,
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeightHelper.medium),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}

showTransDetailAlertView({
  required BuildContext context,
}) {
  showDialog(
      context: context,
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              width: 325.w,
              height: 364.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.only(left: 35.w, right: 35.w),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 40.w),
                    child: LoadAssetsImage(
                      "fill_info//trans_all.png",
                      width: 75.w,
                      height: 72.w,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20.w),
                    alignment: Alignment.center,
                    child: Text(
                      "转账说明",
                      style: TextStyle(
                          color: ColorUtil.rgba(22, 26, 39, 1),
                          fontSize: 17.sp,
                          fontWeight: FontWeightHelper.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 18.w),
                    alignment: Alignment.center,
                    child: Text(
                      "由于链上转账需要一定的矿工费，因此全部转出后收到的数额是扣除矿工费之后的数额，实际到账会比当前数额少一些。",
                      style: TextStyle(
                          color: ColorUtil.rgba(102, 102, 102, 1),
                          fontSize: 14.sp,
                          fontWeight: FontWeightHelper.bold),
                    ),
                  ),
                  TRButton(
                    text: "确认",
                    borderRadius: 20,
                    margin: EdgeInsets.only(top: 43.w),
                    onTap: () {
                      Navigator.pop(context);
                    },
                    width: 152.w,
                    height: 43.w,
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeightHelper.medium),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
