import 'package:etrflying/pages/setting/changepwd.dart';
import 'package:etrflying/pages/wallet/Inputpassword.dart';

import '../../public.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  void _backWallet() {
    KAccountState isAuth =
        Provider.of<CurrentChooseWalletState>(context, listen: false)
            .isNeedAuth();
    if (isAuth == KAccountState.init) {
      //需要走验证备份流程
      Routers.push(
          context,
          InputPassword(
            inputType: InputPasswordType.authWallet,
          ));
    } else if (isAuth == KAccountState.authed) {
      //直接走备份流程 或者是私钥没有
      Routers.push(
          context,
          InputPassword(
            inputType: InputPasswordType.BackWallet,
          ));
    } else {
      HWToast.showText(text: "私钥导入无需备份");
    }
  }

  void _changePwd() {
    Routers.push(context, ChangePWD());
  }

  void _delWallet() {
    Routers.push(
        context,
        InputPassword(
          inputType: InputPasswordType.DelWallet,
        ));
  }

  Widget _buildRow(String left) {
    return Container(
      color: Colors.white,
      height: 52.w,
      padding: EdgeInsets.only(left: 14.w, right: 14.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            left,
            style: TextStyle(
                color: ColorUtil.rgba(51, 51, 51, 1),
                fontSize: 16.sp,
                fontWeight: FontWeightHelper.regular),
          ),
          LoadAssetsImage(
            "fill_info/icon_arrow.png",
            width: 14,
            height: 14,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomPageView(
      title: CustomPageView.getTitle(title: "设置"),
      backgroundColor: ColorUtil.rgba(248, 248, 252, 1),
      hiddenLeading: true,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 12.w),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                _changePwd();
              },
              child: _buildRow("修改安全密码"),
            ),
          ),
          Visibility(
            visible:
                Provider.of<CurrentChooseWalletState>(context, listen: false)
                        .isNeedAuth() !=
                    KAccountState.noauthed,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                _backWallet();
              },
              child: _buildRow("备份钱包"),
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              _delWallet();
            },
            child: _buildRow("删除钱包"),
          ),
        ],
      ),
    );
  }
}
