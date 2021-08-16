import 'package:flutter/material.dart';

class TextComponent extends StatefulWidget {
  final String? text;
  final double? left;
  final double? right;
  final double? top;
  final double? bottom;
  final double? width;
  final double? height;
  final FontWeight fontWeight;
  final Color? color;
  final double? fontSize;
  final String? fontFamily;
  final double paddingTop;
  final double marginRight;
  final double? marginLeft;
  final Color? backgroundColor;
  final TextAlign? textAlign;
  final PointerDownEventListener? event;


  const TextComponent({Key? key, this.text, this.left, this.right, this.top, this.bottom, this.width, this.height, this.fontWeight=FontWeight.w400, this.color, this.fontSize, this.fontFamily, this.event, this.backgroundColor, this.paddingTop=0, this.textAlign, this.marginRight=0, this.marginLeft}) : super(key: key);

  TextComponentState createState()=> TextComponentState();

}
class TextComponentState extends State<TextComponent>{
  @override
  Widget build(BuildContext context) {
    return  Listener(child: Container(
        width: widget.width,
        height: widget.height,
        padding: EdgeInsets.only(top:widget.paddingTop,),
        margin: EdgeInsets.only(right:widget.marginRight),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular((4.0)),color: widget.backgroundColor),
        child: Text(widget.text!,textAlign: widget.textAlign, style: TextStyle(fontSize: widget.fontSize,
            fontWeight: widget.fontWeight,
            color: widget.color,
            fontFamily: widget.fontFamily),),
      ),
      onPointerDown: widget.event);
  }

}