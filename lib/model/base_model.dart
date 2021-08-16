import 'package:etrflying/db/database.dart';
import 'package:etrflying/db/database_config.dart';

class BaseModel {
  static Future<FlutterDatabase?> getDataBae() {
    return DataBaseConfig.openDataBase();
  }
}
