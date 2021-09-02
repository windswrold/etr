import 'package:etrflying/component/custom_pageview.dart';
import 'package:etrflying/pages/identity/input_account.dart';
import 'package:etrflying/public.dart';
import 'package:etrflying/pages/identity/import_identity.dart';

class BuildIdentity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: CustomPageView(
        safeAreaTop: false,
        hiddenScrollView: true,
        safeAreaBottom: false,
        hiddenAppBar: true,
        hiddenLeading: true,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ASSETS_IMG + "fill_info/launch.png"),
                fit: BoxFit.fill),
          ),
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 420.w,
                child: LoadAssetsImage(
                  "fill_info/intro_bg.png",
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                top: 130.w,
                width: 110.w,
                height: 110.w,
                child: LoadAssetsImage(
                  "fill_info/icon_bg.png",
                  // width: 109.w,
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                top: 263.w,
                left: 0,
                right: 0,
                child: Text("链接未来，遇见美好",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.white,
                        fontWeight: FontWeightHelper.regular)),
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
                    bgc: Colors.white,
                    gradient: null,
                    textStyle: TextStyle(
                      color: ColorUtil.rgba(166, 91, 245, 1),
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
                    },
                    text: "导入身份",
                    height: 43.w,
                    borderRadius: 22,
                    border: Border.all(width: 0.5, color: Colors.white),
                    // bgc: Colors.white,
                    gradient: null,
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeightHelper.semiBold,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
