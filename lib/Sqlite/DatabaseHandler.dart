import 'package:cashvangalaxy/Models/Categ.dart';
import 'package:cashvangalaxy/Models/UnitItem.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../Models/CompanyInfo.dart';
import '../Models/Customers.dart';
import '../Models/Items.dart';
import '../Models/MaxOrder.dart';
import '../Models/SalesInvoiceD.dart';
import '../Models/SalesInvoiceH.dart';
import '../Models/Unites.dart';
import '../Models/salDetails.dart';
import '../Models/users.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();

    return openDatabase(
      join(path, 'cashsystemmqgteerg.db'),
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
          "CREATE TABLE Unites(id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "Unitno TEXT,"
          "UnitName TEXT,"
          "UnitEname TEXT)",
        );

        await database.execute(
          "CREATE TABLE salDetails(id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "name TEXT,"
          "itemno TEXT,"
          "netprice TEXT,"
          "dis TEXT,"
          "bounse TEXT,"
          "qt TEXT,"
          "unit TEXT,"
          "distype TEXT,"
          "tax TEXT,"
          "price TEXT)",
        );

        await database.execute(
          "CREATE TABLE MaxOrder(id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "Sales TEXT,"
          "Payment TEXT,"
          "SalesOrder TEXT,"
          "PrepareQty TEXT,"
          "RetSales TEXT,"
          "PostDely TEXT,"
          "ReturnQty TEXT,"
          "CustCash TEXT,"
          "EnterQty TEXT,"
          "TransferQty TEXT,"
          "ItemRecepit TEXT,"
          "Visits TEXT)",
        );
        await database.execute(
          "CREATE TABLE SalesInvoiceD(id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "Bounce TEXT,"
          "DisAmtFromHdr TEXT,"
          "DisPerFromHdr TEXT,"
          "Dis_Amt TEXT,"
          "Discount TEXT,"
          "ItemOrgPrice TEXT,"
          "Operand TEXT,"
          "ProID TEXT,"
          "Pro_amt TEXT,"
          "Pro_bounce TEXT,"
          "Pro_dis_Per TEXT,"
          "Unite TEXT,"
          "UniteNm TEXT,"
          "name TEXT,"
          "no TEXT ,"
          "price TEXT,"
          "pro_Total TEXT,"
          "qty TEXT,"
          "tax TEXT,"
          "tax_Amt TEXT,"
          "total TEXT,"
          "distype TEXT,"
          "orderno TEXT ,"
          "weight TEXT)",
        );

        await database.execute(
          "CREATE TABLE SalesInvoiceH(id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "Cust_No TEXT,"
          "Date TEXT,"
          "UserID TEXT,"
          "OrderNo TEXT UNIQUE not null,"
          "hdr_dis_per TEXT,"
          "hdr_dis_value TEXT,"
          "Total TEXT,"
          "Net_Total TEXT,"
          "Tax_Total TEXT,"
          "bounce_Total TEXT,"
          "include_Tax TEXT,"
          "disc_Total TEXT,"
          "inovice_type TEXT,"
          "CashCustNm TEXT,"
          "V_OrderNo TEXT,"
          "DocType TEXT,"
          "DriverNo TEXT,"
          "Pos_System TEXT,"
          "OrderDesc TEXT,"
          "MOVE TEXT,"
          "posted TEXT ,"
          "GSPN TEXT)",
        );

        await database.execute(
          "CREATE TABLE UnitItem(id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "item_no TEXT,"
          "barcode TEXT,"
          "unitno TEXT,"
          "Operand TEXT,"
          "price TEXT,"
          "Max TEXT,"
          "Min TEXT,"
          "posprice TEXT,"
          "acc_num TEXT,"
          "UnitSale TEXT)",
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
          "BB_Chaq TEXT)",
        );
      },
      version: 32,
    );
  }

  Future<int> DeleteItemfromSalDet(String itemno) async {
    int result = 0;
    final Database db = await initializeDB();
    result =
        await db.delete('salDetails', where: 'itemno = ?', whereArgs: [itemno]);
    return result;
  }

  Future<void> SaveSal(
      String name,
      String itemno,
      String netprice,
      String dis,
      String bounse,
      String qt,
      String unit,
      String distype,
      String price,
      String tax) async {
    final Database dbClient = await initializeDB();
    final List<Map<String, Object?>> queryResult = await dbClient
        .rawQuery("select * from salDetails where itemno='" + itemno + "'");
    Map<String, dynamic> row = {
      'name': name,
      'tax': tax,
      'itemno': itemno,
      'netprice': netprice,
      'dis': dis,
      'qt': qt,
      'unit': unit,
      'bounse': bounse,
      'distype': distype,
      'price': price,
    };
    var res;
    try {
      print("length :" +
          queryResult.map((e) => salDetails.fromMap(e)).toList().first.itemno);
      if (queryResult.map((e) => salDetails.fromMap(e)).toList().first.itemno ==
          itemno) {
        await dbClient.update("salDetails", row,
            where: 'itemno = ?', whereArgs: [itemno]);
      } else {
        await dbClient.insert('salDetails', row);
      }
    } catch (_) {
      await dbClient.insert('salDetails', row);
    }
    print("add row :" + row.toString());

    /* print("add setails statue :"+res.toString());
    print("add row :"+row.toString());
   //await dbClient.insert('salDetails', row);
    res = await dbClient.update("salDetails", row ,where: 'itemno = ?',
        whereArgs: [1011]);*/
  }

  Future<int> insertsalDetails(List<salDetails> categ) async {
    int result = 0;
    final Database db = await initializeDB();
    for (var Catego in categ) {
      result = await db.insert('salDetails', Catego.toMap());
    }
    return result;
  }

  GetMaxSal() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult =
        await db.rawQuery("select * from MaxOrder");
    return queryResult
        .map((e) => MaxOrder.fromMap(e))
        .toList()
        .first
        .Sales
        .toString();
  }

  GetMaxSalOrderNonshare() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult =
        await db.rawQuery("select * from SalesInvoiceH");
    if (queryResult.map((e) => SalesInvoiceH.fromMap(e)).toList().length > 0)
      return queryResult
          .map((e) => SalesInvoiceH.fromMap(e))
          .toList()
          .last
          .OrderNo
          .toString();
    return "0";
  }

  Future<int> insertSalesInvoiceD(List<SalesInvoiceD> categ) async {
    int result = 0;
    final Database db = await initializeDB();

    DeleteSalesInvoiceD(categ.first.orderno).then((value) async => {
    for (var Catego in categ) {
        result = await db.insert('SalesInvoiceD', Catego.toMap())
  }
    });


    return result;
  }

  Future<int> DeleteSalesInvoiceH(String order) async {
   try{
     int result = 0;
     final Database db = await initializeDB();
     result = await db.delete('SalesInvoiceH', where: 'OrderNo= ?',whereArgs: [order]);
     print('deletedooone');
     return result;
   }catch(_){
     return 0;

   }
  }

  Future<int> DeleteSalesInvoiceD(String order) async {
    int result = 0;
    Database db = await initializeDB();
    result = await db.delete('SalesInvoiceD', where: 'orderno = ?', whereArgs: [order]);
    print('deletedooone');
    return result;
  }


  Future<String> CheckPosdted(String OrderNo) async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.rawQuery(
        "select posted from SalesInvoiceH where OrderNo='" + OrderNo + "'");
    if(queryResult
        .map((e) => SalesInvoiceH.fromMap(e))
        .toList().length==0){
      return '0';
    }
    return queryResult
        .map((e) => SalesInvoiceH.fromMap(e))
        .toList()
        .first
        .posted
        .toString();
  }


  Future<int> insertSalesInvoiceH(List<SalesInvoiceH> categ) async {
    DeleteSalesInvoiceH(categ.first.OrderNo);
    int result = 0;
    final Database db = await initializeDB();
    for (var Catego in categ) {
      result = await db.insert('SalesInvoiceH', Catego.toMap());
    }
    return result;
  }

  Future<int> insertMaxOrder(List<MaxOrder> categ) async {
    int result = 0;
    final Database db = await initializeDB();
    for (var Catego in categ) {
      result = await db.insert('MaxOrder', Catego.toMap());
    }
    return result;
  }

  Future<int> insertItems(List<Items> Items) async {
    int result = 0;
    final Database db = await initializeDB();
    for (var Itemss in Items) {
      result = await db.insert('items', Itemss.toMap());
    }
    return result;
  }

  Future<int> insertUnitItem(List<UnitItem> Items) async {
    int result = 0;
    final Database db = await initializeDB();
    for (var Itemss in Items) {
      result = await db.insert('UnitItem', Itemss.toMap());
    }
    return result;
  }

  Future<int> insertCustomers(List<Customers> Items) async {
    int result = 0;
    final Database db = await initializeDB();
    for (var Itemss in Items) {
      result = await db.insert('Customers', Itemss.toMap());
    }
    return result;
  }

  Future<int> insertUnites(List<Unites> Items) async {
    int result = 0;
    final Database db = await initializeDB();
    for (var Itemss in Items) {
      result = await db.insert('Unites', Itemss.toMap());
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

  Future<String> retrieveunitItem(String itemno) async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.rawQuery(
        "select Operand from UnitItem where item_no='" + itemno + "'");
    return queryResult
        .map((e) => UnitItem.fromMap(e))
        .toList()
        .first
        .Operand
        .toString();
  }

  Future<String> retrieveunitName(String unitno) async {
    if(!unitno.contains('.0')){
      unitno=   unitno+".0";
    }
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.rawQuery(
        "select * from Unites where Unitno='" +
            unitno +
            "'");

    print("unitnooooo  : " + unitno+".0" );
    print("unitnooooo2  : " +
        queryResult
            .map((e) => Unites.fromMap(e))
            .toList()
            .first
            .UnitName
            .toString());
    return queryResult
        .map((e) => Unites.fromMap(e))
        .toList()
        .first
        .UnitName
        .toString();
  }

  Future<List<Items>> retrieveItems() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('items');
    return queryResult.map((e) => Items.fromMap(e)).toList();
  }

  Future<List<Map<String, dynamic>>> retrieveItems2() async {
    final Database db = await initializeDB();
    return db.query('items', orderBy: "Item_No");
  }

  GetHdrIncludeTax(String OrderNo) async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult =
    await db.rawQuery("select include_Tax from SalesInvoiceH where OrderNo='" + OrderNo + "'");

    print(queryResult
        .map((e) => SalesInvoiceH.fromMap(e))
        .toList()
        .last
        .include_Tax
        .toString()+" include_Tax ");

    return queryResult
          .map((e) => SalesInvoiceH.fromMap(e))
          .toList()
          .last
          .include_Tax
          .toString();
    return "0";
  }


  Future<List<Map<String, dynamic>>> retrievesalDetailsById(
      String orderni) async {
    final Database db = await initializeDB();
    return db.query('SalesInvoiceD',
        orderBy: "orderno", where: "orderno='" + orderni + "'");
    // return db.query('salDetails', orderBy: "itemno");
  }

  Future<List<Map<String, dynamic>>> retrievesalDetails() async {
    final Database db = await initializeDB();
    return db.query('salDetails', orderBy: "itemno");
  }

  Future<List<Map<String, dynamic>>> SalOrderHDR() async {
    final Database db = await initializeDB();
    return db.query('SalesInvoiceH', orderBy: "OrderNo");
  }

  Future<List<Map<String, dynamic>>> retrieveItems2search(
      String? search) async {
    final Database db = await initializeDB();
    if (search != null) if (search.isNotEmpty) {
      return db.query('items',
          orderBy: "Item_No", where: " Item_Name" " LIKE  '%" + search + "%'");
    }

    if (search == "All") {
      return db.query('items', orderBy: "Item_No");
    }
    return db.query('items', orderBy: "Item_No");
  }

  Future<List<Map<String, dynamic>>> retrieveUnitesOfItem(
      String? itemno) async {
    final Database db = await initializeDB();
    if (itemno != null) if (itemno.isNotEmpty) {
      return db.rawQuery(
          "SELECT Unites.UnitName,Unites.Unitno FROM Unites INNER JOIN "
                  "UnitItem ON Unites.Unitno=UnitItem.unitno where "
                  "UnitItem.item_no='" +
              itemno +
              "'");
    }
    if (itemno == "All") {
      return db.query("SELECT Unites.UnitName FROM Unites", orderBy: "item_no");
    }
    return db.query("SELECT Unites.UnitName FROM Unites", orderBy: "item_no");
  }

  retrieveprice(String itemno, String unitno, String catNo) async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.rawQuery(
        "select * from Categ" +
            " where ItemCode='" +
            itemno +
            "' and UnitNo='" +
            unitno +
            "' and CategNo='" +
            catNo +
            "'");

    final List<Map<String, Object?>> queryResult2 = await db.rawQuery(
        "select * from UnitItem" +
            " where item_no='" +
            itemno +
            "' and unitno='" +
            unitno +
            "'");
    try {
      if (!queryResult
              .map((e) => Categ.fromMap(e))
              .toList()
              .first
              .price
              .isEmpty &&
          queryResult.map((e) => Categ.fromMap(e)).toList().first.price !=
              "0.0") {
        return queryResult
            .map((e) => Categ.fromMap(e))
            .toList()
            .first
            .price
            .toString();
      } else if (!queryResult2
              .map((e) => Categ.fromMap(e))
              .toList()
              .first
              .price
              .isEmpty &&
          queryResult2.map((e) => Categ.fromMap(e)).toList().first.price !=
              "0.0") {
        return queryResult2
            .map((e) => Categ.fromMap(e))
            .toList()
            .first
            .price
            .toString();
      }
    } catch (_) {}

    return "0.0";
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
      await prefs.setString('EMPMan', users.fromMap(res.first).man);
      await prefs.setString('MaxDiscount',
          users.fromMap(res.first).MaxDiscount.toString() + " % ");
      await prefs.setString(
          'MaxBouns', users.fromMap(res.first).MaxBouns.toString() + " % ");

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

  Future<void> DropItems() async {
    final Database db = await initializeDB();
    db.delete('items');
  }

  Future<void> DropUnitItem() async {
    final Database db = await initializeDB();
    db.delete('UnitItem');
  }

  Future<void> DropUnites() async {
    final Database db = await initializeDB();
    db.delete('Unites');
  }

  Future<void> DropMaxOrder() async {
    final Database db = await initializeDB();
    db.delete('MaxOrder');
  }

  Future<void> DropCustomers() async {
    final Database db = await initializeDB();
    db.delete('Customers');
  }

  Future<void> DropsalDetails() async {
    final Database db = await initializeDB();
    db.delete('salDetails');
  }

  Future<List<Map<String, dynamic>>> GetCustomersList(
      String? search, String? day) async {
    print(day);
    final Database db = await initializeDB();
    if (search != null) if (search.isNotEmpty) {
      return db.query('Customers',
          orderBy: "No",
          where: "( name" " LIKE  '%" +
              search +
              "%' or No LIKE '%" +
              search +
              "%') and " +
              day!);
    }

    if (search == "All") {
      return db.query('Customers', orderBy: "No", where: day);
    }
    return db.query('Customers', orderBy: "No", where: day);
  }


  Future<int> UpdatePosted(String OrderNo, String posted) async {
    final Database db = await initializeDB();
    OrderNo=(int.parse(OrderNo)-1).toString();
     // return await db.update();
    print("updated "+OrderNo);

    return await db.update('SalesInvoiceH',
        {'posted' : posted},
        where: "OrderNo = ?",
        whereArgs: [OrderNo]);

    return await db.rawUpdate('UPDATE SalesInvoiceH SET posted = ? WHERE OrderNo = ?', [posted,OrderNo]);
    //  return await db.rawUpdate("UPDATE SalesInvoiceH SET posted = '"+posted+"'  WHERE OrderNo = '"+OrderNo+"'");
  }
}
