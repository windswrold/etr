import 'dart:typed_data';

import 'package:etrflying/component/custom_image.dart';
import 'package:etrflying/component/custom_pageview.dart';
import 'package:etrflying/component/custom_toast.dart';
import 'package:etrflying/model/collection_tokens.dart';
import 'package:etrflying/model/tr_wallet.dart';
import 'package:etrflying/state/wallet_state.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:ui' as ui;
import '../../public.dart';

class ReceiveAddress extends StatefulWidget {
  ReceiveAddress({Key? key}) : super(key: key);

  @override
  _ReceiveAddressState createState() => _ReceiveAddressState();
}

class _ReceiveAddressState extends State<ReceiveAddress> {
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MCollectionTokens tokens =
        Provider.of<CurrentChooseWalletState>(context).chooseTokens!;
    String token = tokens.token!;
    final addresss = tokens.owner;
    String qrcodeString = addresss!;
    if (tokens.isToken == true) {
      qrcodeString += "&" + tokens.contract!;
      qrcodeString += "&" + tokens.decimals.toString();
    }
    return CustomPageView(
      backgroundColor: ColorUtil.rgba(255, 179, 8, 1),
      title: CustomPageView.getTitle(
        title: "二维码收款",
        color: 0xffffffff,
      ),
      child: Screenshot(
        controller: screenshotController,
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 57.h, left: 26.w, right: 26.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          height: 427.w,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 30.w),
                child: Text(
                  "扫一扫向我支付$token",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeightHelper.regular,
                    color: ColorUtil.rgba(153, 153, 153, 1),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 30.w,
                ),
                child: QrImage(
                  data: qrcodeString,
                  size: 190.w,
                  backgroundColor: Colors.white,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.w, left: 14.w, right: 14.w),
                height: 1,
                color: ColorUtil.rgba(195, 196, 206, 0.2),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  if (addresss == null) return;
                  Clipboard.setData(ClipboardData(text: addresss));
                  HWToast.showText(text: "复制成功");
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 24.w, left: 54.w, right: 54.w),
                  child: RichText(
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: addresss,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp),
                      children: [
                        WidgetSpan(
                          child: LoadAssetsImage(
                            "fill_info//copy-icon.png",
                            scale: 2,
                            fit: null,
                            width: 14,
                            height: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              TRButton(
                padding: EdgeInsets.only(top: 30.w),
                onTap: () async {
                  final directory = (await getApplicationDocumentsDirectory())
                      .path; //from path_provide package
                  String fileName =
                      DateTime.now().microsecondsSinceEpoch.toString() + ".png";
                  screenshotController
                      .captureAndSave(directory, fileName: fileName)
                      .then((value) => {
                            Share.shareFiles([value!])
                          });
                },
                text: "保存收款码",
                textStyle: TextStyle(
                  color: ColorUtil.rgba(0, 0, 0, 1),
                  fontWeight: FontWeightHelper.medium,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
