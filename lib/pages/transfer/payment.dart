import 'dart:math';

import 'package:etrflying/component/custom_dialog.dart';
import 'package:etrflying/component/custom_textfield.dart';
import 'package:etrflying/model/client/ethclient.dart';
import 'package:etrflying/model/collection_tokens.dart';
import 'package:etrflying/model/node_model.dart';
import 'package:etrflying/model/tr_wallet.dart';
import 'package:etrflying/model/trans_record.dart';
import 'package:etrflying/pages/scan/scan.dart';
import 'package:etrflying/pages/transfer/payment_sheet_page.dart';
import 'package:etrflying/utils/date_util.dart';
import 'package:web3dart/web3dart.dart';
import '../../public.dart';

class PaymentAmount extends StatefulWidget {
  PaymentAmount({Key? key, this.address, this.contract, this.decimal})
      : super(key: key);

  final String? address;
  final String? contract;
  final int? decimal;

  @override
  _PaymentAmountState createState() => _PaymentAmountState();
}

class _PaymentAmountState extends State<PaymentAmount> {
  TextEditingController _addressEC = TextEditingController();
  TextEditingController _valueEC = TextEditingController();
  TextEditingController _remarkEC = TextEditingController();
  TextEditingController _customFeeEC = TextEditingController();
  double? _feeValue = 0.0;
  TRWallet? _wallet;
  int _feeOffset = 20;
  double sliderMin = 20;
  double sliderMax = 300;
  String _bean = "23788";
  ETHClient? _web3Client;
  int _suggestGas = 0;
  double _mainTokenprice = 0.0;

  @override
  void initState() {
    super.initState();
    if (inProduction == false) {
      _addressEC.text = "0x4e268c89495254288b4D1Cb4bc4c010f8C009b25";
    }
    _initData(() {});
  }

  _initData(VoidCallback back) async {
    _wallet = Provider.of<CurrentChooseWalletState>(context, listen: false)
        .currentWallet;
    MCollectionTokens? tokens =
        Provider.of<CurrentChooseWalletState>(context, listen: false)
            .chooseTokens;
    MCurrencyType currencyType =
        Provider.of<CurrentChooseWalletState>(context, listen: false)
            .currencyType;
    assert(_wallet != null, "钱包数据为空");
    if (_wallet == null) return;
    if (tokens!.isToken == true) {
      _bean = "60000";
    }
    if (widget.address != null) {
      _addressEC.text = widget.address!;
    }
    double usdPrice = double.parse(
        Provider.of<CurrentChooseWalletState>(context, listen: false).usdPrice);
    if (_wallet!.coinType! == KCoinType.ETH.index) {
      double ethPrice = double.parse(
          Provider.of<CurrentChooseWalletState>(context, listen: false)
              .ethPrice);
      _mainTokenprice = currencyType == MCurrencyType.CNY
          ? (usdPrice * ethPrice)
          : (ethPrice);
      _web3Client = ETHClient(ethNode.content, ethNode.chainID);
    } else {
      double bnbPrice = double.parse(
          Provider.of<CurrentChooseWalletState>(context, listen: false)
              .bnbPrice);
      _mainTokenprice = currencyType == MCurrencyType.CNY
          ? (usdPrice * bnbPrice)
          : (bnbPrice);
      _web3Client = ETHClient(bscNode.content, bscNode.chainID);
    }
    String newfee = TRWallet.configFeeValue(
        cointype: KCoinType.ETH.index,
        beanValue: _bean.toString(),
        offsetValue: _feeOffset.toString());
    setState(() {
      _feeValue = double.tryParse(newfee);
    });
    EtherAmount gasPricce = await _web3Client!.getGasPrice();
    int gasFee = gasPricce.getValueInUnit(EtherUnit.gwei).toInt();
    int minv = max(sliderMin.toInt(), gasFee);
    gasFee = min(sliderMax.toInt(), minv);
    if (mounted) {
      setState(() {
        _suggestGas = gasFee;
      });
    }
  }

  void _onTapSuggest() {
    String newfee = TRWallet.configFeeValue(
        cointype: KCoinType.ETH.index,
        beanValue: _bean.toString(),
        offsetValue: _suggestGas.toString());
    setState(() {
      _feeOffset = _suggestGas.toInt();
      _feeValue = double.tryParse(newfee);
    });
  }

  ///扫码
  _startScanAddress() async {
    FocusScope.of(context).requestFocus(FocusNode());
    Routers.push(context, ScanCodePage(
      onCapture: (String data) {
        List value = data.split("&");
        if (mounted) {
          setState(() {
            _addressEC.text = value.first;
          });
        }
      },
    ));
  }

  _sliderChange(double value) {
    String newfee = TRWallet.configFeeValue(
        cointype: KCoinType.ETH.index,
        beanValue: _bean.toString(),
        offsetValue: _feeOffset.toString());
    setState(() {
      _feeOffset = value.toInt();
      _feeValue = double.tryParse(newfee);
    });
  }

  void next() {
    FocusScope.of(context).requestFocus(FocusNode());
    TRWallet _wallet =
        Provider.of<CurrentChooseWalletState>(context, listen: false)
            .currentWallet;
    MCollectionTokens tokens =
        Provider.of<CurrentChooseWalletState>(context, listen: false)
            .chooseTokens!;
    MCollectionTokens? mainETH;

    for (var item
        in Provider.of<CurrentChooseWalletState>(context, listen: false)
            .collectionTokens) {
      if (item.token == _wallet.symbol) {
        mainETH = item;
        break;
      }
    }

    String token = tokens.token!;
    bool isToken = tokens.isToken;
    int decimals = tokens.decimals ?? 0;
    String? contract = tokens.contract;
    String to = _addressEC.text.trim();
    String? from = _wallet.walletAaddress;
    String amount = _valueEC.text.trim();
    String gas = "";
    bool? isValid = false;
    final tokenbalance = tokens.balance ?? 0.0;
    if (to.length == 0) {
      HWToast.showText(text: "请输入转账地址");
      return;
    }
    try {
      isValid = EthereumAddress.fromHex(to).hexEip55.length > 0 ? true : false;
    } catch (e) {
      LogUtil.v("校验失败" + e.toString());
    }
    if (isValid == false) {
      HWToast.showText(text: "地址无效");
      return;
    }
    if (amount.length == 0) {
      HWToast.showText(text: "请输入转账金额");
      return;
    }
    if (double.parse(amount) <= 0) {
      HWToast.showText(text: "转账金额不能为0");
      return;
    }

    final ethBalance = mainETH!.balance ?? 0.0;
    BigInt ethBalanceBigNum = ethBalance.toString().tokenInt(18);
    BigInt value = amount.tokenInt(decimals);
    BigInt tokenbalanceBigNum = tokenbalance.toString().tokenInt(decimals);
    String feeValue = _feeValue.toString();
    if (double.parse(feeValue) == 0) {
      HWToast.showText(text: "请调高手续费");
      return;
    }
    if (isToken == true) {
      if (decimals == 0) {
        HWToast.showText(text: "币种精度暂无数据");
        return;
      }
      if (value > tokenbalanceBigNum) {
        HWToast.showText(text: "转账数量需要小于余额");
        return;
      }
      if (feeValue.tokenInt(decimals) > ethBalanceBigNum) {
        HWToast.showText(text: "转账数量需要小于余额");
        return;
      }
    } else {
      if (value > tokenbalanceBigNum) {
        HWToast.showText(text: "转账数量需要小于余额");
        return;
      }
      if (tokenbalanceBigNum == value) {
        value = tokenbalanceBigNum - feeValue.tokenInt(decimals);
      }
      if (feeValue.tokenInt(decimals) + value > tokenbalanceBigNum) {
        HWToast.showText(text: "转账数量需要小于余额");
        return;
      }
    }
    if (value.compareTo(BigInt.zero) <= 0) {
      HWToast.showText(text: "转账金额不能为0");
      return;
    }
    _showSheetView(
        amount: value.tokenString(decimals), fee: feeValue, token: token);
  }

  _showSheetView({String? amount, String? fee, String? token}) async {
    String? from = _wallet!.walletAaddress;
    String to = _addressEC.text.trim();
    String remark = _remarkEC.text.trim();
    //弹出sheet
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        elevation: 0,
        isScrollControlled: true,
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  bottom:
                      MediaQuery.of(context).viewInsets.bottom), // !important
              child: PaymentSheet(
                datas: PaymentSheet.getTransStyleList(
                    from: from,
                    to: to,
                    remark: remark,
                    fee: fee,
                    details: token! + "转账"),
                nextAction: (value) {
                  _startSign(amount!, value);
                },
                amount: amount!,
                token: token,
              ),
            ),
          );
        });
  }

  // /开始签名
  _startSign(String amount, String pin) async {
    HWToast.showLoading(
      clickClose: true,
    );
    String to = _addressEC.text.trim();
    final memo = _remarkEC.text;
    MCollectionTokens tokens =
        Provider.of<CurrentChooseWalletState>(context, listen: false)
            .chooseTokens!;
    final prv = _wallet!.exportPrv(pin: pin);
    final ethSigner = EthPrivateKey.fromHex(prv!);

    try {
      final tx = await _web3Client!.transfer(
          ethSigner,
          tokens,
          amount.tokenInt(tokens.decimals!),
          EthereumAddress.fromHex(to),
          EtherAmount.fromUnitAndValue(EtherUnit.gwei, _feeOffset),
          null,
          memo);
      HWToast.showText(text: "交易成功");
      TransRecordModel model = TransRecordModel();
      model.txid = tx;
      model.amount = amount;
      model.fromAdd = _wallet!.walletAaddress!;
      model.date = DateUtil.getNowDateStr();
      model.token = tokens.token;
      model.coinType = tokens.coinType;
      model.fee = _feeValue.toString();
      model.toAdd = to;
      model.remarks = memo;
      model.transStatus = MTransState.Pending.index;
      model.transType = MTransListType.Out.index;
      model.chainid = _web3Client!.ChainID!;
      TransRecordModel.insertTrxList(model);
      Future.delayed(Duration(seconds: 3))
          .then((value) => {Routers.goBackWithParams(context, {})});
    } catch (e) {
      LogUtil.v("交易失败" + e.toString());
      HWToast.showText(text: "交易失败" + e.toString());
    }
  }

  Widget _widgetTitle(String title) {
    return Text(title,
        style: TextStyle(
          color: ColorUtil.rgba(51, 51, 51, 1),
          fontSize: 16.sp,
          fontWeight: FontWeightHelper.regular,
        ));
  }

  Widget _getFeeWidget() {
    MCollectionTokens? tokens = Provider.of<CurrentChooseWalletState>(
      context,
    ).chooseTokens;
    String amountType =
        Provider.of<CurrentChooseWalletState>(context, listen: false)
            .currencySymbolStr;
    String? coinType = tokens?.coinType;

    Widget _getFeeWidget() {
      return SliderTheme(
        data: SliderTheme.of(context).copyWith(
            activeTrackColor: ColorUtil.rgba(156, 108, 255, 1),
            inactiveTrackColor: ColorUtil.rgba(156, 108, 255, 0.11),
            thumbColor: Colors.white,
            overlayColor: ColorUtil.rgba(156, 108, 255, 1),
            overlayShape: RoundSliderOverlayShape(
              overlayRadius: 18,
            ),
            thumbShape: RoundSliderThumbShape(
              disabledThumbRadius: 10,
              enabledThumbRadius: 10,
            ),
            trackHeight: 6),
        child: Slider(
            value: _feeOffset.toDouble(),
            onChanged: (v) {
              _sliderChange(v);
            },
            max: sliderMax,
            min: sliderMin),
      );
    }

    return Container(
      padding: EdgeInsets.only(top: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 19.w),
            child: Text(
              "$_feeValue " +
                  tokens!.coinType! +
                  "≈$amountType" +
                  ((_feeValue ?? 0.0) * _mainTokenprice).toStringAsFixed(2),
              style: TextStyle(
                color: ColorUtil.rgba(51, 51, 51, 1),
                fontWeight: FontWeightHelper.bold,
                fontSize: 16.sp,
              ),
            ),
          ),
          _getFeeWidget(),
          Container(
            padding: EdgeInsets.only(top: 12.w, bottom: 9.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "慢",
                  style: TextStyle(
                    color: ColorUtil.rgba(153, 153, 153, 1),
                    fontWeight: FontWeightHelper.regular,
                    fontSize: 12.sp,
                  ),
                ),
                Text(
                  "快",
                  style: TextStyle(
                    color: ColorUtil.rgba(153, 153, 153, 1),
                    fontWeight: FontWeightHelper.regular,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  text: "推荐矿工费",
                  style: TextStyle(
                    color: ColorUtil.rgba(102, 102, 102, 1),
                    fontWeight: FontWeightHelper.regular,
                    fontSize: 12.sp,
                  ),
                  children: [
                    TextSpan(
                      text: "(根据区块链网络波动)",
                      style: TextStyle(
                        color: ColorUtil.rgba(153, 153, 153, 1),
                        fontWeight: FontWeightHelper.regular,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  _onTapSuggest();
                },
                child: Visibility(
                  visible: _suggestGas > 0,
                  child: Text(
                    "推荐: $_suggestGas gwei",
                    style: TextStyle(
                      color: ColorUtil.rgba(121, 56, 253, 1),
                      fontWeight: FontWeightHelper.regular,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    MCollectionTokens tokens =
        Provider.of<CurrentChooseWalletState>(context).chooseTokens!;

    return CustomPageView(
      title: CustomPageView.getTitle(
        title: tokens.token! + "转账",
        color: 0xFF333333,
      ),
      actions: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => {
            _startScanAddress(),
          },
          child: Container(
            padding: EdgeInsets.only(right: 15),
            height: 45,
            width: 45,
            alignment: Alignment.centerRight,
            child: LoadAssetsImage(
              "home/icon_blackscan.png",
              width: 24,
              height: 24,
            ),
          ),
        ),
      ],
      hiddenScrollView: true,
      child: Container(
        margin: EdgeInsets.only(left: 14.w, top: 20.h, right: 14.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _widgetTitle("转账金额"),
                CustomTextField(
                  controller: _valueEC,
                  padding: EdgeInsets.only(top: 8.h, bottom: 16.h),
                  style: TextStyle(
                    color: ColorUtil.rgba(153, 153, 153, 1),
                    fontSize: 14.sp,
                    fontWeight: FontWeightHelper.regular,
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    CustomTextField.decimalInputFormatter(tokens.decimals),
                  ],
                  decoration: CustomTextField.getBorderLineDecoration(
                    suffixIcon: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 20,
                            child: Text(
                              "全部转出",
                              style: TextStyle(
                                color: ColorUtil.rgba(121, 56, 253, 1),
                                fontSize: 12.sp,
                                fontWeight: FontWeightHelper.regular,
                              ),
                            ),
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              showTransDetailAlertView(context: context);
                            },
                            child: Container(
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.only(right: 12.w, left: 6.w),
                              height: 11,
                              width: 11,
                              decoration: BoxDecoration(
                                  color: ColorUtil.rgba(192, 192, 192, 1),
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        _valueEC.text = tokens.balance.toString();
                      },
                    ),
                    contentPadding: EdgeInsets.fromLTRB(12, 15, 12, 15),
                    fillColor: ColorUtil.rgba(248, 248, 252, 1),
                    hintText: "余额 " + tokens.balanceString,
                  ),
                ),
                _widgetTitle("收款地址"),
                CustomTextField(
                  padding: EdgeInsets.only(top: 8.h, bottom: 16.h),
                  controller: _addressEC,
                  style: TextStyle(
                    color: ColorUtil.rgba(153, 153, 153, 1),
                    fontSize: 14.sp,
                    fontWeight: FontWeightHelper.regular,
                  ),
                  decoration: CustomTextField.getBorderLineDecoration(
                    hintText: "请输入收款地址",
                    contentPadding: EdgeInsets.fromLTRB(12, 15, 12, 15),
                    fillColor: ColorUtil.rgba(248, 248, 252, 1),
                  ),
                ),
                _widgetTitle("备注"),
                CustomTextField(
                  controller: _remarkEC,
                  padding: EdgeInsets.only(top: 8.h, bottom: 28.h),
                  style: TextStyle(
                    color: ColorUtil.rgba(153, 153, 153, 1),
                    fontSize: 14.sp,
                    fontWeight: FontWeightHelper.regular,
                  ),
                  maxLines: 4,
                  decoration: CustomTextField.getBorderLineDecoration(
                    contentPadding: EdgeInsets.fromLTRB(12, 15, 12, 15),
                    fillColor: ColorUtil.rgba(248, 248, 252, 1),
                  ),
                ),
                _widgetTitle("矿工费"),
                _getFeeWidget(),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 0.h, bottom: 55.h),
              child: TRButton(
                onTap: () {
                  next();
                },
                bgc: Color(0xff9C6CFF),
                borderRadius: 22,
                height: 43.w,
                text: "确定",
                textStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeightHelper.semiBold,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
