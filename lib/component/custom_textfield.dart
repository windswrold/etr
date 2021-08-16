import 'package:flutter/services.dart';

import '../public.dart';

class RegExInputFormatter implements TextInputFormatter {
  final RegExp _regExp;

  RegExInputFormatter._(this._regExp);

  factory RegExInputFormatter.withRegex(String regexString) {
    try {
      final regex = RegExp(regexString);
      return RegExInputFormatter._(regex);
    } catch (e) {
      assert(false, e.toString());
      return RegExInputFormatter._(RegExp(""));
    }
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final oldValueValid = _isValid(oldValue.text);
    final newValueValid = _isValid(newValue.text);
    if (oldValueValid && !newValueValid) {
      return oldValue;
    }
    return newValue;
  }

  bool _isValid(String value) {
    try {
      final matches = _regExp.allMatches(value);
      for (Match match in matches) {
        if (match.start == 0 && match.end == value.length) {
          return true;
        }
      }
      return false;
    } catch (e) {
      // Invalid regex
      assert(false, e.toString());
      return true;
    }
  }
}

class CustomTextField extends StatefulWidget {
  CustomTextField({
    Key? key,
    this.padding,
    this.maxLines = 1,
    this.obscureText = false,
    this.onSubmitted,
    required this.controller,
    this.decoration,
    this.style,
    this.maxLength,
    this.onChange,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.autofocus = false,
  }) : super(key: key);

  final EdgeInsetsGeometry? padding;
  final TextEditingController? controller;
  int maxLines;
  final bool obscureText;
  final ValueChanged<String>? onSubmitted;
  InputDecoration? decoration;
  final TextStyle? style;
  final int? maxLength;
  final ValueChanged<String>? onChange;
  final bool enabled;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool autofocus;

  static TextInputFormatter decimalInputFormatter(int? decimals) {
    String amount = '^[0-9]{0,}(\\.[0-9]{0,$decimals})?\$';
    return RegExInputFormatter.withRegex(amount);
  }

  static InputDecoration getUnderLineDecoration({
    String? hintText,
    TextStyle? hintStyle,
    String? helperText,
    TextStyle? helperStyle,
    Widget? prefixIcon,
    Widget? suffixIcon,
    BoxConstraints suffixIconConstraints =
        const BoxConstraints(maxWidth: 100, maxHeight: double.infinity),
    BoxConstraints prefixIconConstraints =
        const BoxConstraints(minWidth: 80, maxHeight: double.infinity),
    double underLineWidth = 1,
    Color fillColor = Colors.white,
    EdgeInsetsGeometry contentPadding = EdgeInsets.zero,
  }) {
    return InputDecoration(
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      suffixIconConstraints: suffixIconConstraints,
      prefixIconConstraints: prefixIconConstraints,
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          width: underLineWidth,
          color: ColorUtil.rgba(51, 51, 51, 1),
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          width: underLineWidth,
          color: ColorUtil.rgba(51, 51, 51, 1),
        ),
      ),
      counterText: "",
      hintText: hintText,
      hintStyle: hintStyle,
      helperText: helperText,
      helperStyle: helperStyle,
      helperMaxLines: 5,
      fillColor: fillColor,
      filled: true,
      contentPadding: contentPadding,
    );
  }

  static InputDecoration getBorderLineDecoration({
    String? hintText,
    TextStyle? hintStyle,
    String? helperText,
    TextStyle? helperStyle,
    Color fillColor = Colors.white,
    EdgeInsetsGeometry contentPadding = const EdgeInsets.fromLTRB(18, 0, 18, 0),
    double borderRadius = 6,
    Widget? prefixIcon,
    Widget? suffixIcon,
    String? counterText,
    TextStyle? counterStyle,
    BoxConstraints suffixIconConstraints =
        const BoxConstraints(maxWidth: 100, maxHeight: double.infinity),
    BoxConstraints prefixIconConstraints =
        const BoxConstraints(minWidth: 80, maxHeight: double.infinity),
  }) {
    return InputDecoration(
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      suffixIconConstraints: suffixIconConstraints,
      prefixIconConstraints: prefixIconConstraints,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: ColorUtil.rgba(248, 248, 252, 1)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: ColorUtil.rgba(248, 248, 252, 1)),
      ),
      hintText: hintText,
      hintStyle: TextStyle(
          color: ColorUtil.rgba(192, 192, 192, 1),
          fontWeight: FontWeightHelper.regular,
          fontSize: 14.sp),
      helperText: helperText,
      helperStyle: TextStyle(
          // color: ColorUtils.rgba(153, 153, 153, 1),
          // fontWeight: FontWightHelper.regular,
          // fontSize: OffsetWidget.setSp(14),
          ),
      helperMaxLines: 5,
      fillColor: fillColor,
      filled: true,
      contentPadding: contentPadding,
      counterText: counterText,
      counterStyle: counterStyle,
    );
  }

  static InputDecoration getNormalDecoration({
    String? hintText,
    TextStyle? hintStyle,
    String? helperText,
    TextStyle? helperStyle,
    Color fillColor = Colors.white,
    EdgeInsetsGeometry contentPadding = const EdgeInsets.fromLTRB(18, 0, 18, 0),
    double borderRadius = 6,
    Widget? prefixIcon,
    Widget? suffixIcon,
    String? counterText,
    TextStyle? counterStyle,
    BoxConstraints suffixIconConstraints =
        const BoxConstraints(maxWidth: 100, maxHeight: double.infinity),
    BoxConstraints prefixIconConstraints =
        const BoxConstraints(minWidth: 80, maxHeight: double.infinity),
  }) {
    return InputDecoration(
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      hintText: hintText,
      hintStyle: TextStyle(
          color: ColorUtil.rgba(192, 192, 192, 1),
          fontWeight: FontWeightHelper.regular,
          fontSize: 14.sp),
      helperText: helperText,
      helperStyle: TextStyle(),
      helperMaxLines: 5,
      fillColor: fillColor,
      filled: true,
      contentPadding: contentPadding,
      counterText: counterText,
      counterStyle: counterStyle,
    );
  }

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    final EdgeInsetsGeometry? padding = widget.padding;
    final TextEditingController? controller = widget.controller;
    int maxLines = widget.maxLines;
    final obscureText = widget.obscureText;
    final onSubmitted = widget.onSubmitted;
    return Container(
      padding: padding,
      child: TextField(
        autofocus: widget.autofocus,
        controller: controller,
        maxLines: maxLines,
        obscureText: obscureText,
        onSubmitted: onSubmitted,
        style: TextStyle(
          color: ColorUtil.rgba(51, 51, 51, 1),
          fontSize: 14.sp,
          fontWeight: FontWeightHelper.regular,
        ),
        maxLength: widget.maxLength,
        onChanged: widget.onChange,
        enabled: widget.enabled,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        decoration: widget.decoration != null ? widget.decoration : null,
      ),
    );
  }
}

class NumberTextInputFormatter extends TextInputFormatter {
  int? _maxIntegerLength;
  int? _maxDecimalLength;
  bool _isAllowDecimal;

  /// [maxIntegerLength]限定整数的最大位数，为null时不限
  /// [maxDecimalLength]限定小数点的最大位数，为null时不限
  /// [isAllowDecimal]是否可以为小数，默认是可以为小数，也就是可以输入小数点
  NumberTextInputFormatter(
      {int? maxIntegerLength,
      int? maxDecimalLength,
      bool isAllowDecimal = true})
      : _maxIntegerLength = maxIntegerLength,
        _maxDecimalLength = maxDecimalLength,
        _isAllowDecimal = isAllowDecimal;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String value = newValue.text.trim(); //去掉前后空格
    int selectionIndex = newValue.selection.end;
    if (_isAllowDecimal) {
      if (value == '.') {
        value = '0.';
        selectionIndex++;
      } else if (value != '' && _isToDoubleError(value)) {
        //不是double输入数据
        return _oldTextEditingValue(oldValue);
      }
      //包含小数点
      if (value.contains('.')) {
        int pointIndex = value.indexOf('.');
        String beforePoint = value.substring(0, pointIndex);
//      print('$beforePoint');
        String afterPoint = value.substring(pointIndex + 1, value.length);
//      print('$afterPoint');
        //小数点前面没内容补0
        if (beforePoint.length == 0) {
          value = '0.$afterPoint';
          selectionIndex++;
        } else {
          //限定整数位数
          if (null != _maxIntegerLength) {
            if (beforePoint.length > _maxIntegerLength!) {
              return _oldTextEditingValue(oldValue);
            }
          }
        }
        //限定小数点位数
        if (null != _maxDecimalLength) {
          if (afterPoint.length > _maxDecimalLength!) {
            return _oldTextEditingValue(oldValue);
          }
        }
      } else {
        //限定整数位数
        if (null != _maxIntegerLength) {
          if (value.length > _maxIntegerLength!) {
            return _oldTextEditingValue(oldValue);
          }
        }
      }
    } else {
      if (value.contains('.') ||
          (value != '' && _isToDoubleError(value)) ||
          (null != _maxIntegerLength && value.length > _maxIntegerLength!)) {
        return _oldTextEditingValue(oldValue);
      }
    }

    return TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }

  ///返回旧的输入内容
  TextEditingValue _oldTextEditingValue(TextEditingValue oldValue) {
    return TextEditingValue(
      text: oldValue.text,
      selection: TextSelection.collapsed(offset: oldValue.selection.end),
    );
  }

  ///输入内容不能解析成double
  bool _isToDoubleError(String value) {
    try {
      double.parse(value);
    } catch (e) {
      return true;
    }
    return false;
  }
}
