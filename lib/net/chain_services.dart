import 'dart:convert';
import 'dart:math';
import 'package:etrflying/model/node_model.dart';
import 'package:etrflying/net/request_method.dart';
import 'package:etrflying/net/wallet_services.dart';
import 'package:flutter/foundation.dart';
import '../public.dart';

class MainAssetResult {
  String? c; //余额
  num? mainUsdPrice; //usd单价
  num? usdConversionCny; //1U = ~CNY
  num? btcUsdPrice; //btc单价 1btc = 50000u

  MainAssetResult(
      {this.c, this.mainUsdPrice, this.usdConversionCny, this.btcUsdPrice});

  @override
  String toString() {
    // TODO: implement toString
    return {
      "c": this.c,
      "mainUsdPrice": this.mainUsdPrice,
      "usdConversionCny": this.usdConversionCny,
      "btcUsdPrice": this.btcUsdPrice
    }.toString();
  }
}

class ChainServices {
  static Future<String>? requestAssets({
    required String? coinType,
    required String? from,
    required String? contract,
    required String? token,
    int? tokenDecimal = 18,
    bool neePrice = false,
  }) {
    assert(coinType != null, "requestAssets");
    assert(from != null);
    return _requestETHAssets(
      coinType: coinType,
      from: from,
      contract: contract,
      neePrice: neePrice,
      tokenDecimal: tokenDecimal,
      token: token,
    );
  }

  static Future requestTransactionReceipt(String url, String tx) async {
    String method = "eth_getTransactionReceipt";
    Map params = {
      "jsonrpc": "2.0",
      "method": method,
      "params": [tx],
      "id": tx,
    };
    return RequestMethod()
        .futureRequestData(Method.POST, url, null, data: params);
  }

  static Future requestEthblockNumber(String url) async {
    String method = "eth_blockNumber";
    Map params = {
      "jsonrpc": "2.0",
      "method": method,
      "params": [],
      "id": 1,
    };
    return RequestMethod()
        .futureRequestData(Method.POST, url, null, data: params);
  }

  static Future<String> _requestETHAssets({
    String? coinType,
    String? from,
    String? contract,
    String? token,
    int? tokenDecimal = 18,
    bool neePrice = false,
  }) async {
    String url = "";
    if (getChainType(coinType) == KCoinType.ETH) {
      url = ethNode.content;
    } else {
      url = bscNode.content;
    }

    Map<String, dynamic> balanceParams = Map();
    if (contract?.isValid() == true) {
      String data =
          "0x70a08231000000000000000000000000" + from!.replaceAll("0x", "");

      balanceParams["jsonrpc"] = "2.0";
      balanceParams["method"] = "eth_call";
      balanceParams["params"] = [
        {"to": contract, "data": data},
        "latest"
      ];
      balanceParams["id"] = 1;
    } else {
      balanceParams["jsonrpc"] = "2.0";
      balanceParams["method"] = "eth_getBalance";
      balanceParams["params"] = [from, "latest"];
      balanceParams["id"] = 1;
    }

    dynamic balresult = await RequestMethod()
        .futureRequestData(Method.POST, url, null, data: balanceParams);
    if (balresult != null && tokenDecimal != 0) {
      String? bal = balresult["result"] as String?;
      bal = bal?.replaceFirst("0x", "");
      bal ??= "";
      bal = bal.length == 0 ? "0" : bal;
      bal = (BigInt.tryParse(bal, radix: 16)).toString();
      if (contract?.isValid() == false) {
        bal = (double.tryParse(bal)! / pow(10, 18)).toString();
      } else {
        bal = (double.tryParse(bal)! / pow(10, tokenDecimal!)).toString();
      }
      return bal;
    }
    return "0.0";
  }
}
