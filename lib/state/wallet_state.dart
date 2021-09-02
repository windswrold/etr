import 'package:etrflying/model/client/ethclient.dart';
import 'package:etrflying/model/collection_tokens.dart';
import 'package:etrflying/model/node_model.dart';
import 'package:etrflying/model/tr_wallet.dart';
import 'package:etrflying/net/chain_services.dart';
import 'package:etrflying/net/wallet_services.dart';
import 'package:etrflying/utils/log_util.dart';
import 'package:etrflying/utils/timer_util.dart';

import '../public.dart';

class CurrentChooseWalletState with ChangeNotifier {
  List<TRWallet> _currentWallet = [];
  List<MCollectionTokens> _collectionTokens = []; //我的代币
  MCurrencyType _currencyType = MCurrencyType.CNY;
  int _tokenIndex = 0;
  String _totalAssets = "0.00"; //总资产数额
  String _ethPrice = "0.0";
  String _bnbPrice = "0.0";
  String _usdPrice = "0.0";
  TimerUtil? _timer;

  void loadWallet() async {
    _currentWallet = await TRWallet.findAllWallets();
    _currencyType = await getAmountValue();
    requestAssets(true);
    if (inProduction == true) {
      _configTimerRequest();
    }
  }

  void delWallets() async {
    _totalAssets = "0.00";
    _tokenIndex = 0;
    TRWallet.deleteWallets(_currentWallet);
    delBackupState();
    _currentWallet = [];
    notifyListeners();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer?.cancel();
    _timer = null;
  }

  void requestAssets(bool needPrice) async {
    if (_currentWallet.length == 0) {
      _currentWallet = await TRWallet.findAllWallets();
      if (_currentWallet.length == 0) {
        return;
      }
    }
    queryMyCollectionTokens();
    if (needPrice == true) {
      _ethPrice = await WalletServices.requestETHPrice();
      _bnbPrice = await WalletServices.requestBNBPrice();
      _usdPrice = await WalletServices.requestUSDPrice(null);
    }

    _requestMyCollectionTokenAssets();
  }

  void queryMyCollectionTokens() async {
    List<MCollectionTokens> tokens = [];
    for (var wallet in _currentWallet) {
      String owner = wallet.walletAaddress!;
      if (isTestNode == true) {
        if (wallet.coinType == KCoinType.ETH.index) {
          tokens.addAll(await MCollectionTokens.findStateTokens(
              owner, 1, ETHChainID.Rinkeby.getChainId()));
        } else {
          tokens.addAll(await MCollectionTokens.findStateTokens(
              owner, 1, BSCChainID.Testnet.getChainId()));
        }
      } else {
        if (wallet.coinType == KCoinType.ETH.index) {
          tokens.addAll(await MCollectionTokens.findStateTokens(
              owner, 1, ETHChainID.Mainnet.getChainId()));
        } else {
          tokens.addAll(await MCollectionTokens.findStateTokens(
              owner, 1, BSCChainID.Mainnet.getChainId()));
        }
      }
    }

    _collectionTokens = tokens;
    notifyListeners();
  }

  void _requestMyCollectionTokenAssets() async {
    int i = 0;
    List<MCollectionTokens> datas = _collectionTokens;
    for (i = 0; i < datas.length; i++) {
      MCollectionTokens map = datas[i];
      String? balResult = await ChainServices.requestAssets(
          coinType: map.coinType,
          from: map.owner,
          contract: map.contract,
          tokenDecimal: map.decimals,
          token: map.token);
      map.balance = double.tryParse(balResult ?? "0.0");
      if (currencyType == MCurrencyType.CNY) {
        double usd = double.tryParse(_usdPrice) ?? 0.0;
        if (map.token == "ETH") {
          map.price = (double.tryParse(_ethPrice) ?? 0.0) * usd;
        }
        if (map.token == "BNB") {
          map.price = (double.tryParse(_bnbPrice) ?? 0.0) * usd;
        }
      } else {
        if (map.token == "ETH") {
          if (currencyType == MCurrencyType.CNY) {
            map.price = double.tryParse(_ethPrice);
          }
        }
        if (map.token == "BNB") {
          map.price = double.tryParse(_bnbPrice);
        }
      }
      MCollectionTokens.updateTokens(map);
    }
    notifyListeners();
    _calTotalAssets();
  }

  void _configTimerRequest() async {
    if (_timer == null) {
      _timer = TimerUtil(mInterval: 10000);
      _timer!.setOnTimerTickCallback((millisUntilFinished) async {
        if (_currentWallet.length == 0) return;
        requestAssets(false);
      });
    }
    if (_timer!.isActive() == false) {
      _timer!.startTimer();
    }
  }

  ///计算我的总资产
  void _calTotalAssets() {
    List<MCollectionTokens> dataL1 = collectionTokens;
    double sumAssets = 0;
    int i = 0;
    for (i = 0; i < dataL1.length; i++) {
      MCollectionTokens map = dataL1[i];
      sumAssets += (map.balance ?? 0) * (map.price ?? 0);
    }
    _totalAssets = sumAssets.toStringAsFixed(2);
    notifyListeners();
  }

  void updateWalletPwd(String oldPin, String newPin) {
    for (var wallet in _currentWallet) {
      final prv = wallet.exportPrv(pin: oldPin);
      final memo = wallet.exportMemo(pin: oldPin);
      wallet.pin = TREncode.SHA256(newPin);
      wallet.prvKey = TREncode.encrypt(prv!, newPin);
      wallet.mnemonic = memo!.length == 0 ? "" : TREncode.encrypt(memo, newPin);
    }
    TRWallet.updateWallets(_currentWallet);
    notifyListeners();
  }

  void updateTokenIndex(int index) {
    _tokenIndex = index;
    notifyListeners();
    LogUtil.v("updateTokenChoose _tokenIndex $_tokenIndex ");
  }

  void updateBackWalletState(KAccountState state) {
    _currentWallet.forEach((element) {
      element.accountState = state.index;
    });
    TRWallet.updateWallets(_currentWallet);
    notifyListeners();
  }

  String get ethPrice => _ethPrice;
  String get bnbPrice => _bnbPrice;
  String get usdPrice => _usdPrice;

  String get totalAssets => _totalAssets;
  String get totalSymbolAssets => currencySymbolStr + " $totalAssets";
  String get currencyTypeStr =>
      _currencyType == MCurrencyType.CNY ? "CNY" : "USD";
  String get currencySymbolStr =>
      _currencyType == MCurrencyType.CNY ? "￥" : "\$";
  MCurrencyType get currencyType => _currencyType;
  List<MCollectionTokens> get collectionTokens => _collectionTokens;
  TRWallet get currentWallet => _currentWallet
      .where((element) => (element.symbol == chooseTokens!.coinType))
      .first;

  List<TRWallet> get wallets => _currentWallet;
  MCollectionTokens? get chooseTokens => collectionTokens[_tokenIndex];
  KAccountState isNeedAuth() {
    if (_currentWallet.length > 0) {
      for (var item in _currentWallet) {
        final mnemonic = item.mnemonic ?? "";
        if (mnemonic.length > 0) {
          if (item.accountState == KAccountState.init.index) {
            return KAccountState.init;
          } else {
            return KAccountState.authed;
          }
        } else {
          return KAccountState.noauthed;
        }
      }
    }
    return KAccountState.noauthed;
  }
}
