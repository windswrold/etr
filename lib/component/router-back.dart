import 'package:flutter/material.dart';

class BackComponet extends StatelessWidget {
  var path = "assets/img/identity";
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment:Alignment.topLeft,
      child:Container(
        width: 24,
        height: 24,
        margin: EdgeInsets.only(top: 59,left: 14),
        child: Listener(
          child:
          Image.asset(path + "/back-icon.png", fit: BoxFit.cover),
          onPointerDown: (e) => {Navigator.pop(context)},
        )) ,);
  }

}