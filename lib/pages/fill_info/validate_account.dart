import 'package:etrflying/component/positioned-text-component.dart';
import 'package:etrflying/pages/fill_info/show_qr.dart';
import 'package:flutter/material.dart';

class ValidateAccount extends StatefulWidget {
  @override
  _ValidateAccountState createState() => _ValidateAccountState();
}

class _ValidateAccountState extends State<ValidateAccount> {
  final path = "assets/img/fill_info";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Positioned(
            right: 14,
            top: 59,
            child: Container(
              width: 52,
              height: 24,
              child: Image.asset(path + "/skip-icon.png"),
            ),
          ),
          PositionedTextComponent(
            text: "验证你的账户",
            left: 40,
            top: 106,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color(0xff333333),
          ),
          PositionedTextComponent(
            text: "Token转入你的账户，开启更多权限",
            left: 41,
            top: 146,
            fontSize: 14,
            color: Color(0xff666666),
          ),
          PositionedTextComponent(
            text: "验证",
            fontWeight: FontWeight.bold,
            fontSize: 16,
            bottom: 117,
            left: 40,
            right: 40,
            width: double.infinity,
            height: 43,
            backgroundColor: Color(0xff9C6CFF),
            borderRadius: 22,
            textAlign: TextAlign.center,
            paddingTop: 8,
            color: Colors.white,
            shadow: BoxShadow(
                offset: Offset(0, 6),
                blurRadius: 13,
                color: Color.fromRGBO(156,108,255, 0.19)),
            event: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ShowQr()));
            },
          )
        ],
      ),
    );
  }
}
