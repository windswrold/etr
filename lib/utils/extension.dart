import 'dart:math';

import 'package:etrflying/public.dart';

class FontWeightHelper {
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight semiBold = FontWeight.w600;
}

class ColorUtil {
  static Color rgba(int r, int g, int b, double a) {
    return Color.fromARGB((a * 255).toInt(), r, g, b);
  }
}

extension StringTranslateExtension on String {
  bool checkPassword() {
    //密码长度8位数以上，建议使用英文字母、数字和标点符号组成，不采用特殊字符。
    if (this.length < 8) {
      return false;
    }
    String symbols = "\\s\\p{P}\n\r=+\$￥<>^`~|,./;'!@#^&*()_+"; //符号Unicode 编码
    String zcCharNumber = "^(?![$symbols]+\$)[a-zA-Z\\d$symbols]+\$";
    try {
      RegExp reg = RegExp(zcCharNumber);
      return reg.hasMatch(this);
    } catch (e) {
      return false;
    }
  }

  bool checkPrv(KCoinType? mCoinType) {
    int len = 0;
    final value = this.replaceAll("0x", "");
    switch (mCoinType) {
      case KCoinType.ETH:
        len = 64;
        break;
      case KCoinType.BSC:
        len = 64;
        break;
      default:
        len = 64;
        break;
    }
    String regex = "^[0-9A-Fa-f]{$len}\$";
    try {
      RegExp reg = RegExp(regex);
      print("checkPrv $value hasMatch${reg.hasMatch(value)} regex $regex");
      return reg.hasMatch(value);
    } catch (e) {
      return false;
    }
  }

  bool checkAmount(int decimals) {
    String amount = '^[0-9]{0,$decimals}(\\.[0-9]{0,$decimals})?\$';
    RegExp reg = RegExp(amount);
    return reg.hasMatch(this);
  }

  bool isValid() {
    if (this != null && this.length > 0 && this != "null") {
      return true;
    } else {
      return false;
    }
  }

  String subStringForAddress() {
    String contractAddress = '';
    if (this.isNotEmpty && this.length > 14) {
      String startString = this.substring(0, 7);
      String afterString = this.substring(this.length - 7);
      contractAddress = startString + '...' + afterString;
    }
    return contractAddress;
  }

  BigInt tokenInt(int decimals) {
    if (this == null) {
      return BigInt.zero;
    }

    int v = 0;
    try {
      if (this.contains('.')) {
        int index = this.indexOf(".") + 1;
        int offset = this.length - index;
        decimals -= offset;
        v = (double.parse(this) * pow(10, offset)).floor();
      } else {
        v = int.parse(this);
      }
    } catch (err) {
      print('Fmt.tokenInt() error: ${err.toString()}');
    }
    return BigInt.from(pow(10, decimals)) * BigInt.from(v);
  }
}

extension FormatterBalance on BigInt {
  String tokenString(int decimals) {
    if (this == null) {
      return BigInt.zero.toString();
    }
    return (this / BigInt.from(pow(10, decimals))).toString();
  }
}

extension OffsetWidget on num {
  Widget rowOffset() {
    return SizedBox(
      width: this.w,
    );
  }

  Widget columnOffset() {
    return SizedBox(
      height: this.w,
    );
  }
}
