import 'package:etrflying/pages/identity/build_identity.dart';
import 'package:flutter/material.dart';

class Index extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var path = "assets/img/index";
    return new Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: new ExactAssetImage(path + '/index-background.png'),
                fit: BoxFit.cover)),
        child: Stack(
          children: [
            Positioned(
                left: 25,
                bottom: 185,
                child: Container(
                  width: 30,
                  height: 34,
                  child: Image.asset(path + '/box-icon.png', fit: BoxFit.cover),
                )),
            Positioned(
                left: 25,
                bottom: 146,
                child: Container(
                  width: 153,
                  height: 30,
                  child: Image.asset(path + '/uncenter-social.png',
                      fit: BoxFit.cover),
                )),
            Positioned(
                left: 25,
                bottom: 123,
                child: Container(
                  width: 122,
                  height: 19,
                  child:
                      Image.asset(path + '/find-icon.png', fit: BoxFit.cover),
                )),
            Positioned(
                bottom: 51,
                left: 25,
                right: 25,
                child: Listener(
                    child: Container(
                      width: double.infinity,
                      height: 43,
                      child: Image.asset(path + '/start-button.png',
                          fit: BoxFit.cover),
                    ),
                    onPointerDown: (event) => {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  BuildIdentity()))
                        })),
          ],
        ));
  }
}
