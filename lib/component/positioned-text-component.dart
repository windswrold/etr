import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PositionedTextComponent extends StatefulWidget {
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
  final double borderRadius;
  final GestureTapCallback? event;
  final TextOverflow? overflow;
  final TextDecoration textDecoration;
  final Gradient? gradient;
  final BoxShadow? shadow;
  const PositionedTextComponent(
      {Key? key,
      this.text,
      this.left,
      this.right,
      this.top,
      this.bottom,
      this.width,
      this.height,
      this.fontWeight = FontWeight.w400,
      this.color,
      this.fontSize,
      this.fontFamily,
      this.event,
      this.backgroundColor,
      this.paddingTop = 0,
      this.textAlign,
      this.marginRight = 0,
      this.marginLeft,
      this.borderRadius = 4,
      this.overflow,
      this.textDecoration = TextDecoration.none,
      this.gradient, this.shadow})
      : super(key: key);

  PositionedTextComponentState createState() => PositionedTextComponentState();
}

class PositionedTextComponentState extends State<PositionedTextComponent> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.left,
      right: widget.right,
      top: widget.top,
      bottom: widget.bottom,
      child: GestureDetector(
        child: Container(
          width: widget.width,
          height: widget.height,
          padding: EdgeInsets.only(
            top: widget.paddingTop,
          ),
          margin: EdgeInsets.only(right: widget.marginRight),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              color: widget.backgroundColor,
              gradient: widget.gradient,
              boxShadow: [
                widget.shadow==null?BoxShadow(color: Color.fromRGBO(0,0,0, 0.0)):widget.shadow!,
              ]),
          child: Text(
            widget.text!,
            textAlign: widget.textAlign,
            overflow: widget.overflow,
            style: TextStyle(
                fontSize: widget.fontSize,
                decoration: widget.textDecoration,
                fontWeight: widget.fontWeight,
                color: widget.color,
                fontFamily: widget.fontFamily),
          ),
        ),
        onTap: widget.event,
      ),
    );
  }
}
