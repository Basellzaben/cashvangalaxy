import 'package:cashvangalaxy/Models/Categ.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../Models/CompanyInfo.dart';
import '../Models/Items.dart';
import '../Models/users.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'cashvanPPPC.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE CompanyInfo(id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "Address TEXT,"
          "CID INTEGER,"
          "CName TEXT,"
          "SuperVisor TEXT,"
          "TaxNo1 TEXT,"
          "TaxNo2 TEXT,"
          "AllowDay INTEGER,"
          "Lat TEXT,"
          "Long TEXT,"
          "StartDate TEXT,"
          "CMobile TEXT)",
        );
        await database.execute(
          "CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "man TEXT,"
          "name INTEGER,"
          "MEName TEXT,"
          "StoreNo TEXT,"
          "Stoped TEXT,"
          "SupNo TEXT,"
          "UserName TEXT,"
          "Password TEXT,"
          "MobileNo TEXT,"
          "MobileNo2 TEXT,"
          "MANTYPE TEXT,"
          "AlternativeMan TEXT,"
          "ManSupervisor TEXT,"
          "BranchNo TEXT,"
          "Email TEXT,"
          "SuperVisor_name TEXT,"
          "SampleSerial TEXT,"
          "Sname TEXT,"
          "Acc TEXT,"
          "AccName TEXT,"
          "PosAcc TEXT,"
          "PosAccName TEXT,"
          "MaxBouns TEXT,"
          "MaxDiscount TEXT,"
          "MobileNoSupervisor TEXT)",
        );
        await database.execute(
          "CREATE TABLE Categ(id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "ItemCode TEXT,"
          "CategNo TEXT,"
          "price TEXT,"
          "MinPrice TEXT,"
          "dis TEXT,"
          "bonus TEXT,"
          "UnitNo TEXT)",
        );

        await database.execute(
          "CREATE TABLE items(id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "Item_No TEXT,"
          "Item_Name TEXT,"
          "Ename TEXT,"
          "Unit TEXT,"
          "Price TEXT,"
          "OL TEXT,"
          "Type_No TEXT,"
          "Pack TEXT,"
          "Place TEXT,"
          "dno TEXT,"
          "tax TEXT,"
          "ItemWeight TEXT,"
          "OQ1 TEXT)",
        );

        await database.execute(
          "CREATE TABLE Customers(id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "No TEXT,"
          "name TEXT,"
          "Ename TEXT,"
          "CUST_PRV_MONTH TEXT,"
          "CUST_NET_BAL TEXT,"
          "Pay_How TEXT,"
          "PAMENT_PERIOD_NO TEXT,"
          "TaxSts TEXT,"
          "CustType TEXT,"
          "barCode TEXT,"
          "Address TEXT,"
          "SMan TEXT,"
          "Latitude,"
          "Longitude,"
          "Note2,"
          "sat,"
          "sun,"
          "mon,"
          "tues,"
          "wens,"
          "thurs,"
          "sat1,"
          "sun1,"
          "mon1,"
          "tues1,"
          "wens1,"
          "thurs1,"
          "Celing,"
          "Chqceling,"
          "CatNo,"
          "State,"
          "Cust_type,"
          "CheckAlowedDay,"
          "PromotionFlag,"
          "CloseVisitWithoutimg,"
          "countryNo,"
          "countryNm,"
          "UpdateDate,"
          "BB,"
          "BB_Chaq,"
          "OQ1 TEXT)",
        );
      },
      version: 26,
    );
  }

  Future<int> insertItems(List<Items> Items) async {
    int result = 0;
    final Database db = await initializeDB();
    for (var Itemss in Items) {
      result = await db.insert('items', Itemss.toMap());
    }
    return result;
  }

  Future<int> insertCateg(List<Categ> categ) async {
    int result = 0;
    final Database db = await initializeDB();
    for (var Catego in categ) {
      result = await db.insert('Categ', Catego.toMap());
    }
    return result;
  }

  Future<int> insertCompanyInfo(List<CompanyInfo> users) async {
    int result = 0;
    final Database db = await initializeDB();
    for (var user in users) {
      result = await db.insert('CompanyInfo', user.toMap());
    }
    return result;
  }

  Future<int> insertusers(List<users> users) async {
    int result = 0;
    final Database db = await initializeDB();
    for (var user in users) {
      result = await db.insert('users', user.toMap());
    }
    return result;
  }

  Future<List<CompanyInfo>> retrieveCompanyInfo() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult =
        await db.query('CompanyInfo');
    return queryResult.map((e) => CompanyInfo.fromMap(e)).toList();
  }

  Future<List<users>> retrieveUsersInfo() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('users');
    return queryResult.map((e) => users.fromMap(e)).toList();
  }

  Future<CompanyInfo> getPersonWithId() async {
    final Database db = await initializeDB();
    var response = await db.query("CompanyInfo");
    return response.isNotEmpty
        ? CompanyInfo.fromMap(response.first)
        : CompanyInfo.fromMap(response.first);
  }

  Future<bool> getLogin(String user, String password) async {
    final Database dbClient = await initializeDB();
    final prefs = await SharedPreferences.getInstance();

    var res = await dbClient.rawQuery(
        "SELECT * FROM users WHERE UserName = '$user' and Password = '$password'");
    if (res.length > 0) {
      await prefs.setString('EMPName', users.fromMap(res.first).name);
      return true;
    }
    return false;
  }

  Future<void> DropCompanyInfo() async {
    final Database db = await initializeDB();
    db.delete('CompanyInfo');
  }

  Future<void> Dropusers() async {
    final Database db = await initializeDB();
    db.delete('users');
  }

  Future<void> DropCateg() async {
    final Database db = await initializeDB();
    db.delete('Categ');
  }
}
