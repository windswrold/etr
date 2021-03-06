import 'dart:ffi';
import 'dart:typed_data';

import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;
import 'package:etrflying/const/constant.dart';
import 'package:etrflying/model/hd_wallet.dart';
import 'package:etrflying/utils/encode.dart';
import 'package:pointycastle/digests/ripemd160.dart';
import 'package:pointycastle/digests/sha256.dart';
import 'package:web3dart/web3dart.dart';

class BSCChain implements HDWalletImport {
  @override
  HDWallet? importWallet(
      {required String content,
      required String pin,
      required KLeadType kLeadType}) {
    var prv;
    var address;
    if (kLeadType == KLeadType.Memo) {
      prv = privateKeyFromMnemonic(content);
    } else if (kLeadType == KLeadType.KeyStore) {
      prv = privateKeyFromJson(content, pin);
    } else if (kLeadType == KLeadType.Prvkey) {
      prv = content;
    }
    address = genPublicAddress(prv);
    HDWallet wallet =
        HDWallet(KCoinType.BSC, prv, address, pin, content, kLeadType);
    return wallet;
  }

  @override
  String genPublicAddress(String privateKey) {
    final private = EthPrivateKey.fromHex(privateKey);
    return private.address.hexEip55;
    var _bip32 = bip32.BIP32
        .fromPrivateKey(TREncode.kHexToBytes(privateKey), Uint8List(0));
    return getAddressFromPublicKey(_bip32.publicKey);
  }

  String getAddressFromPublicKey(Uint8List publicKey, [hrp = 'bnb']) {
    final s = SHA256Digest().process(publicKey);
    final r = RIPEMD160Digest().process(s);
    return TREncode.bech32_encode(hrp, TREncode.convertbits(r, 8, 5)!);
  }

  @override
  String privateKeyFromJson(String json, String password) {
    Wallet wallet = Wallet.fromJson(json, password);
    return TREncode.kBytesToHex(wallet.privateKey.privateKey, include0x: true);
  }

  @override
  String privateKeyFromMnemonic(String mnemonic) {
    var seed = bip39.mnemonicToSeed(mnemonic);
    var root = bip32.BIP32.fromSeed(seed);
    var child = root.derivePath("m/44'/714'/0'/0/0");
    final prv = child.privateKey;
    return TREncode.kBytesToHex(prv!, include0x: true);
  }
}
