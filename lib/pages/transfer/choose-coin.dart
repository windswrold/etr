import 'package:etrflying/component/custom_pageview.dart';
import 'package:etrflying/component/positioned-text-component.dart';
import 'package:etrflying/component/router-back.dart';
import 'package:etrflying/model/collection_tokens.dart';
import 'package:etrflying/pages/transfer/payment.dart';
import 'package:etrflying/pages/wallet/receive.dart';
import 'package:etrflying/utils/extension.dart';
import 'package:flutter/material.dart';

import '../../public.dart';

class ChooseCoin extends StatefulWidget {
  final int type;

  const ChooseCoin({Key? key, required this.type}) : super(key: key);
  @override
  _ChooseCoinState createState() => _ChooseCoinState();
}

class _ChooseCoinState extends State<ChooseCoin> {
  void _onTap(int index) {
    Provider.of<CurrentChooseWalletState>(context, listen: false)
        .updateTokenIndex(index);
    if (widget.type == 0) {
      Routers.push(context, PaymentAmount());
    } else {
      Routers.push(context, ReceiveAddress());
    }
  }

  Widget _buildCell(MCollectionTokens token, int index) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        _onTap(index);
      },
      child: Container(
          margin: EdgeInsets.only(left: 14.w, right: 14.w, bottom: 10.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          height: 65.w,
          child: Container(
            padding: EdgeInsets.only(left: 16.w),
            child: Row(
              children: [
                LoadAssetsImage(
                  "wallet/icon_${token.coinType}.png",
                  width: 28.w,
                  height: 28.w,
                ),
                Container(
                  margin: EdgeInsets.only(left: 12.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        token.token ?? "",
                        style: TextStyle(
                            color: ColorUtil.rgba(51, 51, 51, 1),
                            fontSize: 16.sp,
                            fontWeight: FontWeightHelper.medium),
                      ),
                      Visibility(
                        visible:
                            (token.contract ?? "").length == 0 ? false : true,
                        child: Text(
                          (token.contract ?? "").subStringForAddress(),
                          style: TextStyle(
                              color: ColorUtil.rgba(102, 102, 102, 1),
                              fontSize: 14.sp,
                              fontWeight: FontWeightHelper.regular),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<MCollectionTokens> datas =
        Provider.of<CurrentChooseWalletState>(context).collectionTokens;
    return CustomPageView(
      hiddenScrollView: true,
      backgroundColor: ColorUtil.rgba(248, 248, 252, 1),
      title: CustomPageView.getTitle(
        title: "选择币种",
        color: 0xFF333333,
      ),
      child: ListView.builder(
        itemCount: datas.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildCell(datas[index], index);
        },
      ),
    );
  }
}
