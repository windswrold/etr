import 'dart:math';

import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;
import 'package:etrflying/const/constant.dart';
import 'package:etrflying/model/hd_wallet.dart';
import 'package:etrflying/utils/encode.dart';
import 'package:web3dart/web3dart.dart';

class ETHChain implements HDWalletImport {
  @override
  String genPublicAddress(String privateKey) {
    final private = EthPrivateKey.fromHex(privateKey);
    return private.address.hexEip55;
  }

  @override
  String privateKeyFromMnemonic(String mnemonic) {
    var seed = bip39.mnemonicToSeed(mnemonic);
    var root = bip32.BIP32.fromSeed(seed);
    var child = root.derivePath("m/44'/60'/0'/0/0");
    final prv = child.privateKey;
    return TREncode.kBytesToHex(prv!, include0x: true);
  }

  @override
  String privateKeyFromJson(String json, String password) {
    Wallet wallet = Wallet.fromJson(json, password);
    return TREncode.kBytesToHex(wallet.privateKey.privateKey, include0x: true);
  }

  @override
  HDWallet? importWallet(
      {required String content,
      required String pin,
      required KLeadType kLeadType}) {
    var prv;
    var address;
    if (kLeadType == KLeadType.Memo) {
      prv = this.privateKeyFromMnemonic(content);
    } else if (kLeadType == KLeadType.KeyStore) {
      prv = this.privateKeyFromJson(content, pin);
    } else if (kLeadType == KLeadType.Prvkey) {
      prv = content;
    }
    address = this.genPublicAddress(prv);
    HDWallet wallet = HDWallet(KCoinType.ETH, prv, address, pin, content,kLeadType);
    return wallet;
  }
}
