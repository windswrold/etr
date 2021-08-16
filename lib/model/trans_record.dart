import 'package:etrflying/db/database.dart';
import 'package:etrflying/model/tr_wallet.dart';
import 'package:etrflying/net/chain_services.dart';
import 'package:etrflying/public.dart';
import 'package:etrflying/utils/log_util.dart';
import 'package:floor/floor.dart';

import 'base_model.dart';

const String tableName = "translist_table";

@Entity(tableName: tableName)
class TransRecordModel {
  @primaryKey
  String? txid; //交易ID
  String? toAdd; //to
  String? fromAdd; //from
  String? date; //时间
  String? amount; //金额
  String? remarks; //备注
  String? fee; //手续费
  String? gasPrice;
  String? gasLimit;
  int? transStatus; //0失败 1成功
  String? token; //转账符号
  String? coinType;
  //自定义字段
  int? transType; //转入转出类型
  int? chainid; //哪条链
  int? blockHeight;
  int? confirmations;
  TransRecordModel({
    this.txid,
    this.toAdd,
    this.fromAdd,
    this.date,
    this.amount,
    this.remarks,
    this.fee,
    this.transStatus,
    this.token,
    this.coinType,
    this.gasLimit,
    this.gasPrice,
    this.transType,
    this.chainid,
    this.blockHeight,
    this.confirmations,
  });

  Future updateTransState(BuildContext context) async {
    String tx = this.txid!;
    TRWallet wallets =
        Provider.of<CurrentChooseWalletState>(context, listen: false)
            .currentWallet;

    String url = "";
    if (wallets.coinType! == KCoinType.ETH.index) {
      url = ethNode.content;
    } else {
      url = bscNode.content;
    }
    dynamic result = await ChainServices.requestTransactionReceipt(url, tx);
    if (result != null &&
        result is Map &&
        result.keys.contains("result") &&
        result["result"] != null) {
      String status = result["result"]["status"];
      String blocknum = result["result"]["blockNumber"];
      int blockNumber = int.parse(blocknum.replaceAll("0x", ""), radix: 16);
      this.blockHeight = blockNumber;
      if (status == "0x1") {
        this.transStatus = MTransState.Success.index;
        return TransRecordModel.updateTrxList(this);
      } else {
        this.transStatus = MTransState.Failere.index;
        return TransRecordModel.updateTrxList(this);
      }
    }
  }

  static Future<List<TransRecordModel>> queryTrxList(
      String from, String symbol, int chainid, int transType) async {
    try {
      FlutterDatabase? database = await (BaseModel.getDataBae());
      if (transType == MTransListType.All.index ||
          transType == MTransListType.Failere.index) {
        List<TransRecordModel> dbs =
            await database?.transListDao.queryTrxList(from, symbol, chainid) ??
                [];
        List<TransRecordModel> datas = [];
        dbs.forEach((element) {
          if (transType == MTransListType.All.index) {
            datas.add(element);
          }
          if (transType == MTransListType.Failere.index &&
              element.transStatus! == MTransState.Failere.index) {
            datas.add(element);
          }
        });
        return datas;
      } else {
        return await database?.transListDao
                .queryTrxListWithType(from, symbol, chainid, transType) ??
            [];
      }
    } catch (e) {
      LogUtil.v("失败" + e.toString());
      return [];
    }
  }

  static Future<List<TransRecordModel>> queryPendingTrxList(
      String from, String symbol, int chainid) async {
    try {
      FlutterDatabase? database = await (BaseModel.getDataBae());
      List<TransRecordModel>? datas = await database?.transListDao
          .queryPendingTrxList(from, symbol, chainid);
      return datas ?? [];
    } catch (e) {
      LogUtil.v("失败" + e.toString());
      return [];
    }
  }

  static Future<List<TransRecordModel>> queryAllList() async {
    try {
      FlutterDatabase? database = await (BaseModel.getDataBae());
      List<TransRecordModel>? datas =
          await database?.transListDao.queryAllTrx();
      return datas ?? [];
    } catch (e) {
      LogUtil.v("失败" + e.toString());
      return [];
    }
  }

  static Future<List<TransRecordModel>> queryTrxFromTrxid(String txid) async {
    try {
      FlutterDatabase? database = await (BaseModel.getDataBae());
      List<TransRecordModel>? datas =
          await database?.transListDao.queryTrxFromTrxid(txid);
      return datas ?? [];
    } catch (e) {
      LogUtil.v("失败" + e.toString());
      return [];
    }
  }

  static void insertTrxList(TransRecordModel model) async {
    try {
      FlutterDatabase? database = await (BaseModel.getDataBae());
      database?.transListDao.insertTrxList(model);
    } catch (e) {
      LogUtil.v("失败" + e.toString());
    }
  }

  static void insertTrxLists(List<TransRecordModel> models) async {
    try {
      FlutterDatabase? database = await (BaseModel.getDataBae());
      database?.transListDao.insertTrxLists(models);
    } catch (e) {
      LogUtil.v("失败" + e.toString());
    }
  }

  static void deleteTrxList(TransRecordModel model) async {
    try {
      FlutterDatabase? database = await (BaseModel.getDataBae());
      database?.transListDao.deleteTrxList(model);
    } catch (e) {
      LogUtil.v("失败" + e.toString());
    }
  }

  static void updateTrxList(TransRecordModel model) async {
    try {
      FlutterDatabase? database = await (BaseModel.getDataBae());
      database?.transListDao.updateTrxList(model);
    } catch (e) {
      LogUtil.v("失败" + e.toString());
    }
  }

  static void updateTrxLists(List<TransRecordModel> models) async {
    try {
      FlutterDatabase? database = await (BaseModel.getDataBae());
      database?.transListDao.updateTrxLists(models);
    } catch (e) {
      LogUtil.v("失败" + e.toString());
    }
  }
}

@dao
abstract class TransRecordModelDao {
  @Query('SELECT * FROM ' +
      tableName +
      ' WHERE (fromAdd = :fromAdd)  and token = :token and chainid = :chainid ORDER BY date DESC')
  Future<List<TransRecordModel>> queryTrxList(
      String fromAdd, String token, int chainid);

  @Query('SELECT * FROM ' +
      tableName +
      ' WHERE (fromAdd = :fromAdd)  and token = :token and chainid = :chainid and transType =:transType ORDER BY date DESC')
  Future<List<TransRecordModel>> queryTrxListWithType(
      String fromAdd, String token, int chainid, int transType);

  @Query('SELECT * FROM ' +
      tableName +
      ' WHERE (fromAdd = :fromAdd)  and token = :token and chainid = :chainid and (transStatus = 0)  ORDER BY date DESC')
  Future<List<TransRecordModel>> queryPendingTrxList(
      String fromAdd, String token, int chainid);

  @Query('SELECT * FROM ' + tableName + ' WHERE txid = :txid')
  Future<List<TransRecordModel>> queryTrxFromTrxid(String txid);

  @Query('SELECT * FROM ' + tableName)
  Future<List<TransRecordModel>> queryAllTrx();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertTrxList(TransRecordModel model);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertTrxLists(List<TransRecordModel> models);

  @delete
  Future<void> deleteTrxList(TransRecordModel model);

  @update
  Future<void> updateTrxList(TransRecordModel model);

  @update
  Future<void> updateTrxLists(List<TransRecordModel> models);
}
