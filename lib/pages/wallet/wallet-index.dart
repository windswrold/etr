import 'package:etrflying/component/WalletCoinOption.dart';
import 'package:etrflying/component/custom_dialog.dart';
import 'package:etrflying/component/custom_pageview.dart';
import 'package:etrflying/component/custom_refresher.dart';
import 'package:etrflying/component/dialog-component.dart';
import 'package:etrflying/component/positioned-text-component.dart';
import 'package:etrflying/component/wallet-button-component.dart';
import 'package:etrflying/model/collection_tokens.dart';
import 'package:etrflying/model/tr_wallet.dart';
import 'package:etrflying/pages/immortal_auth/upload-img.dart';
import 'package:etrflying/pages/scan/scan.dart';
import 'package:etrflying/pages/transfer/choose-coin.dart';
import 'package:etrflying/pages/transfer/payment.dart';
import 'package:etrflying/pages/transfer/trans_list.dart';
import 'package:etrflying/pages/wallet/receive.dart';
import 'package:etrflying/state/wallet_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../public.dart';
import 'package:scan/scan.dart';

import 'Inputpassword.dart';

class WalletIndex extends StatefulWidget {
  @override
  _WalletIndexState createState() => _WalletIndexState();
}

class _WalletIndexState extends State<WalletIndex> {
  final String path = "assets/img/wallet";
  bool so = true;
  ScanController controller = ScanController();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<CurrentChooseWalletState>(context, listen: false).loadWallet();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.pause();
  }

  void _tapBack() {
    Routers.push(
        context,
        InputPassword(
          inputType: InputPasswordType.authWallet,
        ));
  }

  void _scan() async {
    if ((await getBackupState() == false) &&
        Provider.of<CurrentChooseWalletState>(context, listen: false)
                .isNeedAuth() ==
            KAccountState.init) {
      showBackUpAlertView(
          context: context, cancelPressed: () {}, confirmPressed: () {});
      return;
    }
    Routers.push(context, ScanCodePage(onCapture: (String data) {
      List value = data.split("&");
      Routers.push(
          context,
          PaymentAmount(
              address: value[0],
              contract: value.length > 1 ? value[1] : null,
              decimal: value.length > 1 ? int.tryParse(value[2]) : null));
    }));
  }

  void _receive() async {
    if ((await getBackupState() == false) &&
        Provider.of<CurrentChooseWalletState>(context, listen: false)
                .isNeedAuth() ==
            KAccountState.init) {
      showBackUpAlertView(
          context: context, cancelPressed: () {}, confirmPressed: () {});
      return;
    }
    Routers.push(
        context,
        ChooseCoin(
          type: 1,
        ));
  }

  void _payment() async {
    if ((await getBackupState() == false) &&
        Provider.of<CurrentChooseWalletState>(context, listen: false)
                .isNeedAuth() ==
            KAccountState.init) {
      showBackUpAlertView(
          context: context, cancelPressed: () {}, confirmPressed: () {});
      return;
    }

    Routers.push(context, ChooseCoin(type: 0));
  }

  void _tapCell(int index) async {
    if ((await getBackupState() == false) &&
        Provider.of<CurrentChooseWalletState>(context, listen: false)
                .isNeedAuth() ==
            KAccountState.init) {
      showBackUpAlertView(
          context: context, cancelPressed: () {}, confirmPressed: () {});
      return;
    }
    Provider.of<CurrentChooseWalletState>(context, listen: false)
        .updateTokenIndex(index);
    Routers.push(context, TransListPage());
  }

  Widget _buildCell(MCollectionTokens token, int index) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _tapCell(index);
        },
        child: Container(
            margin: EdgeInsets.only(
              left: 14.w,
              right: 14.w,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: WalletCoinOption(
                imgSrc: path + "/icon_${token.coinType}.png",
                text: token.token,
                amount: token.balanceString,
                top: 0)));
  }

  @override
  Widget build(BuildContext context) {
    List<MCollectionTokens> datas =
        Provider.of<CurrentChooseWalletState>(context).collectionTokens;
    bool isAuth = Provider.of<CurrentChooseWalletState>(context).isNeedAuth() ==
        KAccountState.init;
    String totalSymbolAssets =
        Provider.of<CurrentChooseWalletState>(context).totalSymbolAssets;

    return CustomPageView(
      safeAreaTop: false,
      hiddenAppBar: true,
      hiddenScrollView: true,
      hiddenLeading: true,
      backgroundColor: ColorUtil.rgba(248, 248, 252, 1),
      child: CustomRefresher(
        refreshController: refreshController,
        onRefresh: () {
          Future.delayed(Duration(seconds: 3)).then((value) => {
                refreshController.loadComplete(),
                refreshController.refreshCompleted(resetFooterState: true),
              });
          Provider.of<CurrentChooseWalletState>(context, listen: false)
              .requestAssets(true);
        },
        enableFooter: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: isAuth,
              child: Container(
                margin: EdgeInsets.fromLTRB(14.w, 12.w, 14.w, 12.w),
                padding: EdgeInsets.fromLTRB(14.w, 11.w, 14.w, 11.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: ColorUtil.rgba(241, 241, 241, 1)),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                            decoration: BoxDecoration(
                                color: ColorUtil.rgba(150, 98, 255, 0.21),
                                borderRadius: BorderRadius.circular(2)),
                            child: Text(
                              "信息完善提醒",
                              style: TextStyle(
                                  color: ColorUtil.rgba(69, 0, 135, 1),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeightHelper.regular),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 5, 26.w, 0),
                            child: Text(
                              "你还没有备份身份，备份后享受更多权益！",
                              style: TextStyle(
                                  color: ColorUtil.rgba(51, 51, 51, 1),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeightHelper.regular),
                            ),
                          ),
                        ],
                      ),
                    ),
                    TRButton(
                      text: "去备份",
                      bgc: Color(0xff9C6CFF),
                      height: 28.w,
                      borderRadius: 20,
                      onTap: _tapBack,
                      padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                      textStyle: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Positioned(
                      top: 0.h,
                      height: 222.w,
                      child: LoadAssetsImage(
                        "wallet/up-background-icon.png",
                        fit: BoxFit.cover,
                      )),
                  Positioned(
                    child: Container(
                      margin:
                          EdgeInsets.only(top: 86.w, left: 14.w, right: 14.w),
                      width: double.infinity,
                      height: 170.w,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 8),
                                blurRadius: 20,
                                color: Color.fromRGBO(156, 108, 255, 0.14)),
                          ]),
                      child: Column(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(top: 23.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "我的资产",
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Color(0xff999999),
                                        fontWeight: FontWeightHelper.regular),
                                  ),
                                  8.rowOffset(),
                                  Container(
                                      width: 20,
                                      height: 20,
                                      child: GestureDetector(
                                        child: Image.asset(
                                          so
                                              ? path + "/so-icon.png"
                                              : path + "/no-so-icon.png",
                                          fit: BoxFit.cover,
                                        ),
                                        onTap: () {
                                          setState(() {
                                            so = !so;
                                          });
                                        },
                                      )),
                                ],
                              )),
                          Padding(
                            padding: EdgeInsets.only(top: 12.w),
                            child: Text(
                              so ? totalSymbolAssets : "********",
                              style: TextStyle(
                                  fontSize: 30.sp,
                                  color: Color(0xff333333),
                                  fontWeight: FontWeightHelper.bold),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(top: 32.w),
                            height: 34,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                WalletButtonComponent(
                                  text: "转账",
                                  imgSrc: path + "/transfer-icon.png",
                                  event: () {
                                    _payment();
                                  },
                                ),
                                WalletButtonComponent(
                                  text: "收款",
                                  imgSrc: path + "/collection-icon.png",
                                  event: _receive,
                                ),
                                WalletButtonComponent(
                                    text: "扫一扫",
                                    imgSrc: path + "/scan-icon.png",
                                    event: _scan),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 14.w, top: 32.h),
              child: Text(
                "资产",
                style: TextStyle(
                    fontSize: 16.sp,
                    color: Color(0xff333333),
                    fontWeight: FontWeightHelper.regular),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: datas.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildCell(datas[index], index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
