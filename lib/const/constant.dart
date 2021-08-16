import 'dart:io';

import 'package:etrflying/model/node_model.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../public.dart';

enum KCoinType {
  All,
  BSC,
  ETH,
}

enum KLeadType {
  Prvkey, //通过私钥
  KeyStore, //通过keystore
  Memo //通过助记词
}

enum KAccountState {
  init, //未备份
  authed, //已备份
  noauthed, //无需备份
}

enum MCurrencyType {
  CNY,
  USD,
}

enum MTransListType {
  All,
  Out,
  In,
  Failere,
}

enum MTransState {
  Pending,
  Failere,
  Success,
}

enum InputPasswordType {
  authWallet,
  DelWallet,
  BackWallet,
}

enum ETHChainID { Mainnet, Ropsten, Rinkeby, Localhost }

extension ChainIdNum on ETHChainID {
  int getChainId() {
    switch (this) {
      case ETHChainID.Mainnet:
        return 1;
      case ETHChainID.Ropsten:
        return 3;
      case ETHChainID.Rinkeby:
        return 4;
      case ETHChainID.Localhost:
        return 9;
      default:
        return -1;
    }
  }
}

enum BSCChainID { Mainnet, Testnet }

extension bscChainIdNum on BSCChainID {
  int getChainId() {
    switch (this) {
      case BSCChainID.Mainnet:
        return 56;
      case BSCChainID.Testnet:
        return 97;
      default:
        return -1;
    }
  }
}

final bool inProduction = kReleaseMode;
final bool isAndroid = Platform.isAndroid;
final bool isIOS = Platform.isIOS;
final String ASSETS_IMG = './assets/img/';

final _isTestNode = true;

final ethNode = _isTestNode
    ? NodeModel("https://rinkeby.infura.io/v3/fbd05acd5b5c4b2a857720141485416d",
        KCoinType.ETH.index, true, ETHChainID.Rinkeby.getChainId())
    : NodeModel("https://mainnet.infura.io/v3/fbd05acd5b5c4b2a857720141485416d",
        KCoinType.ETH.index, false, ETHChainID.Mainnet.getChainId());
final bscNode = _isTestNode
    ? NodeModel("https://data-seed-prebsc-1-s1.binance.org:8545",
        KCoinType.BSC.index, true, BSCChainID.Testnet.getChainId())
    : NodeModel("https://bsc-dataseed.binance.org", KCoinType.BSC.index, false,
        BSCChainID.Mainnet.getChainId());

String getChainSymbol(int? chainType) {
  String symbol = "";
  if (KCoinType.ETH.index == chainType) {
    symbol = "ETH";
  }
  if (KCoinType.BSC.index == chainType) {
    symbol = "BNB";
  }
  return symbol;
}

KCoinType getChainType(String? chainType) {
  if ("ETH" == chainType) {
    return KCoinType.ETH;
  }
  if ("BNB" == chainType) {
    return KCoinType.BSC;
  }
  throw Error();
}

const String AMOUNT_SET = "AMOUNT_SET";

void updateAmountValue(MCurrencyType type) async {
  final fres = await SharedPreferences.getInstance();
  fres.setInt(AMOUNT_SET, type.index);
}

///
Future<MCurrencyType> getAmountValue() async {
  final prefs = await SharedPreferences.getInstance();
  int object = prefs.getInt(AMOUNT_SET) ?? 0;
  return object == 0 ? MCurrencyType.CNY : MCurrencyType.USD;
}

const String BACKUP_WIDGET_SHOW = "BACKUP_WIDGET_SHOW";

void updateBackupState() async {
  final fres = await SharedPreferences.getInstance();
  fres.setBool(BACKUP_WIDGET_SHOW, true);
}

void delBackupState() async {
  final fres = await SharedPreferences.getInstance();
  fres.remove(BACKUP_WIDGET_SHOW);
}

Future<bool> getBackupState() async {
  final prefs = await SharedPreferences.getInstance();
  bool object = prefs.getBool(BACKUP_WIDGET_SHOW) ?? false;
  return object;
}
