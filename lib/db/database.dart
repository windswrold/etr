import 'dart:async';
import 'package:etrflying/model/collection_tokens.dart';
import 'package:etrflying/model/node_model.dart';
import 'package:etrflying/model/tr_wallet.dart';
import 'package:etrflying/model/trans_record.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'database.g.dart';

//flutter packages pub run build_runner build
const int dbCurrentVersion = 1;

@Database(
    version: dbCurrentVersion,
    entities: [TRWallet, NodeModel, MCollectionTokens, TransRecordModel])
abstract class FlutterDatabase extends FloorDatabase {
  WalletDao get walletDao;
  MCollectionTokenDao get tokensDao;
  TransRecordModelDao get transListDao;
}
