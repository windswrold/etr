import 'dart:async';
import 'package:etrflying/net/request_method.dart';

import '../public.dart';

class WalletServices {
  static Future<String> requestETHPrice() async {
    Completer<String> completer = Completer();
    Future<String> future = completer.future;
    String convert_id = "2781";
    RequestMethod().futureRequestData(Method.GET,
        "https://web-api.coinmarketcap.com/v1/tools/price-conversion?amount=1&convert_id=$convert_id&id=1027",
        (result, code) {
      if (code == 200 && result != null) {
        Map resultMap = result as Map;
        if (resultMap.containsKey("data")) {
          Map data = resultMap["data"];
          num price = data["quote"][convert_id]["price"] ?? 0;
          completer.complete(price.toString());
          LogUtil.v("requestTokenPrice $price ");
        }
      } else {
        completer.complete("0.00");
      }
    });
    return future;
  }

  static Future<String> requestBNBPrice() async {
    Completer<String> completer = Completer();
    Future<String> future = completer.future;
    String convert_id = "1839";
    RequestMethod().futureRequestData(Method.GET,
        "https://web-api.coinmarketcap.com/v1/tools/price-conversion?amount=1&convert_id=2781&id=$convert_id",
        (result, code) {
      if (code == 200 && result != null) {
        Map resultMap = result as Map;
        if (resultMap.containsKey("data")) {
          Map data = resultMap["data"];
          num price = data["quote"]["2781"]["price"] ?? 0;
          completer.complete(price.toString());
          LogUtil.v("requestTokenPrice $price ");
        }
      } else {
        completer.complete("0.00");
      }
    });
    return future;
  }

  static Future<String> requestUSDPrice(complationBlock? block) async {
    Completer<String> completer = Completer();
    Future<String> future = completer.future;
    String convert_id = "2787";
    String id = "2781";
    RequestMethod().futureRequestData(Method.GET,
        "https://web-api.coinmarketcap.com/v1/tools/price-conversion?amount=1&convert_id=$convert_id&id=$id",
        (result, code) {
      if (code == 200 && result != null) {
        Map resultMap = result as Map;
        if (resultMap.containsKey("data")) {
          Map data = resultMap["data"];
          num price = data["quote"][convert_id]["price"] ?? 0;
          completer.complete(price.toString());
        }
      } else {
        completer.complete("0.00");
      }
    });
    return future;
  }

  static Future<String> requestBTCPrice(complationBlock? block) async {
    Completer<String> completer = Completer();
    Future<String> future = completer.future;
    String convert_id = "2781";
    String id = "1";
    RequestMethod().futureRequestData(Method.GET,
        "https://web-api.coinmarketcap.com/v1/tools/price-conversion?amount=1&convert_id=$convert_id&id=$id",
        (result, code) {
      if (code == 200 && result != null) {
        Map resultMap = result as Map;
        if (resultMap.containsKey("data")) {
          Map data = resultMap["data"];
          num price = data["quote"][convert_id]["price"] ?? 0;
          completer.complete(price.toString());
        }
      } else {
        completer.complete("0.00");
      }
    });
    return future;
  }
}
