// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorFlutterDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$FlutterDatabaseBuilder databaseBuilder(String name) =>
      _$FlutterDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$FlutterDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$FlutterDatabaseBuilder(null);
}

class _$FlutterDatabaseBuilder {
  _$FlutterDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$FlutterDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$FlutterDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<FlutterDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$FlutterDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$FlutterDatabase extends FlutterDatabase {
  _$FlutterDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  WalletDao? _walletDaoInstance;

  MCollectionTokenDao? _tokensDaoInstance;

  TransRecordModelDao? _transListDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `wallet_table` (`walletID` TEXT, `walletAaddress` TEXT, `pin` TEXT, `prvKey` TEXT, `coinType` INTEGER, `accountState` INTEGER, `mnemonic` TEXT, PRIMARY KEY (`walletID`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `tokens_table` (`owner` TEXT, `contract` TEXT, `token` TEXT, `coinType` TEXT, `state` INTEGER, `decimals` INTEGER, `price` REAL, `balance` REAL, `digits` INTEGER, `chainid` INTEGER, PRIMARY KEY (`owner`, `contract`, `chainid`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `translist_table` (`txid` TEXT, `toAdd` TEXT, `fromAdd` TEXT, `date` TEXT, `amount` TEXT, `remarks` TEXT, `fee` TEXT, `gasPrice` TEXT, `gasLimit` TEXT, `transStatus` INTEGER, `token` TEXT, `coinType` TEXT, `transType` INTEGER, `chainid` INTEGER, `blockHeight` INTEGER, `confirmations` INTEGER, PRIMARY KEY (`txid`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  WalletDao get walletDao {
    return _walletDaoInstance ??= _$WalletDao(database, changeListener);
  }

  @override
  MCollectionTokenDao get tokensDao {
    return _tokensDaoInstance ??=
        _$MCollectionTokenDao(database, changeListener);
  }

  @override
  TransRecordModelDao get transListDao {
    return _transListDaoInstance ??=
        _$TransRecordModelDao(database, changeListener);
  }
}

class _$WalletDao extends WalletDao {
  _$WalletDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _tRWalletInsertionAdapter = InsertionAdapter(
            database,
            'wallet_table',
            (TRWallet item) => <String, Object?>{
                  'walletID': item.walletID,
                  'walletAaddress': item.walletAaddress,
                  'pin': item.pin,
                  'prvKey': item.prvKey,
                  'coinType': item.coinType,
                  'accountState': item.accountState,
                  'mnemonic': item.mnemonic
                }),
        _tRWalletUpdateAdapter = UpdateAdapter(
            database,
            'wallet_table',
            ['walletID'],
            (TRWallet item) => <String, Object?>{
                  'walletID': item.walletID,
                  'walletAaddress': item.walletAaddress,
                  'pin': item.pin,
                  'prvKey': item.prvKey,
                  'coinType': item.coinType,
                  'accountState': item.accountState,
                  'mnemonic': item.mnemonic
                }),
        _tRWalletDeletionAdapter = DeletionAdapter(
            database,
            'wallet_table',
            ['walletID'],
            (TRWallet item) => <String, Object?>{
                  'walletID': item.walletID,
                  'walletAaddress': item.walletAaddress,
                  'pin': item.pin,
                  'prvKey': item.prvKey,
                  'coinType': item.coinType,
                  'accountState': item.accountState,
                  'mnemonic': item.mnemonic
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TRWallet> _tRWalletInsertionAdapter;

  final UpdateAdapter<TRWallet> _tRWalletUpdateAdapter;

  final DeletionAdapter<TRWallet> _tRWalletDeletionAdapter;

  @override
  Future<TRWallet?> findWalletByWalletID(String walletID) async {
    return _queryAdapter.query('SELECT * FROM wallet_table WHERE walletID = ?1',
        mapper: (Map<String, Object?> row) => TRWallet(
            row['walletID'] as String?,
            row['walletAaddress'] as String?,
            row['pin'] as String?,
            row['prvKey'] as String?,
            row['coinType'] as int?,
            row['accountState'] as int?,
            row['mnemonic'] as String?),
        arguments: [walletID]);
  }

  @override
  Future<List<TRWallet>> findAllWallets() async {
    return _queryAdapter.queryList('SELECT * FROM wallet_table',
        mapper: (Map<String, Object?> row) => TRWallet(
            row['walletID'] as String?,
            row['walletAaddress'] as String?,
            row['pin'] as String?,
            row['prvKey'] as String?,
            row['coinType'] as int?,
            row['accountState'] as int?,
            row['mnemonic'] as String?));
  }

  @override
  Future<void> insertWallet(TRWallet wallet) async {
    await _tRWalletInsertionAdapter.insert(wallet, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertWallets(List<TRWallet> wallet) async {
    await _tRWalletInsertionAdapter.insertList(
        wallet, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateWallet(TRWallet wallet) async {
    await _tRWalletUpdateAdapter.update(wallet, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateWallets(List<TRWallet> wallet) async {
    await _tRWalletUpdateAdapter.updateList(wallet, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteWallet(TRWallet wallet) async {
    await _tRWalletDeletionAdapter.delete(wallet);
  }

  @override
  Future<void> deleteWallets(List<TRWallet> wallet) async {
    await _tRWalletDeletionAdapter.deleteList(wallet);
  }
}

class _$MCollectionTokenDao extends MCollectionTokenDao {
  _$MCollectionTokenDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _mCollectionTokensInsertionAdapter = InsertionAdapter(
            database,
            'tokens_table',
            (MCollectionTokens item) => <String, Object?>{
                  'owner': item.owner,
                  'contract': item.contract,
                  'token': item.token,
                  'coinType': item.coinType,
                  'state': item.state,
                  'decimals': item.decimals,
                  'price': item.price,
                  'balance': item.balance,
                  'digits': item.digits,
                  'chainid': item.chainid
                }),
        _mCollectionTokensUpdateAdapter = UpdateAdapter(
            database,
            'tokens_table',
            ['owner', 'contract', 'chainid'],
            (MCollectionTokens item) => <String, Object?>{
                  'owner': item.owner,
                  'contract': item.contract,
                  'token': item.token,
                  'coinType': item.coinType,
                  'state': item.state,
                  'decimals': item.decimals,
                  'price': item.price,
                  'balance': item.balance,
                  'digits': item.digits,
                  'chainid': item.chainid
                }),
        _mCollectionTokensDeletionAdapter = DeletionAdapter(
            database,
            'tokens_table',
            ['owner', 'contract', 'chainid'],
            (MCollectionTokens item) => <String, Object?>{
                  'owner': item.owner,
                  'contract': item.contract,
                  'token': item.token,
                  'coinType': item.coinType,
                  'state': item.state,
                  'decimals': item.decimals,
                  'price': item.price,
                  'balance': item.balance,
                  'digits': item.digits,
                  'chainid': item.chainid
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MCollectionTokens> _mCollectionTokensInsertionAdapter;

  final UpdateAdapter<MCollectionTokens> _mCollectionTokensUpdateAdapter;

  final DeletionAdapter<MCollectionTokens> _mCollectionTokensDeletionAdapter;

  @override
  Future<List<MCollectionTokens>> findTokens(String owner, int chainid) async {
    return _queryAdapter.queryList(
        'SELECT * FROM tokens_table WHERE owner = ?1 and chainid=?2',
        mapper: (Map<String, Object?> row) => MCollectionTokens(
            owner: row['owner'] as String?,
            contract: row['contract'] as String?,
            token: row['token'] as String?,
            coinType: row['coinType'] as String?,
            state: row['state'] as int?,
            decimals: row['decimals'] as int?,
            price: row['price'] as double?,
            balance: row['balance'] as double?,
            digits: row['digits'] as int?,
            chainid: row['chainid'] as int?),
        arguments: [owner, chainid]);
  }

  @override
  Future<List<MCollectionTokens>> findStateTokens(
      String owner, int state, int chainid) async {
    return _queryAdapter.queryList(
        'SELECT * FROM tokens_table WHERE owner = ?1 and state = ?2 and chainid=?3',
        mapper: (Map<String, Object?> row) => MCollectionTokens(owner: row['owner'] as String?, contract: row['contract'] as String?, token: row['token'] as String?, coinType: row['coinType'] as String?, state: row['state'] as int?, decimals: row['decimals'] as int?, price: row['price'] as double?, balance: row['balance'] as double?, digits: row['digits'] as int?, chainid: row['chainid'] as int?),
        arguments: [owner, state, chainid]);
  }

  @override
  Future<List<MCollectionTokens>> findAllTokens(int chainid) async {
    return _queryAdapter.queryList(
        'SELECT * FROM tokens_table WHERE  chainid=?1',
        mapper: (Map<String, Object?> row) => MCollectionTokens(
            owner: row['owner'] as String?,
            contract: row['contract'] as String?,
            token: row['token'] as String?,
            coinType: row['coinType'] as String?,
            state: row['state'] as int?,
            decimals: row['decimals'] as int?,
            price: row['price'] as double?,
            balance: row['balance'] as double?,
            digits: row['digits'] as int?,
            chainid: row['chainid'] as int?),
        arguments: [chainid]);
  }

  @override
  Future<void> insertToken(MCollectionTokens model) async {
    await _mCollectionTokensInsertionAdapter.insert(
        model, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertTokens(List<MCollectionTokens> models) async {
    await _mCollectionTokensInsertionAdapter.insertList(
        models, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateTokens(MCollectionTokens model) async {
    await _mCollectionTokensUpdateAdapter.update(
        model, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteTokens(MCollectionTokens model) async {
    await _mCollectionTokensDeletionAdapter.delete(model);
  }
}

class _$TransRecordModelDao extends TransRecordModelDao {
  _$TransRecordModelDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _transRecordModelInsertionAdapter = InsertionAdapter(
            database,
            'translist_table',
            (TransRecordModel item) => <String, Object?>{
                  'txid': item.txid,
                  'toAdd': item.toAdd,
                  'fromAdd': item.fromAdd,
                  'date': item.date,
                  'amount': item.amount,
                  'remarks': item.remarks,
                  'fee': item.fee,
                  'gasPrice': item.gasPrice,
                  'gasLimit': item.gasLimit,
                  'transStatus': item.transStatus,
                  'token': item.token,
                  'coinType': item.coinType,
                  'transType': item.transType,
                  'chainid': item.chainid,
                  'blockHeight': item.blockHeight,
                  'confirmations': item.confirmations
                }),
        _transRecordModelUpdateAdapter = UpdateAdapter(
            database,
            'translist_table',
            ['txid'],
            (TransRecordModel item) => <String, Object?>{
                  'txid': item.txid,
                  'toAdd': item.toAdd,
                  'fromAdd': item.fromAdd,
                  'date': item.date,
                  'amount': item.amount,
                  'remarks': item.remarks,
                  'fee': item.fee,
                  'gasPrice': item.gasPrice,
                  'gasLimit': item.gasLimit,
                  'transStatus': item.transStatus,
                  'token': item.token,
                  'coinType': item.coinType,
                  'transType': item.transType,
                  'chainid': item.chainid,
                  'blockHeight': item.blockHeight,
                  'confirmations': item.confirmations
                }),
        _transRecordModelDeletionAdapter = DeletionAdapter(
            database,
            'translist_table',
            ['txid'],
            (TransRecordModel item) => <String, Object?>{
                  'txid': item.txid,
                  'toAdd': item.toAdd,
                  'fromAdd': item.fromAdd,
                  'date': item.date,
                  'amount': item.amount,
                  'remarks': item.remarks,
                  'fee': item.fee,
                  'gasPrice': item.gasPrice,
                  'gasLimit': item.gasLimit,
                  'transStatus': item.transStatus,
                  'token': item.token,
                  'coinType': item.coinType,
                  'transType': item.transType,
                  'chainid': item.chainid,
                  'blockHeight': item.blockHeight,
                  'confirmations': item.confirmations
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TransRecordModel> _transRecordModelInsertionAdapter;

  final UpdateAdapter<TransRecordModel> _transRecordModelUpdateAdapter;

  final DeletionAdapter<TransRecordModel> _transRecordModelDeletionAdapter;

  @override
  Future<List<TransRecordModel>> queryTrxList(
      String fromAdd, String token, int chainid) async {
    return _queryAdapter.queryList(
        'SELECT * FROM translist_table WHERE (fromAdd = ?1)  and token = ?2 and chainid = ?3 ORDER BY date DESC',
        mapper: (Map<String, Object?> row) => TransRecordModel(txid: row['txid'] as String?, toAdd: row['toAdd'] as String?, fromAdd: row['fromAdd'] as String?, date: row['date'] as String?, amount: row['amount'] as String?, remarks: row['remarks'] as String?, fee: row['fee'] as String?, transStatus: row['transStatus'] as int?, token: row['token'] as String?, coinType: row['coinType'] as String?, gasLimit: row['gasLimit'] as String?, gasPrice: row['gasPrice'] as String?, transType: row['transType'] as int?, chainid: row['chainid'] as int?, blockHeight: row['blockHeight'] as int?, confirmations: row['confirmations'] as int?),
        arguments: [fromAdd, token, chainid]);
  }

  @override
  Future<List<TransRecordModel>> queryTrxListWithType(
      String fromAdd, String token, int chainid, int transType) async {
    return _queryAdapter.queryList(
        'SELECT * FROM translist_table WHERE (fromAdd = ?1)  and token = ?2 and chainid = ?3 and transType =?4 ORDER BY date DESC',
        mapper: (Map<String, Object?> row) => TransRecordModel(txid: row['txid'] as String?, toAdd: row['toAdd'] as String?, fromAdd: row['fromAdd'] as String?, date: row['date'] as String?, amount: row['amount'] as String?, remarks: row['remarks'] as String?, fee: row['fee'] as String?, transStatus: row['transStatus'] as int?, token: row['token'] as String?, coinType: row['coinType'] as String?, gasLimit: row['gasLimit'] as String?, gasPrice: row['gasPrice'] as String?, transType: row['transType'] as int?, chainid: row['chainid'] as int?, blockHeight: row['blockHeight'] as int?, confirmations: row['confirmations'] as int?),
        arguments: [fromAdd, token, chainid, transType]);
  }

  @override
  Future<List<TransRecordModel>> queryPendingTrxList(
      String fromAdd, String token, int chainid) async {
    return _queryAdapter.queryList(
        'SELECT * FROM translist_table WHERE (fromAdd = ?1)  and token = ?2 and chainid = ?3 and (transStatus = 0)  ORDER BY date DESC',
        mapper: (Map<String, Object?> row) => TransRecordModel(txid: row['txid'] as String?, toAdd: row['toAdd'] as String?, fromAdd: row['fromAdd'] as String?, date: row['date'] as String?, amount: row['amount'] as String?, remarks: row['remarks'] as String?, fee: row['fee'] as String?, transStatus: row['transStatus'] as int?, token: row['token'] as String?, coinType: row['coinType'] as String?, gasLimit: row['gasLimit'] as String?, gasPrice: row['gasPrice'] as String?, transType: row['transType'] as int?, chainid: row['chainid'] as int?, blockHeight: row['blockHeight'] as int?, confirmations: row['confirmations'] as int?),
        arguments: [fromAdd, token, chainid]);
  }

  @override
  Future<List<TransRecordModel>> queryTrxFromTrxid(String txid) async {
    return _queryAdapter.queryList(
        'SELECT * FROM translist_table WHERE txid = ?1',
        mapper: (Map<String, Object?> row) => TransRecordModel(
            txid: row['txid'] as String?,
            toAdd: row['toAdd'] as String?,
            fromAdd: row['fromAdd'] as String?,
            date: row['date'] as String?,
            amount: row['amount'] as String?,
            remarks: row['remarks'] as String?,
            fee: row['fee'] as String?,
            transStatus: row['transStatus'] as int?,
            token: row['token'] as String?,
            coinType: row['coinType'] as String?,
            gasLimit: row['gasLimit'] as String?,
            gasPrice: row['gasPrice'] as String?,
            transType: row['transType'] as int?,
            chainid: row['chainid'] as int?,
            blockHeight: row['blockHeight'] as int?,
            confirmations: row['confirmations'] as int?),
        arguments: [txid]);
  }

  @override
  Future<List<TransRecordModel>> queryAllTrx() async {
    return _queryAdapter.queryList('SELECT * FROM translist_table',
        mapper: (Map<String, Object?> row) => TransRecordModel(
            txid: row['txid'] as String?,
            toAdd: row['toAdd'] as String?,
            fromAdd: row['fromAdd'] as String?,
            date: row['date'] as String?,
            amount: row['amount'] as String?,
            remarks: row['remarks'] as String?,
            fee: row['fee'] as String?,
            transStatus: row['transStatus'] as int?,
            token: row['token'] as String?,
            coinType: row['coinType'] as String?,
            gasLimit: row['gasLimit'] as String?,
            gasPrice: row['gasPrice'] as String?,
            transType: row['transType'] as int?,
            chainid: row['chainid'] as int?,
            blockHeight: row['blockHeight'] as int?,
            confirmations: row['confirmations'] as int?));
  }

  @override
  Future<void> insertTrxList(TransRecordModel model) async {
    await _transRecordModelInsertionAdapter.insert(
        model, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertTrxLists(List<TransRecordModel> models) async {
    await _transRecordModelInsertionAdapter.insertList(
        models, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateTrxList(TransRecordModel model) async {
    await _transRecordModelUpdateAdapter.update(
        model, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateTrxLists(List<TransRecordModel> models) async {
    await _transRecordModelUpdateAdapter.updateList(
        models, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteTrxList(TransRecordModel model) async {
    await _transRecordModelDeletionAdapter.delete(model);
  }
}
