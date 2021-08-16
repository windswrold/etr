import 'package:flutter/material.dart';

class PositionedImg extends StatelessWidget {
  final double? left;
  final double? right;
  final double? top;
  final double? bottom;
  final double? width;
  final double? height;
  final String? src;
  final GestureTapCallback? event;
  //1 是 0 否
  final bool isNetwork;

  const PositionedImg(
      {Key? key,
      this.left,
      this.right,
      this.top,
      this.width,
      this.height,
      this.src,
      this.isNetwork = true,
      this.bottom, this.event})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      child: GestureDetector(
          child: Container(
              width: width,
              height: height,
              decoration: ShapeDecoration(
                  image: DecorationImage(
                      image: (isNetwork ? NetworkImage(src!) : AssetImage(src!)) as ImageProvider<Object>,
                      fit: BoxFit.cover),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.circular(width!))))
              ,onTap: event,
      ),
    );
  }
}
