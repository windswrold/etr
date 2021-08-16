import 'package:etrflying/component/custom_pageview.dart';
import 'package:etrflying/component/text-component.dart';
import 'package:etrflying/pages/setting/setting.dart';
import 'package:etrflying/pages/tabbar/dynamic.dart';
import 'package:etrflying/pages/wallet/wallet-index.dart';
import 'package:flutter/material.dart';

import '../../public.dart';

class HomeTabbar extends StatefulWidget {
  HomeTabbarState createState() => HomeTabbarState();
}

class HomeTabbarState extends State<HomeTabbar> {
  int currentIndex = 0;

  get items => [
        // BottomNavigationBarItem(
        //     icon: LoadAssetsImage("tabbar/icon_home_normal.png",
        //         width: 24, height: 24),
        //     activeIcon: LoadAssetsImage("tabbar/icon_home_selected.png",
        //         width: 24, height: 24),
        //     label: "社区"),
        // BottomNavigationBarItem(
        //     icon: LoadAssetsImage("tabbar/icon_reco_normal.png",
        //         width: 24, height: 24),
        //     activeIcon: LoadAssetsImage("tabbar/icon_reco_selected.png",
        //         width: 24, height: 24),
        //     label: "推荐"),
        BottomNavigationBarItem(
            icon: LoadAssetsImage("tabbar/icon_wallet_normal.png",
                width: 24, height: 24),
            activeIcon: LoadAssetsImage("tabbar/icon_wallet_selected.png",
                width: 24, height: 24),
            label: "钱包"),
        // BottomNavigationBarItem(
        //     icon: LoadAssetsImage("tabbar/icon_home_normal.png",
        //         width: 24, height: 24),
        //     activeIcon: LoadAssetsImage("tabbar/icon_home_selected.png",
        //         width: 24, height: 24),
        //     label: "浏览"),
        BottomNavigationBarItem(
            icon: LoadAssetsImage("tabbar/icon_mine_normal.png",
                width: 24, height: 24),
            activeIcon: LoadAssetsImage("tabbar/icon_mine_selected.png",
                width: 24, height: 24),
            label: "设置"),
      ];

  List<Widget> bodyList = [WalletIndex(), SettingPage()];

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPageView(
        hiddenScrollView: true,
        hiddenAppBar: true,
        safeAreaTop: false,
        hiddenLeading: true,
        bottomNavigationBar: Theme(
            data: ThemeData(
                splashColor: Color.fromRGBO(0, 0, 0, 0),
                highlightColor: Color.fromRGBO(0, 0, 0, 0)),
            child: BottomNavigationBar(
              items: items,
              currentIndex: currentIndex,
              onTap: onTap,
              elevation: 8,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedItemColor: ColorUtil.rgba(150, 98, 255, 1),
              unselectedItemColor: ColorUtil.rgba(51, 51, 51, 1),
              selectedFontSize: 10,
              unselectedFontSize: 10,
            )),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            IndexedStack(
              index: currentIndex,
              children: bodyList,
            ),
          ],
        ));
  }
}
