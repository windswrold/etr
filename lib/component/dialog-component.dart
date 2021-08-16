import 'package:etrflying/component/positioned-text-component.dart';
import 'package:flutter/material.dart';
class DialogComponent extends StatefulWidget {
  final String? tipsIconSrc;
  final String? closeIconSrc;
  final Widget? to;
  final String? content;
  final String? buttonText;

  const DialogComponent({Key? key, this.tipsIconSrc, this.closeIconSrc, this.to, this.content, this.buttonText}) : super(key: key);
  @override
  _DialogComponentState createState() => _DialogComponentState();
}

class _DialogComponentState extends State<DialogComponent> {
  @override
  Widget build(BuildContext context) {
    return new SimpleDialog(
      children: <Widget>[
        Container(
          width: 299,
          height: 259,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(120)),
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 122,
                right: 122,
                top: 38,
                child: Container(
                  width: 56,
                  height: 57,
                  alignment: Alignment.center,
                  child: Image.asset(widget.tipsIconSrc!
                      ),
                ),
              ),
              Positioned(
                  right: 16,
                  top: 17,
                  child: Container(
                    width: 24,
                    height: 24,
                    child: Image.asset(widget.closeIconSrc!
                        ),
                  )),
              PositionedTextComponent(
                left: 0,
                right: 0,
                width: double.infinity,
                top: 111,
                textAlign: TextAlign.center,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xff333333),
                text: widget.content,
              ),
              PositionedTextComponent(
                left: 55,
                right: 55,
                bottom: 40,
                width: double.infinity,
                height: 39,
                color: Colors.white,
                textAlign: TextAlign.center,
                paddingTop: 10,
                borderRadius: 20,
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xffcba5ff),
                      Color(0xff9c6cff)
                    ]),
                text: widget.buttonText,
                event: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => widget.to!));
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
