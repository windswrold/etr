import 'dart:async';
import 'package:etrflying/db/database.dart';
import 'package:etrflying/model/base_model.dart';
import 'package:etrflying/utils/log_util.dart';
import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'collection_tokens.g.dart';

const String tableName = "tokens_table";

@JsonSerializable()
@Entity(tableName: tableName, primaryKeys: ["owner", "contract", "chainid"])
class MCollectionTokens {
  String? owner;
  String? contract;
  String? token;
  String? coinType;
  int? state;
  int? decimals;
  double? price;
  double? balance;
  int? digits;
  int? chainid; //哪条链

  MCollectionTokens({
    this.owner,
    this.contract,
    this.token,
    this.coinType,
    this.state,
    this.decimals,
    this.price,
    this.balance,
    this.digits,
    this.chainid,
  });

  factory MCollectionTokens.fromJson(Map<String, dynamic> json) =>
      _$MCollectionTokensFromJson(json);
  Map<String, dynamic> toJson() => _$MCollectionTokensToJson(this);

  static MCollectionTokens getEthLocalToken(String owner) {
    MCollectionTokens token = MCollectionTokens();
    token.coinType = "ETH";
    token.token = "ETH";
    token.owner = owner;
    token.contract = "";
    token.decimals = 18;
    token.digits = 6;
    return token;
  }

  static Future<List<MCollectionTokens>> findTokens(
      String owner, int chainID) async {
    try {
      FlutterDatabase? database = await (BaseModel.getDataBae());
      List<MCollectionTokens>? datas =
          await database?.tokensDao.findTokens(owner, chainID);
      return datas ?? [];
    } catch (e) {
      LogUtil.v("失败" + e.toString());
      return [];
    }
  }

  static Future<List<MCollectionTokens>> findAllTokens(int chainID) async {
    try {
      FlutterDatabase? database = await (BaseModel.getDataBae());
      List<MCollectionTokens>? datas =
          await database?.tokensDao.findAllTokens(chainID);
      return datas ?? [];
    } catch (e) {
      LogUtil.v("失败" + e.toString());
      return [];
    }
  }

  static Future<List<MCollectionTokens>> findStateTokens(
      String s, int i, int chainID) async {
    try {
      FlutterDatabase? database = await (BaseModel.getDataBae());
      List<MCollectionTokens>? datas =
          await database?.tokensDao.findStateTokens(s, i, chainID);
      datas ??= [];
      for (var item in datas) {
        if (item.token == "ETH") {
          datas.remove(item);
          datas.insert(0, item);
        }
        if (item.token == "ZKTR") {
          datas.remove(item);
          datas.insert(1, item);
        }
      }
      return datas;
    } catch (e) {
      LogUtil.v("失败" + e.toString());
      return [];
    }
  }

  static void insertToken(MCollectionTokens model) async {
    try {
      model.contract = model.contract?.toLowerCase();
      FlutterDatabase? database = await (BaseModel.getDataBae());
      await database?.tokensDao.insertToken(model);
    } catch (e) {
      LogUtil.v("失败" + e.toString());
    }
  }

  static void insertTokens(List<MCollectionTokens> models) async {
    try {
      FlutterDatabase? database = await (BaseModel.getDataBae());
      await database?.tokensDao.insertTokens(models);
    } catch (e) {
      LogUtil.v("失败" + e.toString());
    }
  }

  static void deleteTokens(MCollectionTokens model) async {
    try {
      FlutterDatabase? database = await (BaseModel.getDataBae());

      await database?.tokensDao.deleteTokens(model);
    } catch (e) {
      LogUtil.v("失败" + e.toString());
    }
  }

  static void updateTokens(MCollectionTokens model) async {
    try {
      FlutterDatabase? database = await (BaseModel.getDataBae());
      await database?.tokensDao.updateTokens(model);
    } catch (e) {
      LogUtil.v("失败" + e.toString());
    }
  }

  bool get isToken =>
      coinType?.toLowerCase() == token?.toLowerCase() ? false : true;

  String get balanceString =>
      (this.balance ?? 0.0).toStringAsFixed(this.digits ?? 4);

  String get assets => ((price ?? 0.0) * (balance ?? 0.0)).toStringAsFixed(2);
}

@dao
abstract class MCollectionTokenDao {
  @Query('SELECT * FROM ' +
      tableName +
      ' WHERE owner = :owner and chainid=:chainid')
  Future<List<MCollectionTokens>> findTokens(String owner, int chainid);

  @Query('SELECT * FROM ' +
      tableName +
      ' WHERE owner = :owner and state = :state and chainid=:chainid')
  Future<List<MCollectionTokens>> findStateTokens(
      String owner, int state, int chainid);

  @Query('SELECT * FROM ' + tableName + ' WHERE  chainid=:chainid')
  Future<List<MCollectionTokens>> findAllTokens(int chainid);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertToken(MCollectionTokens model);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertTokens(List<MCollectionTokens> models);

  @delete
  Future<void> deleteTokens(MCollectionTokens model);

  @update
  Future<void> updateTokens(MCollectionTokens model);
}
