// import 'package:flutter/material.dart';

import '../public.dart';

class Textarea extends StatefulWidget {
  final String? labelText;
  final FormFieldValidator<String>? validate;
  final TextEditingController? controller;
  const Textarea({Key? key, this.labelText, this.validate, this.controller}) : super(key: key);

  TextareaState createState() => TextareaState();

}

class TextareaState extends State<Textarea> {
  OutlineInputBorder _outlineInputBorder = OutlineInputBorder(
    gapPadding: 0,
    borderSide: BorderSide(
      color: Colors.grey[200]!,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 40.w,
      top: 140.h,
      right: 40.w,
      child: Container(
        width: double.infinity,
        height: 184.w,
        child: TextFormField(
          maxLines: 10,
          autovalidate: true,
          controller: widget.controller,
          validator: widget.validate,
          decoration: InputDecoration(
            fillColor: Color(0xffF8F8FC),
            filled: true,
            border: InputBorder.none,
            hintText: widget.labelText,
            hintStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xffC0C0C0),
                fontFamily: "PingFangSC"),
            contentPadding: EdgeInsets.all(16),
            //内容内边距，影响高度
            focusedBorder: _outlineInputBorder,
            enabledBorder: _outlineInputBorder,
            disabledBorder: _outlineInputBorder,
            focusedErrorBorder: _outlineInputBorder,
            errorBorder: _outlineInputBorder,
          ),
        ),
      ),
    );
  }
}