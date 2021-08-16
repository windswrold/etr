// import 'dart:html';

import 'package:etrflying/db/database.dart';
import 'package:etrflying/model/base_model.dart';
import 'package:etrflying/model/chain/eth.dart';
import 'package:etrflying/public.dart';
import 'package:etrflying/utils/log_util.dart';
import 'package:floor/floor.dart';

// const String tableName = "nodes_table";

// @Entity(tableName: tableName, primaryKeys: ["content", "chainType"])
class NodeModel {
  String content;
  int chainType;
  bool isChoose;
  int chainID; //ID

  NodeModel(this.content, this.chainType, this.isChoose, this.chainID);

  // static Future<List<NodeModel>?> _configNodeData() async {
  //   List<NodeModel>? nodes = await NodeModel.queryNodeByIsChoose(true);
  //   if (nodes == null || nodes.length == 0) {
  //     nodes = [];
  //     NodeModel ethmain = NodeModel(
  //         "https://mainnet.infura.io/v3/fbd05acd5b5c4b2a857720141485416d",
  //         KCoinType.ETH.index,
  //         false,
  //         ETHChainID.Mainnet.getChainId());
  //     NodeModel ethrinkeby = NodeModel(
  //         "https://rinkeby.infura.io/v3/fbd05acd5b5c4b2a857720141485416d",
  //         KCoinType.ETH.index,
  //         true,
  //         ETHChainID.Rinkeby.getChainId());
  //     NodeModel bscmain = NodeModel("https://bsc-dataseed.binance.org",
  //         KCoinType.BSC.index, false, BSCChainID.Mainnet.getChainId());
  //     NodeModel bscrinkeby = NodeModel(
  //         "https://data-seed-prebsc-1-s1.binance.org:8545",
  //         KCoinType.BSC.index,
  //         true,
  //         BSCChainID.Testnet.getChainId());
  //     nodes.add(ethmain);
  //     nodes.add(ethrinkeby);
  //     nodes.add(bscmain);
  //     nodes.add(bscrinkeby);
  //     NodeModel.insertNodeDatas(nodes);
  //     return [ethrinkeby, bscrinkeby];
  //   }
  //   return nodes;
  // }

  // static Future<bool> insertNodeDatas(List<NodeModel> list) async {
  //   try {
  //     FlutterDatabase? database = await BaseModel.getDataBae();
  //     database?.nodeDao.insertNodeDatas(list);
  //     return true;
  //   } catch (e) {
  //     LogUtil.v("失败" + e.toString());
  //   }
  //   return false;
  // }

  // static Future<bool> insertNodeData(NodeModel model) async {
  //   try {
  //     FlutterDatabase? database = await (BaseModel.getDataBae());
  //     database?.nodeDao.insertNodeData(model);
  //     return true;
  //   } catch (e) {
  //     LogUtil.v("失败" + e.toString());
  //   }
  //   return false;
  // }

  // static Future<List<NodeModel>?> queryNodeByChainType(int chainType) async {
  //   try {
  //     FlutterDatabase? database = await (BaseModel.getDataBae());
  //     return database?.nodeDao.queryNodeByChainType(chainType);
  //   } catch (e) {
  //     LogUtil.v("失败" + e.toString());
  //     return null;
  //   }
  // }

  // static Future<List<NodeModel>?> queryNodeByIsChoose(bool isChoose) async {
  //   try {
  //     FlutterDatabase? database = await (BaseModel.getDataBae());
  //     return database?.nodeDao.queryNodeByIsChoose(isChoose);
  //   } catch (e) {
  //     LogUtil.v("失败" + e.toString());
  //     return null;
  //   }
  // }

  // static Future<NodeModel?> queryChainNodeByChoose(
  //     bool isChoose, int chainType) async {
  //   try {
  //     FlutterDatabase? database = await (BaseModel.getDataBae());
  //     return database?.nodeDao.queryChainNodeByChoose(isChoose, chainType);
  //   } catch (e) {
  //     LogUtil.v("失败" + e.toString());
  //     return null;
  //   }
  // }

  // static Future<bool> updateNode(NodeModel model) async {
  //   try {
  //     FlutterDatabase? database = await (BaseModel.getDataBae());
  //     database?.nodeDao.updateNode(model);
  //     return true;
  //   } catch (e) {
  //     LogUtil.v("失败" + e.toString());
  //     return false;
  //   }
  // }

  // static Future<bool> updateNodes(List<NodeModel> models) async {
  //   try {
  //     FlutterDatabase? database = await (BaseModel.getDataBae());
  //     database?.nodeDao.updateNodes(models);
  //     return true;
  //   } catch (e) {
  //     LogUtil.v("失败" + e.toString());
  //     return false;
  //   }
  // }
}

// @dao
// abstract class NodeDao {
//   @Insert(onConflict: OnConflictStrategy.replace)
//   Future<void> insertNodeDatas(List<NodeModel> list);

//   @Insert(onConflict: OnConflictStrategy.replace)
//   Future<void> insertNodeData(NodeModel model);

//   @Query('SELECT * FROM $tableName WHERE isChoose = :isChoose')
//   Future<List<NodeModel>> queryNodeByIsChoose(bool isChoose);

//   @Query('SELECT * FROM $tableName WHERE chainType = :chainType')
//   Future<List<NodeModel>> queryNodeByChainType(int chainType);

//   @Query(
//       'SELECT * FROM $tableName WHERE isChoose = :isChoose And chainType = :chainType')
//   Future<NodeModel?> queryChainNodeByChoose(bool isChoose, int chainType);

//   @update
//   Future<void> updateNode(NodeModel model);

//   @update
//   Future<void> updateNodes(List<NodeModel> models);
// }
