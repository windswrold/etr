import 'package:etrflying/model/collection_tokens.dart';
import 'package:etrflying/model/tr_wallet.dart';
import 'package:etrflying/model/trans_record.dart';
import 'package:etrflying/net/chain_services.dart';
import 'package:flutter/services.dart';

import '../../public.dart';

class TransDetailParams {
  final String left;
  final String value;
  final bool canCopy;

  TransDetailParams(this.left, this.value, this.canCopy);
}

class TransDetail extends StatefulWidget {
  TransDetail({Key? key, required this.model}) : super(key: key);

  final TransRecordModel model;

  @override
  _TransDetailState createState() => _TransDetailState();
}

class _TransDetailState extends State<TransDetail> {
  @override
  void initState() {
    super.initState();

    initData();
  }

  initData() async {
    TRWallet wallets =
        Provider.of<CurrentChooseWalletState>(context, listen: false)
            .currentWallet;
    String url = "";
    if (wallets.coinType! == KCoinType.ETH.index) {
      url = ethNode.content;
    } else {
      url = bscNode.content;
    }
    dynamic result = await ChainServices.requestEthblockNumber(url);
    if (result is Map && result.containsKey("result")) {
      String numnber = result["result"];
      numnber = numnber.replaceAll("0x", "");
      int currentHeight = int.parse(numnber, radix: 16);
      if (widget.model.blockHeight != null) {
        widget.model.confirmations = currentHeight - widget.model.blockHeight!;
        TransRecordModel.updateTrxList(widget.model);
        setState(() {});
      }
    }
  }

  Widget _buildHeader() {
    MCollectionTokens collectionToken =
        Provider.of<CurrentChooseWalletState>(context).chooseTokens!;
    final currencySymbolStr =
        Provider.of<CurrentChooseWalletState>(context).currencySymbolStr;
    TransRecordModel model = widget.model;
    String value = model.amount!;
    String stateValue = "";
    String asseas = "≈ $currencySymbolStr" +
        ((double.tryParse(value) ?? 0.0) * (collectionToken.price ?? 0.0))
            .toStringAsFixed(2);
    if (model.transType == MTransListType.In.index) {
      value = "+" + value;
      stateValue = "收款";
    } else {
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
    return Container(
      margin: EdgeInsets.only(left: 15.w, top: 10.w, right: 15.w),
      // padding: EdgeInsets.only(left: 15.w, right: 15.w),
      height: 213.w,
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Positioned(
            top: 25.w,
            child: Container(
              height: 188.w,
              width: 350.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 30.w),
                    child: Text(
                      model.token!,
                      style: TextStyle(
                        color: ColorUtil.rgba(51, 51, 51, 1),
                        fontSize: 14.sp,
                        fontWeight: FontWeightHelper.regular,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15.w),
                    child: RichText(
                      text: TextSpan(
                          text: value,
                          style: TextStyle(
                            color: ColorUtil.rgba(51, 51, 51, 1),
                            fontSize: 25.sp,
                            fontWeight: FontWeightHelper.bold,
                          ),
                          children: [
                            TextSpan(
                              text: " " + model.token!,
                              style: TextStyle(
                                color: ColorUtil.rgba(51, 51, 51, 1),
                                fontSize: 14.sp,
                                fontWeight: FontWeightHelper.regular,
                              ),
                            ),
                          ]),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 2.w),
                    child: Text(
                      asseas,
                      style: TextStyle(
                        color: ColorUtil.rgba(153, 153, 153, 1),
                        fontSize: 14.sp,
                        fontWeight: FontWeightHelper.medium,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 18.w),
                    child: Text(
                      stateValue,
                      style: TextStyle(
                        color: stateColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeightHelper.regular,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0.w,
            width: 50,
            height: 50,
            child: LoadAssetsImage(
              "wallet/icon_${collectionToken.coinType}.png",
              width: 50,
              height: 50,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    TransRecordModel _model = widget.model;
    TransDetailParams paramas1 =
        TransDetailParams("矿工费", _model.fee! + _model.token!, false);
    TransDetailParams paramas2 =
        TransDetailParams("付款地址", _model.fromAdd!, true);
    TransDetailParams paramas3 = TransDetailParams("接收地址", _model.toAdd!, true);
    TransDetailParams paramas4 = TransDetailParams("TXID", _model.txid!, true);

    return Container(
      margin: EdgeInsets.only(left: 15.w, top: 20.w, right: 15.w),
      padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 0.w, bottom: 20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          _buildRow(paramas1),
          _buildRow(paramas2),
          _buildRow(paramas3),
          _buildRow(paramas4),
        ],
      ),
    );
  }

  Widget _buildTime() {
    TransRecordModel _model = widget.model;
    TransDetailParams paramas1 = TransDetailParams("时间", _model.date!, false);
    TransDetailParams paramas2 =
        TransDetailParams("备注", _model.remarks!, false);

    return Container(
      margin: EdgeInsets.only(left: 15.w, top: 12.w, right: 15.w),
      padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 0.w, bottom: 20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          _buildRow(paramas1),
          _buildRow(paramas2),
        ],
      ),
    );
  }

  Widget _buildBlockInfo() {
    TransRecordModel _model = widget.model;
    TransDetailParams paramas1 =
        TransDetailParams("区块高度", (_model.blockHeight ?? "").toString(), false);
    int confirmations = _model.confirmations ?? 0;
    TransDetailParams paramas2 = TransDetailParams(
        "确认数", confirmations > 0 ? confirmations.toString() : "", false);

    return Container(
      margin: EdgeInsets.only(left: 15.w, top: 12.w, right: 15.w),
      padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 0.w, bottom: 20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          _buildRow(paramas1),
          _buildRow(paramas2),
        ],
      ),
    );
  }

  Widget _buildRow(TransDetailParams detail) {
    return Container(
      margin: EdgeInsets.only(top: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            detail.left,
            style: TextStyle(
                color: ColorUtil.rgba(51, 51, 51, 1),
                fontSize: 14.sp,
                fontWeight: FontWeightHelper.regular),
          ),
          50.rowOffset(),
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (detail.canCopy) {
                  if (detail.value.isEmpty) return;
                  Clipboard.setData(ClipboardData(text: detail.value));
                  HWToast.showText(text: "复制成功");
                }
              },
              child: RichText(
                  textAlign: TextAlign.right,
                  text: TextSpan(
                      text: detail.value,
                      style: TextStyle(
                          color: ColorUtil.rgba(51, 51, 51, 1),
                          fontSize: 16.sp,
                          fontWeight: FontWeightHelper.bold),
                      children: [
                        WidgetSpan(
                          child: detail.canCopy
                              ? LoadAssetsImage(
                                  "fill_info//copy-icon.png",
                                  scale: 2,
                                  fit: null,
                                  width: 14,
                                  height: 14,
                                )
                              : Container(),
                        ),
                      ])),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomPageView(
      backgroundColor: ColorUtil.rgba(248, 248, 252, 1),
      title: CustomPageView.getTitle(
        title: "转账详情",
      ),
      child: Column(
        children: [
          _buildHeader(),
          _buildContent(),
          _buildTime(),
          _buildBlockInfo(),
        ],
      ),
    );
  }
}
