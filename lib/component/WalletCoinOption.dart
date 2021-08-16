import 'package:etrflying/component/positioned-text-component.dart';
// import 'package:flutter/material.dart';
import '../public.dart';

class WalletCoinOption extends StatefulWidget {
  final String? imgSrc;
  final double? top;
  final String? text;
  final String? amount;
  const WalletCoinOption(
      {Key? key, this.imgSrc, this.top, this.text, this.amount})
      : super(key: key);

  @override
  _WalletCoinOptionState createState() => _WalletCoinOptionState();
}

class _WalletCoinOptionState extends State<WalletCoinOption> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 18.w),
                width: 28.w,
                height: 28.w,
                child: Image.asset(
                  widget.imgSrc!,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 9.w),
                child: Text(
                  widget.text ?? "",
                  style: TextStyle(
                      color: Color(0xff333333),
                      fontWeight: FontWeightHelper.medium,
                      fontSize: 16.sp),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(right: 9.w),
            child: Text(
              widget.amount ?? "0.0",
              style: TextStyle(
                  color: Color(0xff333333),
                  fontWeight: FontWeightHelper.medium,
                  fontSize: 16.sp),
            ),
          ),
        ],
      ),
    );
  }
}
