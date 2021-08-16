import 'package:etrflying/component/positioned-text-component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:toast/toast.dart';
class ShowQr extends StatefulWidget {
  @override
  _ShowQrState createState() => _ShowQrState();
}

class _ShowQrState extends State<ShowQr> {
  final path = "assets/img/fill_info";
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffF8F8FC),
      child: Stack(
        children: <Widget>[
          PositionedTextComponent(
            text: "展示二维码",
            left: 40,
            top: 106,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color(0xff333333),
          ),
          Positioned(
            top: 173,
            left: 40,
            right: 40,
            child: Container(
              width: double.infinity,
              height: 349,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow:[
                  BoxShadow(
                      offset: Offset(0, 11),
                      blurRadius: 20,
                      color: Color.fromRGBO(156,108,255, 0.09))
                ]
              ),
            ),
          ),
          Positioned(
            top:209,
            left: 93,
            right: 92,
            child: Container(
              width: 190,
              height: 190,
              child: Image.asset(path+"/qr-icon.png",fit: BoxFit.fill,),
            ),
          ),
          PositionedTextComponent(
            text: "0x64B7975B63085e25CF98515ccB581Daf098515cc561eE3Fe25CF",
            left: 62,
            right: 62,
            width: double.infinity,
            fontSize: 12,
            color: Color(0xff333333),
            top:456
          ),
          Positioned(
            top:477,
            right: 98,
            child: GestureDetector(child: Container(
              width: 14,
              height: 15,
              child: Image.asset(path+"/copy-icon.png",fit: BoxFit.fill,),
            ),onTap: (){
              Clipboard.setData(ClipboardData(text: '复制的文本'));
              // Toast.show("复制成功!", context, gravity: Toast.CENTER);
            },),
          ),
          PositionedTextComponent(
            text: "完成",
            fontWeight: FontWeight.bold,
            fontSize: 16,
            bottom: 50,
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
