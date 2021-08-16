import 'package:etrflying/const/constant.dart';

class HDWallet {
  String? prv; //加密后的
  String? address; //地址
  String? pin; //pin
  String? content;
  KLeadType? leadType;
  KCoinType? coinType;
  HDWallet(this.coinType, this.prv, this.address, this.pin, this.content,
      this.leadType);

  @override
  String toString() {
    // TODO: implement toString
    return "prv $prv , address $address pin $pin coinType $coinType";
  }
}

class HDWalletImport {
  String privateKeyFromMnemonic(String mnemonic) {
    return "";
  }

  String privateKeyFromJson(String json, String password) {
    return "";
  }

  String genPublicAddress(String privateKey) {
    return "";
  }

  HDWallet? importWallet(
      {required String content,
      required String pin,
      required KLeadType kLeadType}) {}
}
