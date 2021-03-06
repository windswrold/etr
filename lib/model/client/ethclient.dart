import 'dart:typed_data';

import 'package:etrflying/model/collection_tokens.dart';
import 'package:etrflying/utils/encode.dart';
import 'package:web3dart/contracts/erc20.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart' as web3;

class ETHClient {
  final Web3Client client;
  Credentials? credentials;
  final int? _chainId;

  ETHClient(String url, int chainId)
      : client = Web3Client(url, Client()),
        _chainId = chainId;

  Future<String?> transfer(
      Credentials credentials,
      MCollectionTokens token,
      BigInt amount,
      EthereumAddress to,
      EtherAmount? gasPrice,
      int? maxGas,
      String data) async {
    if (token.isToken == false) {
      return this.client.sendTransaction(
          credentials,
          web3.Transaction(
              to: to,
              value: EtherAmount.inWei(amount),
              gasPrice: gasPrice,
              maxGas: maxGas,
              data: TREncode.kValueToBytes(data)),
          chainId: _chainId,
          fetchChainIdFromNetworkId: false);
    } else {
      final contractAddress = EthereumAddress.fromHex(token.contract!);
      final erc20 = Erc20(address: contractAddress, client: this.client);
      return erc20.transfer(to, amount, credentials: credentials);
    }
  }

  Future<EtherAmount> getGasPrice() {
    return this.client.getGasPrice();
  }

  Future<TransactionReceipt?> getTransactionReceipt(String hash) {
    return this.client.getTransactionReceipt(hash);
  }

  Future<EtherAmount?> getBalance(EthereumAddress address) {
    return this.client.getBalance(address);
  }

  Future<BigInt> getTokenBalance(String address, String contractaa) {
    final contractAddress = EthereumAddress.fromHex(contractaa);
    final erc20 = Erc20(address: contractAddress, client: this.client);
    return erc20.balanceOf(EthereumAddress.fromHex(address));
  }

  int? get ChainID => _chainId;
}
