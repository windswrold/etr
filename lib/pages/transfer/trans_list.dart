import 'package:etrflying/component/custom_emptydata.dart';
import 'package:etrflying/component/custom_refresher.dart';
import 'package:etrflying/model/collection_tokens.dart';
import 'package:etrflying/model/tr_wallet.dart';
import 'package:etrflying/model/trans_record.dart';
import 'package:etrflying/pages/transfer/payment.dart';
import 'package:etrflying/pages/transfer/trans_detail.dart';
import 'package:etrflying/pages/wallet/receive.dart';
import 'package:etrflying/utils/timer_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../public.dart';

class TransListPage extends StatefulWidget {
  TransListPage({Key? key}) : super(key: key);

  @override
  _TransListPageState createState() => _TransListPageState();
}

class _TransListPageState extends State<TransListPage> {
  double _fontWidth = 33.w;
  double _fontSpace = 25.w;
  double x = 0;
  MTransListType _mTransListType = MTransListType.All;
  List<TransRecordModel> _datas = [];
  TimerUtil? timer;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initData();
    queryTrxList(MTransListType.All);
  }

  void _initData() async {
    TRWallet wallets =
        Provider.of<CurrentChooseWalletState>(context, listen: false)
            .currentWallet;
    String walletAddress = wallets.walletAaddress!;
    MCollectionTokens tokens =
        Provider.of<CurrentChooseWalletState>(context, listen: false)
            .chooseTokens!;
    int chainID = -1;
    if (wallets.coinType! == KCoinType.ETH.index) {
      chainID = ethNode.chainID;
    } else {
      chainID = bscNode.chainID;
    }
    if (timer == null) {
      timer = TimerUtil(mInterval: 10000);
      timer!.setOnTimerTickCallback((millisUntilFinished) async {
        List<TransRecordModel> pendingDB =
            await TransRecordModel.queryPendingTrxList(
                walletAddress, tokens.token!, chainID);
        if (pendingDB.length == 0) {
          timer!.cancel();
          return;
        }
        for (var item in pendingDB) {
          if (mounted) {
            dynamic result = await item.updateTransState(context);
            queryTrxList(_mTransListType);
          }
        }
      });
    }
    if (timer?.isActive() == false) {
      timer?.startTimer();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();
  }

  void queryTrxList(MTransListType type) async {
    MCollectionTokens tokens =
        Provider.of<CurrentChooseWalletState>(context, listen: false)
            .chooseTokens!;
    TRWallet _wallet =
        Provider.of<CurrentChooseWalletState>(context, listen: false)
            .currentWallet;

    int chainID = -1;
    if (_wallet.coinType! == KCoinType.ETH.index) {
      chainID = ethNode.chainID;
    } else {
      chainID = bscNode.chainID;
    }
    List<TransRecordModel> datas = await TransRecordModel.queryTrxList(
        _wallet.walletAaddress!, tokens.token!, chainID, type.index);
    setState(() {
      _datas = datas;
    });
    if (timer?.isActive() == false) {
      timer?.startTimer();
    }
  }

  void _changeListType(MTransListType type) {
    setState(() {
      _mTransListType = type;
      x = type.index * (_fontWidth + _fontSpace);
    });
    queryTrxList(type);
  }

  Widget _balanceWidget() {
    MCollectionTokens token =
        Provider.of<CurrentChooseWalletState>(context).chooseTokens!;
    return Container(
      margin: EdgeInsets.fromLTRB(14.w, 12.w, 14.w, 0),
      height: 56.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              LoadAssetsImage(
                "wallet/icon_${token.coinType}.png",
                width: 28,
                height: 28,
              ),
              8.rowOffset(),
              Text(
                token.token!,
                style: TextStyle(
                  color: ColorUtil.rgba(51, 51, 51, 1),
                  fontWeight: FontWeightHelper.regular,
                  fontSize: 16.sp,
                ),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                token.balanceString,
                style: TextStyle(
                  color: ColorUtil.rgba(51, 51, 51, 1),
                  fontWeight: FontWeightHelper.regular,
                  fontSize: 16.sp,
                ),
              ),
              3.columnOffset(),
              Text(
                "≈" + token.assets,
                style: TextStyle(
                  color: ColorUtil.rgba(102, 102, 102, 1),
                  fontWeight: FontWeightHelper.regular,
                  fontSize: 12.sp,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _receivePayment() {
    MCollectionTokens token =
        Provider.of<CurrentChooseWalletState>(context).chooseTokens!;
    return Container(
      margin: EdgeInsets.fromLTRB(14.w, 0.w, 14.w, 0),
      height: 60.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TRButton(
              text: "转帐",
              height: 33.w,
              onTap: () {
                Routers.push(context, PaymentAmount()).then((value) => {
                      queryTrxList(_mTransListType),
                    });
              },
              borderRadius: 6,
              bgc: ColorUtil.rgba(156, 108, 255, 0.1),
              gradient: null,
              textStyle: TextStyle(
                color: ColorUtil.rgba(144, 90, 255, 1),
                fontWeight: FontWeightHelper.medium,
                fontSize: 14.sp,
              ),
            ),
          ),
          13.rowOffset(),
          Expanded(
            child: TRButton(
              text: "收款",
              height: 33.w,
              onTap: () {
                Routers.push(context, ReceiveAddress());
              },
              borderRadius: 6,
              gradient: null,
              bgc: ColorUtil.rgba(156, 108, 255, 0.1),
              textStyle: TextStyle(
                color: ColorUtil.rgba(144, 90, 255, 1),
                fontWeight: FontWeightHelper.medium,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _transType() {
    Color selectColor = ColorUtil.rgba(51, 51, 51, 1);
    Color normalColor = ColorUtil.rgba(153, 153, 153, 1);

    return Column(
      children: [
        Container(
          height: 44.w,
          margin: EdgeInsets.fromLTRB(14.w, 0.w, 14.w, 0),
          alignment: Alignment.centerLeft,
          child: Wrap(
            alignment: WrapAlignment.start,
            spacing: _fontSpace,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  _changeListType(MTransListType.All);
                },
                child: Container(
                  width: _fontWidth,
                  alignment: Alignment.center,
                  child: Text(
                    "全部",
                    style: TextStyle(
                      color: _mTransListType == MTransListType.All
                          ? selectColor
                          : normalColor,
                      fontWeight: FontWeightHelper.regular,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  _changeListType(MTransListType.Out);
                },
                child: Container(
                  width: _fontWidth,
                  alignment: Alignment.center,
                  child: Text(
                    "转出",
                    style: TextStyle(
                      color: _mTransListType == MTransListType.Out
                          ? selectColor
                          : normalColor,
                      fontWeight: FontWeightHelper.regular,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  _changeListType(MTransListType.In);
                },
                child: Container(
                  width: _fontWidth,
                  alignment: Alignment.center,
                  child: Text(
                    "转入",
                    style: TextStyle(
                      color: _mTransListType == MTransListType.In
                          ? selectColor
                          : normalColor,
                      fontWeight: FontWeightHelper.regular,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  _changeListType(MTransListType.Failere);
                },
                child: Container(
                  width: _fontWidth,
                  alignment: Alignment.center,
                  child: Text(
                    "失败",
                    style: TextStyle(
                      color: _mTransListType == MTransListType.Failere
                          ? selectColor
                          : normalColor,
                      fontWeight: FontWeightHelper.regular,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 1,
          margin: EdgeInsets.fromLTRB(14.w, 0.w, 14.w, 0),
          alignment: Alignment.centerLeft,
          //
          child: Transform.translate(
            offset: Offset(x, 0),
            child: Container(
              color: ColorUtil.rgba(51, 51, 51, 1),
              height: 1,
              width: _fontWidth,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCell(int index) {
    TransRecordModel model = _datas[index];
    String img = "";
    String value = model.amount!;
    String stateValue = "";
    if (model.transType == MTransListType.In.index) {
      img = "home/trans_in.png";
      value = "+" + value;
      stateValue = "收款";
    } else {
      img = "home/trans_out.png";
      value = "-" + value;
      stateValue = "转账";
    }
    Color stateColor;
    if (model.transStatus == MTransState.Success.index) {
      stateColor = ColorUtil.rgba(153, 153, 153, 1);
      stateValue += "成功";
    } else if (model.transStatus == MTransState.Pending.index) {
      stateColor = ColorUtil.rgba(248, 106, 14, 1);
      stateValue += "中";
    } else {
      stateColor = ColorUtil.rgba(255, 77, 79, 1);
      stateValue = "转账失败";
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Routers.push(
            context,
            TransDetail(
              model: model,
            ));
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(14.w, 28.w, 14.w, 0.w),
        child: Row(
          children: [
            LoadAssetsImage(
              img,
              width: 24,
              height: 24,
            ),
            12.rowOffset(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        model.txid!.subStringForAddress(),
                        style: TextStyle(
                            color: ColorUtil.rgba(51, 51, 51, 1),
                            fontSize: 14.sp,
                            fontWeight: FontWeightHelper.regular),
                      ),
                      Text(
                        value,
                        style: TextStyle(
                            color: ColorUtil.rgba(51, 51, 51, 1),
                            fontSize: 16.sp,
                            fontWeight: FontWeightHelper.bold),
                      ),
                    ],
                  ),
                  7.columnOffset(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        model.date!,
                        style: TextStyle(
                            color: ColorUtil.rgba(192, 192, 192, 1),
                            fontSize: 12.sp,
                            fontWeight: FontWeightHelper.regular),
                      ),
                      Text(
                        stateValue,
                        style: TextStyle(
                            color: stateColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeightHelper.regular),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    MCollectionTokens tokens =
        Provider.of<CurrentChooseWalletState>(context).chooseTokens!;
    return CustomPageView(
        title: CustomPageView.getTitle(title: tokens.token!),
        hiddenScrollView: true,
        child: Column(
          children: [
            _balanceWidget(),
            _receivePayment(),
            Container(
              height: 10.w,
              color: ColorUtil.rgba(248, 248, 252, 1),
            ),
            _transType(),
            Expanded(
              child: _datas.length == 0
                  ? EmptyDataPage()
                  : CustomRefresher(
                      refreshController: refreshController,
                      onRefresh: () {
                        Future.delayed(Duration(seconds: 3)).then((value) => {
                              refreshController.loadComplete(),
                              refreshController.refreshCompleted(
                                  resetFooterState: true),
                            });

                        queryTrxList(_mTransListType);
                      },
                      enableFooter: false,
                      child: ListView.builder(
                        itemCount: _datas.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _buildCell(index);
                        },
                      ),
                    ),
            )
          ],
        ));
  }
}
