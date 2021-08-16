import 'package:etrflying/component/positioned-text-component.dart';
import 'package:flutter/material.dart';

class WalletButtonComponent extends StatefulWidget {
  final String? imgSrc;
  final String? text;
  final GestureTapCallback? event;

  const WalletButtonComponent({Key? key, this.imgSrc, this.text, this.event})
      : super(key: key);

  @override
  _WalletButtonComponentState createState() => _WalletButtonComponentState();
}

class _WalletButtonComponentState extends State<WalletButtonComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 97,
      height: 34,
      decoration: BoxDecoration(
        color: Color(0xff9C6CFF).withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 20,
              top: 7,
              child: Container(
                width: 20,
                height: 20,
                child: Image.asset(
                  widget.imgSrc!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            PositionedTextComponent(
              text: widget.text,
              fontSize: 14,
              color: Color(0xff905AFF),
              left: 48,
              top: 6,
            ),
          ],
        ),
        onTap: widget.event,
      ),
    );
  }
}
