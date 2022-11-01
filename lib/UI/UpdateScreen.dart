import 'dart:async';
import 'dart:convert';

import 'package:cashvangalaxy/Models/CompanyInfo.dart';
import 'package:cashvangalaxy/provider/CompanyProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../GlobalVar.dart';
import '../HexaColor.dart';
import '../Models/Categ.dart';
import '../Models/Items.dart';
import '../Models/users.dart';
import '../Sqlite/DatabaseHandler.dart';
import '../Sqlite/SharePrefernce.dart';
import 'Home.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: HexColor(Globalvireables.basecolor),
      ),
      home: UpdateScreen(),
    ));

class UpdateScreen extends StatefulWidget {
  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

var i = 0;
var checkedValue = true;

List<bool> CheckSelected = [false, false,false,false];
List<String> messageupdate = ["", "", "", ""];
List<String> updateitems = ["معلومات المؤسسة", 'المستخدمين', 'فئات العملاء', 'المواد'];

class _UpdateScreenState extends State<UpdateScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<CompanyProvider>(context);

    final handler = DatabaseHandler();

    return Stack(
      children: <Widget>[
        Image.asset(
          "assets/updateback.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
            backgroundColor: HexColor(Globalvireables.white2),

            // backgroundColor: HexColor(Globalvireables.white2),
            body: SizedBox(
                child: SizedBox(
                    child: Container(
                        child: Column(children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              //   userProvider.addingUsers();

                              Navigator.of(context).pop();
                            });
                          },
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 30.0,
                              color: HexColor(Globalvireables.black2),
                            ),
                          )),
                      Spacer(),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              /*FillData().whenComplete(() => (){

                              });*/
                            });
                          },
                          child: Text(
                            "تحديث البيانات",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ))
                    ],
                  )),
              Container(
                margin: EdgeInsets.only(top: 50),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: CheckboxListTile(
                                checkColor: HexColor(Globalvireables.white),
                                title: Text(
                                  "معلومات المؤسسة",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w900),
                                ),
                                //    <-- label
                                value: CheckSelected[0],
                                onChanged: (newValue) {
                                  setState(() {
                                    CheckSelected[0] = newValue!;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: CheckboxListTile(
                                checkColor: HexColor(Globalvireables.white),
                                title: Text(
                                  "المستخدمين",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w900),
                                ),
                                //    <-- label
                                value: CheckSelected[1],
                                onChanged: (newValue) {
                                  setState(() {
                                    CheckSelected[1] = newValue!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),


                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: CheckboxListTile(
                                checkColor: HexColor(Globalvireables.white),
                                title: Text(
                                  "المواد",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w900),
                                ),
                                //    <-- label
                                value: CheckSelected[3],
                                onChanged: (newValue) {
                                  setState(() {
                                    CheckSelected[3] = newValue!;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: CheckboxListTile(
                                checkColor: HexColor(Globalvireables.white),
                                title: Text(
                                  "فئات العملاء",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w900),
                                ),
                                //    <-- label
                                value: CheckSelected[2],
                                onChanged: (newValue) {
                                  setState(() {
                                    CheckSelected[2] = newValue!;
                                  });
                                },
                              ),
                            ),
                          ),

                        ],
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 20),
                        width: MediaQuery.of(context).size.width / 3,
                        color: HexColor(Globalvireables.basecolor),
                        child: TextButton(
                          onPressed: () {
                            //showLoaderDialog(context);

                            //.delayed(Duration.zero, () => yourFunc(context));

                            FillData();
                          },
                          child: Text(
                            'تحديث البيانات',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ])))))
      ],
    );
  }

  Future<void> FillData() async {
    showLoaderDialog(context);

    if (CheckSelected[0] == true) {
      handler.DropCompanyInfo();

      // showLoaderDialog(context);
      Uri apiUrl = Uri.parse(Globalvireables.GetCInfo);

      http.Response response = await http.get(apiUrl).whenComplete(() => () {});
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        print(jsonResponse.toString() + "reqquestt");

        String receivedJson = jsonResponse;
        List<dynamic> list = json.decode(receivedJson);

        if (response.body.isNotEmpty) {
          jsonResponse = json.decode(response.body);
        } else {
          print(CompanyInfo.fromJson(jsonDecode(jsonResponse[0])).CName);
        }

        jsonResponse = json.decode(response.body)[0];
        handler.initializeDB().whenComplete(() async {
          CompanyInfo firstUser = CompanyInfo(
            ID: 4,
            CName: CompanyInfo.fromJson((list[0])).CName,
            Address: CompanyInfo.fromJson((list[0])).Address,
            SuperVisor: CompanyInfo.fromJson((list[0])).SuperVisor,
            TaxNo1: CompanyInfo.fromJson((list[0])).TaxNo1,
            TaxNo2: CompanyInfo.fromJson((list[0])).TaxNo2,
            AllowDay: CompanyInfo.fromJson((list[0])).AllowDay,
            Lat: CompanyInfo.fromJson((list[0])).Lat,
            Long: CompanyInfo.fromJson((list[0])).Long,
            StartDate: CompanyInfo.fromJson((list[0])).StartDate,
            CMobile: CompanyInfo.fromJson((list[0])).CMobile,
          );

          int i = await addCompanyInfo(firstUser);
          print(i.toString() + " iiiii");
          if (i > 0) {
            // Navigator.pop(context);
            SharePrefernce.setR('CName', CompanyInfo.fromJson((list[0])).CName);
            messageupdate[1] = 'تم التحديث';
            FillDataUsers();

            // Navigator.pop(context);
            // Navigator.of(context, rootNavigator: true).pop();
          } else {
            messageupdate[1] = 'فشل التحديث';
            FillDataUsers();
          }
        });
      } else {
        FillDataUsers();

        messageupdate[0] = 'فشل التحديث';
        // Navigator.pop(context);
      }
    } else {
      messageupdate[0] = 'لم يتم التحديث';
      FillDataUsers();
      //  Navigator.pop(context);
      print("error");
      //  showCustomDialog(context);
    }
  }

  Future<void> FillDataUsers() async {
    if (CheckSelected[1] == true) {
      handler.Dropusers();

      // showLoaderDialog(context);
      Uri apiUrl = Uri.parse(Globalvireables.GetUsers);

      http.Response response = await http.get(apiUrl).whenComplete(() => () {});
      if (response.statusCode == 200) {
        handler.Dropusers();
        var jsonResponse = json.decode(response.body);
        print(jsonResponse.toString() + "reqquestt");
        String receivedJson = jsonResponse;
        List<dynamic> list = json.decode(receivedJson);
        if (response.body.isNotEmpty) {
          jsonResponse = json.decode(response.body);
        } else {
          print(users.fromJson(jsonDecode(jsonResponse[0])).Sname);
        }

        for (int j = 0; j < list.length; j++) {
          jsonResponse = json.decode(response.body)[i];
          handler.initializeDB().whenComplete(() async {
            users firstUser = users(
                man: users.fromJson((list[j])).man,
                name: users.fromJson((list[j])).name,
                MEName: users.fromJson((list[j])).MEName,
                StoreNo: users.fromJson((list[j])).StoreNo,
                Stoped: users.fromJson((list[j])).Stoped,
                SupNo: users.fromJson((list[j])).SupNo,
                UserName: users.fromJson((list[j])).UserName,
                Password: users.fromJson((list[j])).Password,
                MobileNo: users.fromJson((list[j])).MobileNo,
                MobileNo2: users.fromJson((list[j])).MobileNo2,
                MANTYPE: users.fromJson((list[j])).MANTYPE,
                AlternativeMan: users.fromJson((list[j])).AlternativeMan,
                ManSupervisor: users.fromJson((list[j])).ManSupervisor,
                BranchNo: users.fromJson((list[j])).BranchNo,
                Email: users.fromJson((list[j])).Email,
                SuperVisor_name: users.fromJson((list[j])).SuperVisor_name,
                SampleSerial: users.fromJson((list[j])).SampleSerial,
                Sname: users.fromJson((list[j])).Sname,
                Acc: users.fromJson((list[j])).Acc,
                AccName: users.fromJson((list[j])).AccName,
                PosAcc: users.fromJson((list[j])).PosAcc,
                PosAccName: users.fromJson((list[j])).PosAccName,
                MaxBouns: users.fromJson((list[j])).MaxBouns,
                MaxDiscount: users.fromJson((list[j])).MaxDiscount,
                MobileNoSupervisor:
                    users.fromJson((list[j])).MobileNoSupervisor);

            int i = await addUsers(firstUser);
            print(i.toString() + " iiiii");
            if (i > 0) {
              SharePrefernce.setR('CName', users.fromJson((list[0])).Sname);

              messageupdate[1] = 'تم التحديث';

              //  UpdateStateDialog();
              FillCateg();
              // Navigator.of(context, rootNavigator: true).pop();
            } else {
              FillCateg();

              messageupdate[1] = 'فشل التحديث';
              //UpdateStateDialog();
            }
          });
        }
      } else {
        messageupdate[1] = 'فشل التحديث';
        FillCateg();


        //  UpdateStateDialog();
      }
    } else {
      messageupdate[1] = 'لم يتم التحديث';
      FillCateg();

      //  Navigator.pop(context);
      print("error");
      //UpdateStateDialog();
    }
    if (mounted)
      FillCateg();
    else
      FillCateg();

  }


  Future<void> FillCateg() async {
    if (CheckSelected[2] == true) {
      handler.DropCateg();

      // showLoaderDialog(context);
      Uri apiUrl = Uri.parse(Globalvireables.GetCateg);

      http.Response response = await http.get(apiUrl).whenComplete(() => () {});
      if (response.statusCode == 200) {
        handler.DropCateg();
        var jsonResponse = json.decode(response.body);
        print(jsonResponse.toString() + "reqquestt");
        String receivedJson = jsonResponse;
        List<dynamic> list = json.decode(receivedJson);
        if (response.body.isNotEmpty) {
          jsonResponse = json.decode(response.body);
        } else {
          print(users.fromJson(jsonDecode(jsonResponse[0])).Sname);
        }

      //  print(Categ.fromJson((list[0])).ItemCode.toString() +"   listtttta");
        for (int j = 0; j < list.length; j++) {
         // jsonResponse = json.decode(response.body)[i];
          handler.initializeDB().whenComplete(() async {
           // print(Categ.fromJson((list[j])).ItemCode.toString()+"  dddatatta");

            Categ firstUser = Categ(
            ItemCode: Categ.fromMap((list[j])).ItemCode.toString(),
            CategNo: Categ.fromMap((list[j])).CategNo.toString(),
            price: Categ.fromMap((list[j])).price.toString(),
            MinPrice: Categ.fromMap((list[j])).MinPrice.toString(),
            dis: Categ.fromMap((list[j])).dis.toString(),
              bonus: Categ.fromMap((list[j])).bonus.toString(),
            UnitNo: Categ.fromMap((list[j])).UnitNo.toString(),
                );

            int i = await addCateg(firstUser);
            print(i.toString() + " iiiii");
            if (i > 0) {
              messageupdate[2] = 'تم التحديث';

              //  UpdateStateDialog();

              // Navigator.of(context, rootNavigator: true).pop();
            } else {

              messageupdate[2] = 'فشل التحديث';
              //UpdateStateDialog();
            }
          });
        }
      } else {
        messageupdate[2] = 'فشل التحديث';
      // Navigator.pop(context);

        //  UpdateStateDialog();
      }
    } else {
      messageupdate[2] = 'لم يتم التحديث';
     // Navigator.pop(context);


      //  Navigator.pop(context);
      print("error");
      //UpdateStateDialog();
    }

    FillItems();

  }




  Future<void> FillItems() async {
    if (CheckSelected[2] == true) {
      handler.DropCateg();

      // showLoaderDialog(context);
      Uri apiUrl = Uri.parse(Globalvireables.GetItems);

      http.Response response = await http.get(apiUrl);
      if (response.statusCode == 200) {
        handler.DropCateg();
        var jsonResponse = json.decode(response.body);
        print(jsonResponse.toString() + "reqquestt");
        String receivedJson = jsonResponse;
        List<dynamic> list = json.decode(receivedJson);
        if (response.body.isNotEmpty) {
          jsonResponse = json.decode(response.body);
        } else {
          print(Items.fromJson(jsonDecode(jsonResponse[0])).Ename);
        }
int u=0;
        //  print(Categ.fromJson((list[0])).ItemCode.toString() +"   listtttta");
        for (int j = 0; j < list.length; j++) {
          // jsonResponse = json.decode(response.body)[i];
          handler.initializeDB().whenComplete(() async {
            // print(Categ.fromJson((list[j])).ItemCode.toString()+"  dddatatta");

            Items firstUser = Items(
              Item_No: Items.fromMap((list[j])).Item_No.toString(),
              Item_Name: Items.fromMap((list[j])).Item_Name.toString(),
              Ename: Items.fromMap((list[j])).Ename.toString(),
              Unit: Items.fromMap((list[j])).Unit.toString(),
              OL: Items.fromMap((list[j])).OL.toString(),
              Type_No: Items.fromMap((list[j])).Type_No.toString(),
              Pack: Items.fromMap((list[j])).Pack.toString(),

              Place: Items.fromMap((list[j])).Place.toString(),
              Price: Items.fromMap((list[j])).Price.toString(),
              dno: Items.fromMap((list[j])).dno.toString(),
              tax: Items.fromMap((list[j])).tax.toString(),
              OQ1: Items.fromMap((list[j])).OQ1.toString(),
              ItemWeight: Items.fromMap((list[j])).ItemWeight.toString(),
            );

            int i = await addItems(firstUser);
            print(i.toString() + " iiiii");
            if (i > 0) {
              messageupdate[3] = 'تم التحديث';
             // Navigator.pop(context);

              //  UpdateStateDialog();

              // Navigator.of(context, rootNavigator: true).pop();
            } else {
             // Navigator.pop(context);

              messageupdate[3] = 'فشل التحديث';
              //UpdateStateDialog();
            }
          });
        }
       // Navigator.pop(context);

      } else {
        Navigator.pop(context);

        messageupdate[3] = 'فشل التحديث';
         Navigator.pop(context);
        //  UpdateStateDialog();
      }
    } else {
      messageupdate[3] = 'لم يتم التحديث';
      // Navigator.pop(context);
      Navigator.pop(context);


      //  Navigator.pop(context);
      print("error");
      //UpdateStateDialog();
    }



  }
  Future<int> addItems(Items firstItems) async {
    List<Items> listOfItems = [
      firstItems,
    ];
    return await handler.insertItems(listOfItems);
  }
  Future<int> addCateg(Categ firstCateg) async {
    List<Categ> listOfCateg = [
      firstCateg,
    ];
    return await handler.insertCateg(listOfCateg);
  }
  Future<int> addUsers(users firstUser) async {
    /*CompanyInfo firstUser = CompanyInfo(
        ID: 22,
        CName: 'userProvider.userOne.CName',
        Address: '',
        SuperVisor: '',
        TaxNo1: '',
        TaxNo2: '',
        AllowDay: '',
        Lat: '',
        Long: '',
        StartDate: '',
        CMobile: '',
      );*/
    List<users> listOfUsers = [
      firstUser,
    ];
    return await handler.insertusers(listOfUsers);
  }

  Future<int> addCompanyInfo(CompanyInfo firstUser) async {
    /*CompanyInfo firstUser = CompanyInfo(
        ID: 22,
        CName: 'userProvider.userOne.CName',
        Address: '',
        SuperVisor: '',
        TaxNo1: '',
        TaxNo2: '',
        AllowDay: '',
        Lat: '',
        Long: '',
        StartDate: '',
        CMobile: '',
      );*/
    List<CompanyInfo> listOfUsers = [
      firstUser,
    ];
    return await handler.insertCompanyInfo(listOfUsers);
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void showCustomDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Error",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Container(
            height: 240,
            child: SizedBox.expand(child: FlutterLogo()),
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(40)),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

  Future UpdateStateDialog() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('ملخص تحديث البيانات'),
          content: const Text(''),
          actions: <Widget>[
            Container(
              width: 200,
              height: 300,
              child: ListView.builder(
                itemCount: updateitems.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 200,
                    height: 300,
                    child: ListTile(
                        trailing: Text(
                          updateitems[index],
                          style: TextStyle(
                              color: HexColor(Globalvireables.basecolor),
                              fontSize: 15),
                        ),
                        title: Text(messageupdate[index])),
                  );
                },
              ),
            )
          ],
        ),
      );
    });
  }
}
