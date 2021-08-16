import 'package:etrflying/component/custom_pageview.dart';
import 'package:etrflying/pages/identity/input_account.dart';
import 'package:etrflying/public.dart';
import 'package:etrflying/pages/identity/import_identity.dart';

class BuildIdentity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPageView(
      safeAreaTop: false,
      hiddenScrollView: true,
      hiddenAppBar: true,
      child: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 144.h,
              left: 0,
              right: 0,
              child: Text("享受数字生活",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25.sp,
                      color: ColorUtil.rgba(51, 51, 48, 1),
                      fontWeight: FontWeightHelper.semiBold)),
            ),
            Positioned(
                bottom: 184.h,
                left: 40.w,
                right: 40.w,
                child: TRButton(
                  onTap: () => {
                    Routers.push(context, InputAccount()),
                  },
                  text: "创建身份",
                  height: 43.w,
                  borderRadius: 22,
                  bgc: ColorUtil.rgba(156, 108, 255, 1),
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeightHelper.semiBold,
                  ),
                )),
            Positioned(
                bottom: 117.h,
                left: 40.w,
                right: 40.w,
                child: TRButton(
                  onTap: () => {
                    Routers.push(context, ImportWallet()),
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (BuildContext context) => ImportIdentity()))
                  },
                  text: "导入身份",
                  height: 43.w,
                  borderRadius: 22,
                  border: Border.all(width: 1, color: Color(0xff9C6CFF)),
                  bgc: Colors.white,
                  textStyle: TextStyle(
                    color: ColorUtil.rgba(156, 108, 255, 1),
                    fontSize: 16.sp,
                    fontWeight: FontWeightHelper.semiBold,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
