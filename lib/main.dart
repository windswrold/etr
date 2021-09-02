import 'package:bot_toast/bot_toast.dart';
import 'package:etrflying/model/node_model.dart';
import 'package:etrflying/model/tr_wallet.dart';
import 'package:etrflying/pages/identity/build_identity.dart';
import 'package:etrflying/pages/index/index.dart';
import 'package:etrflying/pages/tabbar/tabbar.dart';
import 'package:etrflying/state/wallet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //不加这个强制横/竖屏会报错
  SystemChrome.setPreferredOrientations([
    // 强制竖屏
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  Provider.debugCheckInvalidValueType = null;

  runApp(App());
}

class App extends StatefulWidget {
  App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  CurrentChooseWalletState _walletState = CurrentChooseWalletState();
  int state = 0; //0 load  1 create ,2 tabbar
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _walletState.loadWallet();
    getSkip();
  }

  void getSkip() async {
    List<TRWallet> wallets = await TRWallet.findAllWallets();
    if (wallets != null && wallets.length > 0) {
      setState(() {
        state = 2;
      });
    } else {
      setState(() {
        state = 1;
      });
    }
  }

  Widget buildEmptyView() {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(375, 812),
        builder: () => MultiProvider(
                providers: [
                  ChangeNotifierProvider.value(value: _walletState),
                ],
                child: RefreshConfiguration(
                  headerBuilder: () =>
                      WaterDropHeader(), // 配置默认头部指示器,假如你每个页面的头部指示器都一样的话,你需要设置这个
                  footerBuilder: () => ClassicFooter(), // 配置默认底部指示器
                  headerTriggerDistance: 80.0, // 头部触发刷新的越界距离
                  springDescription: SpringDescription(
                      stiffness: 170,
                      damping: 16,
                      mass: 1.9), // 自定义回弹动画,三个属性值意义请查询flutter api
                  maxOverScrollExtent: 100, //头部最大可以拖动的范围,如果发生冲出视图范围区域,请设置这个属性
                  maxUnderScrollExtent: 0, // 底部最大可以拖动的范围
                  enableScrollWhenRefreshCompleted:
                      true, //这个属性不兼容PageView和TabBarView,如果你特别需要TabBarView左右滑动,你需要把它设置为true
                  enableLoadingWhenFailed: true, //在加载失败的状态下,用户仍然可以通过手势上拉来触发加载更多
                  hideFooterWhenNotFull: false, // Viewport不满一屏时,禁用上拉加载更多功能
                  enableBallisticLoad: true,
                  child: MaterialApp(
                    debugShowCheckedModeBanner: false,
                    initialRoute: "/",
                    builder: BotToastInit(),
                    navigatorObservers: [BotToastNavigatorObserver()],
                    routes: {
                      "/": (context) => state == 0
                          ? buildEmptyView()
                          : state == 2
                              ? HomeTabbar()
                              : BuildIdentity(),
                    },
                  ),
                )));
  }
}
