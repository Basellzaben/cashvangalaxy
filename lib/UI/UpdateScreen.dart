import 'dart:async';
import 'dart:convert';

import 'package:cashvangalaxy/Models/CompanyInfo.dart';
import 'package:cashvangalaxy/Models/MaxOrder.dart';
import 'package:cashvangalaxy/provider/CompanyProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../GlobalVar.dart';
import '../HexaColor.dart';
import '../Models/Categ.dart';
import '../Models/Customers.dart';
import '../Models/Items.dart';
import '../Models/UnitItem.dart';
import '../Models/Unites.dart';
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
bool CheckAll=false;
List<bool> CheckSelected = [false, false,false,false,false,false,false,false];
List<String> messageupdate = ["لم يتم التحديث", "لم يتم التحديث", "لم يتم التحديث", "لم يتم التحديث","لم يتم التحديث","لم يتم التحديث","لم يتم التحديث","لم يتم التحديث"];
List<String> updateitems = ["معلومات المؤسسة", 'المستخدمين', 'فئات العملاء', 'المواد', 'فئات المواد', 'العملاء', 'الوحدات',"التسلسلات"];

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
       /* Image.asset(
          "assets/shape5.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),*/
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
                                fontSize: 22, fontWeight: FontWeight.w900),
                          ))
                    ],
                  )),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: CheckboxListTile(
                              activeColor: Colors.green,
                              checkColor:Colors.white,
                              title: Text(
                                "تحديث الكل",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w900,fontSize: 20),
                              ),
                              //    <-- label
                              value: CheckAll,
                              onChanged: (newValue) {
                                setState(() {
                                  CheckAll = newValue!;
                                  for(int i=0;i<CheckSelected.length;i++){
                                    CheckSelected[i]=newValue;
                                  }
                                });
                              },
                            ),
                          ),
                        ),
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
                                      fontWeight: FontWeight.w900
                                  ),
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


                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: CheckboxListTile(
                                checkColor: HexColor(Globalvireables.white),
                                title: Text(
                                  "فئات المواد",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w900),
                                ),
                                //    <-- label
                                value: CheckSelected[4],
                                onChanged: (newValue) {
                                  setState(() {
                                    CheckSelected[4] = newValue!;
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
                                  "العملاء",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w900),
                                ),
                                //    <-- label
                                value: CheckSelected[5],
                                onChanged: (newValue) {
                                  setState(() {
                                    CheckSelected[5] = newValue!;
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
                                  "التسلسلات",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w900),
                                ),
                                //    <-- label
                                value: CheckSelected[7],
                                onChanged: (newValue) {
                                  setState(() {
                                    CheckSelected[7] = newValue!;
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
                                  "الوحدات",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w900),
                                ),
                                //    <-- label
                                value: CheckSelected[6],
                                onChanged: (newValue) {
                                  setState(() {
                                    CheckSelected[6] = newValue!;
                                  });
                                },
                              ),
                            ),
                          ),


                        ],
                      ),


                      Container(
                        decoration: BoxDecoration(
                            color: HexColor(Globalvireables.basecolor),

                            borderRadius: BorderRadius.all(Radius.circular(15))
                        ),

                        margin: EdgeInsets.only(top: 30),
                        width: MediaQuery.of(context).size.width / 1.3,
                        child: TextButton(
                          onPressed: () {
                            FillData();
                          },
                          child: Text(
                            'تحديث البيانات',
                            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 19),
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
    CheckSelected[0]=false;
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
            } else {
              messageupdate[1] = 'فشل التحديث';
            }
          });
          if(j==list.length-1)
            FillCateg();
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

    CheckSelected[1]=false;

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
          if(j==list.length-1)
            FillItems();
        }
      } else {
        messageupdate[2] = 'فشل التحديث';
      // Navigator.pop(context);
        FillItems();

        //  UpdateStateDialog();
      }
    } else {
      messageupdate[2] = 'لم يتم التحديث';
     // Navigator.pop(context);

      FillItems();

      //  Navigator.pop(context);
      print("error");
      //UpdateStateDialog();
    }

    CheckSelected[2]=false;

  }




  Future<void> FillItems() async {
    if (CheckSelected[3] == true) {
      handler.DropItems();

      // showLoaderDialog(context);
      Uri apiUrl = Uri.parse(Globalvireables.GetItems);

      http.Response response = await http.get(apiUrl);
      if (response.statusCode == 200) {

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
          if(j==list.length-1)
            FillUnitItem();

        }
       // Navigator.pop(context);

      } else {
        FillUnitItem();


        messageupdate[3] = 'فشل التحديث';

        //  UpdateStateDialog();
      }
    } else {
      messageupdate[3] = 'لم يتم التحديث';
      // Navigator.pop(context);
      FillUnitItem();


      //  Navigator.pop(context);
      print("error");
      //UpdateStateDialog();
    }


    CheckSelected[3]=false;

  }



  Future<void> FillUnitItem() async {
    if (CheckSelected[4] == true) {
      handler.DropUnitItem();

      // showLoaderDialog(context);
      Uri apiUrl = Uri.parse(Globalvireables.GetUnit);

      http.Response response = await http.get(apiUrl);
      if (response.statusCode == 200) {

        var jsonResponse = json.decode(response.body);
        print(jsonResponse.toString() + "reqquestt");
        String receivedJson = jsonResponse;
        List<dynamic> list = json.decode(receivedJson);
        if (response.body.isNotEmpty) {
          jsonResponse = json.decode(response.body);
        } else {
          print(UnitItem.fromJson(jsonDecode(jsonResponse[0])).acc_num);
        }
        int u=0;
        //  print(Categ.fromJson((list[0])).ItemCode.toString() +"   listtttta");
        for (int j = 0; j < list.length; j++) {
          // jsonResponse = json.decode(response.body)[i];
          handler.initializeDB().whenComplete(() async {
            // print(Categ.fromJson((list[j])).ItemCode.toString()+"  dddatatta");
            UnitItem firstUser = UnitItem(
              item_no: UnitItem.fromMap((list[j])).item_no.toString(),
              posprice: UnitItem.fromMap((list[j])).posprice.toString(),
              price: UnitItem.fromMap((list[j])).price.toString(),
              Operand: UnitItem.fromMap((list[j])).Operand.toString(),
              Max: UnitItem.fromMap((list[j])).Max.toString(),
              Min: UnitItem.fromMap((list[j])).Min.toString(),
              acc_num: UnitItem.fromMap((list[j])).acc_num.toString(),
              UnitSale: UnitItem.fromMap((list[j])).UnitSale.toString(),
              unitno: UnitItem.fromMap((list[j])).unitno.toString(),
              barcode: UnitItem.fromMap((list[j])).barcode.toString(),
            );

            int i = await addUnitItem(firstUser);
            print(i.toString() + " iiiii");
            if (i > 0) {
              messageupdate[4] = 'تم التحديث';
              // Navigator.pop(context);

              //  UpdateStateDialog();

              // Navigator.of(context, rootNavigator: true).pop();
            } else {
              // Navigator.pop(context);

              messageupdate[4] = 'فشل التحديث';
              //UpdateStateDialog();
            }


            if(j==list.length-1) {
              FillCustomers();
            }
          });
        }
        // Navigator.pop(context);

      } else {
        messageupdate[4] = 'فشل التحديث';
       // Navigator.pop(context);
        FillCustomers();

        //  UpdateStateDialog();
      }
    } else {
     // Navigator.pop(context);
      messageupdate[4] = 'لم يتم التحديث';
      FillCustomers();

    }
    CheckSelected[4]=false;


  }


  Future<void> FillCustomers() async {
   var prefs = await SharedPreferences.getInstance();
    if (CheckSelected[5] == true) {
      handler.DropCustomers();

      // showLoaderDialog(context);
      Uri apiUrl = Uri.parse(Globalvireables.GetCustomers+prefs.getString('man').toString());
print("uriiiii "+Globalvireables.GetCustomers+prefs.getString('man').toString());
      http.Response response = await http.get(apiUrl);
      if (response.statusCode == 200) {

        var jsonResponse = json.decode(response.body);
        print(jsonResponse.toString() + "reqquestt");
        String receivedJson = jsonResponse;
        List<dynamic> list = json.decode(receivedJson);
        if (response.body.isNotEmpty) {
          jsonResponse = json.decode(response.body);
        } else {
          print(Customers.fromJson(jsonDecode(jsonResponse[5])).Address);
        }
        int u=0;
        //  print(Categ.fromJson((list[0])).ItemCode.toString() +"   listtttta");
        for (int j = 0; j < list.length; j++) {
          // jsonResponse = json.decode(response.body)[i];
          handler.initializeDB().whenComplete(() async {
            // print(Categ.fromJson((list[j])).ItemCode.toString()+"  dddatatta");

        Customers firstUser = Customers(
        CloseVisitWithoutimg: Customers.fromMap((list[j])).CloseVisitWithoutimg.toString(),
            countryNo: Customers.fromMap((list[j])).countryNo.toString(),
            countryNm: Customers.fromMap((list[j])).countryNm.toString(),
            UpdateDate: Customers.fromMap((list[j])).UpdateDate.toString(),
            BB: Customers.fromMap((list[j])).BB.toString(),
            BB_Chaq: Customers.fromMap((list[j])).BB_Chaq.toString(),
            sat1: Customers.fromMap((list[j])).sat1.toString(),
            sun1: Customers.fromMap((list[j])).sun1.toString(),
            mon1: Customers.fromMap((list[j])).mon1.toString(),


            tues1: Customers.fromMap((list[j])).tues1.toString(),
            Celing: Customers.fromMap((list[j])).Celing.toString(),
            CatNo: Customers.fromMap((list[j])).CatNo.toString(),
            State: Customers.fromMap((list[j])).State.toString(),
            Cust_type: Customers.fromMap((list[j])).Cust_type.toString(),
            CheckAlowedDay: Customers.fromMap((list[j])).CheckAlowedDay.toString(),
            PromotionFlag: Customers.fromMap((list[j])).PromotionFlag.toString(),
            No: Customers.fromMap((list[j])).No.toString(),


            Note2: Customers.fromMap((list[j])).Note2.toString(),
            sat: Customers.fromMap((list[j])).sat.toString(),
            sun: Customers.fromMap((list[j])).sun.toString(),
            mon: Customers.fromMap((list[j])).mon.toString(),
            tues: Customers.fromMap((list[j])).tues.toString(),
            wens: Customers.fromMap((list[j])).wens.toString(),
            thurs: Customers.fromMap((list[j])).thurs.toString(),

            CustType: Customers.fromMap((list[j])).Note2.toString(),
            barCode: Customers.fromMap((list[j])).sat.toString(),
            Address: Customers.fromMap((list[j])).sun.toString(),
            SMan: Customers.fromMap((list[j])).mon.toString(),
            Latitude: Customers.fromMap((list[j])).Latitude.toString(),
            Longitude: Customers.fromMap((list[j])).Longitude.toString(),

            name: Customers.fromMap((list[j])).name.toString(),
            Ename: Customers.fromMap((list[j])).Ename.toString(),
            CUST_PRV_MONTH: Customers.fromMap((list[j])).CUST_PRV_MONTH.toString(),
            CUST_NET_BAL: Customers.fromMap((list[j])).CUST_NET_BAL.toString(),
            Pay_How: Customers.fromMap((list[j])).Pay_How.toString(),
            PAMENT_PERIOD_NO: Customers.fromMap((list[j])).PAMENT_PERIOD_NO.toString(),
            TaxSts: Customers.fromMap((list[j])).TaxSts.toString(),
          Chqceling: Customers.fromMap((list[j])).Chqceling.toString(),
          wens1: Customers.fromMap((list[j])).wens1.toString(),
          thurs1: Customers.fromMap((list[j])).thurs1.toString(),
            );

            int i = await addCustomers(firstUser);
            print(i.toString() + " iiiii");
            if (i > 0) {
              messageupdate[5] = 'تم التحديث';
              // Navigator.pop(context);

              //  UpdateStateDialog();

              // Navigator.of(context, rootNavigator: true).pop();
            } else {
              // Navigator.pop(context);

              messageupdate[5] = 'فشل التحديث';
              //UpdateStateDialog();
            }


            if(j==list.length-1) {
              FillUnites();

            }
          });
        }
        // Navigator.pop(context);

      } else {
        messageupdate[5] = 'فشل التحديث';
        FillUnites();

      }
    } else {
      FillUnites();


    }

   CheckSelected[5]=false;

  }


  Future<void> FillUnites() async {
    var prefs = await SharedPreferences.getInstance();
    if (CheckSelected[6] == true) {
      handler.DropUnites();

      Uri apiUrl = Uri.parse(Globalvireables.GetUnites);
      print("uriiiii "+Globalvireables.GetUnites);
      http.Response response = await http.get(apiUrl);
      if (response.statusCode == 200) {

        var jsonResponse = json.decode(response.body);
        print(jsonResponse.toString() + "reqquestt");
        String receivedJson = jsonResponse;
        List<dynamic> list = json.decode(receivedJson);
        if (response.body.isNotEmpty) {
          jsonResponse = json.decode(response.body);
        } else {
          print(Unites.fromJson(jsonDecode(jsonResponse[0])).UnitEname);
        }
        int u=0;
        for (int j = 0; j < list.length; j++) {
          handler.initializeDB().whenComplete(() async {

            Unites firstUser = Unites(
              Unitno: Unites.fromMap((list[j])).Unitno.toString(),
              UnitName: Unites.fromMap((list[j])).UnitName.toString(),
              UnitEname: Unites.fromMap((list[j])).UnitEname.toString(),

            );

            int i = await addUnites(firstUser);
            print(i.toString() + " iiiii");
            if (i > 0) {
              messageupdate[6] = 'تم التحديث';
            } else {
              messageupdate[6] = 'فشل التحديث';
            }
            if(j==list.length-1) {
            //  Navigator.pop(context);
              FillMaxOrder();
            }
          });
        }

      } else {
        messageupdate[6] = 'فشل التحديث';
      //  Navigator.pop(context);
        FillMaxOrder();
      }
    } else {
      //Navigator.pop(context);
      messageupdate[6] = 'لم يتم التحديث';
      FillMaxOrder();
    }

    CheckSelected[6]=false;
    setState(() {
      CheckAll=false;
    });
  }


  Future<void> FillMaxOrder() async {
    var prefs = await SharedPreferences.getInstance();
    if (CheckSelected[7] == true) {
      handler.DropMaxOrder();
      // showLoaderDialog(context);
      var prefs = await SharedPreferences.getInstance();
      Uri apiUrl = Uri.parse(Globalvireables.GetMaxOrder+prefs.getString('man').toString());
      print("uriiiii "+Globalvireables.GetUnites);
      http.Response response = await http.get(apiUrl);
      if (response.statusCode == 200) {

        var jsonResponse = json.decode(response.body);
        print(jsonResponse.toString() + "reqquestt");
        String receivedJson = jsonResponse;
        List<dynamic> list = json.decode(receivedJson);
        if (response.body.isNotEmpty) {
          jsonResponse = json.decode(response.body);
        } else {
          print(Unites.fromJson(jsonDecode(jsonResponse[0])).UnitEname);
        }
        int u=0;
        //  print(Categ.fromJson((list[0])).ItemCode.toString() +"   listtttta");
        for (int j = 0; j < list.length; j++) {
          // jsonResponse = json.decode(response.body)[i];
          handler.initializeDB().whenComplete(() async {
            // print(Categ.fromJson((list[j])).ItemCode.toString()+"  dddatatta");


            MaxOrder firstUser = MaxOrder(
            Sales: MaxOrder.fromMap((list[j])).Sales.toString(),
            Payment: MaxOrder.fromMap((list[j])).Payment.toString(),
            SalesOrder: MaxOrder.fromMap((list[j])).SalesOrder.toString(),

            PrepareQty: MaxOrder.fromMap((list[j])).PrepareQty.toString(),
            RetSales: MaxOrder.fromMap((list[j])).RetSales.toString(),
            PostDely: MaxOrder.fromMap((list[j])).PostDely.toString(),

            ReturnQty: MaxOrder.fromMap((list[j])).ReturnQty.toString(),
            CustCash: MaxOrder.fromMap((list[j])).CustCash.toString(),
            EnterQty: MaxOrder.fromMap((list[j])).EnterQty.toString(),

            TransferQty: MaxOrder.fromMap((list[j])).TransferQty.toString(),
            ItemRecepit: MaxOrder.fromMap((list[j])).ItemRecepit.toString(),
            Visits: MaxOrder.fromMap((list[j])).Visits.toString(),

            );

            int i = await addMaxOrder(firstUser);
            print(i.toString() + " iiiii");
            if (i > 0) {
              messageupdate[7] = 'تم التحديث';
            } else {
              messageupdate[7] = 'فشل التحديث';
            }


            if(j==list.length-1) {
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(

                      content: setupAlertDialoadContainer(),
                    );
                  });

            }
          });
        }
        // Navigator.pop(context);

      } else {
        messageupdate[7] = 'فشل التحديث';
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: setupAlertDialoadContainer(),
              );
            });
        //  UpdateStateDialog();
      }
    } else {
      Navigator.pop(context);
      messageupdate[7] = 'لم يتم التحديث';
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: setupAlertDialoadContainer(),
            );
          });

    }

    CheckSelected[7]=false;
    setState(() {
      CheckAll=false;
    });
  }

  Future<int> addUnites(Unites firstCustomers) async {
    List<Unites> listOfItems = [
      firstCustomers,
    ];
    return await handler.insertUnites(listOfItems);
  }

  Future<int> addMaxOrder(MaxOrder firstCustomers) async {
    List<MaxOrder> listOfItems = [
      firstCustomers,
    ];
    return await handler.insertMaxOrder(listOfItems);
  }


    Future<int> addCustomers(Customers firstCustomers) async {
    List<Customers> listOfItems = [
      firstCustomers,
    ];
    return await handler.insertCustomers(listOfItems);
  }

  Future<int> addUnitItem(UnitItem firstItems) async {
    List<UnitItem> listOfItems = [
      firstItems,
    ];
    return await handler.insertUnitItem(listOfItems);
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
    List<users> listOfUsers = [
      firstUser,
    ];
    return await handler.insertusers(listOfUsers);
  }

  Future<int> addCompanyInfo(CompanyInfo firstUser) async {
    List<CompanyInfo> listOfUsers = [
      firstUser,
    ];
    return await handler.insertCompanyInfo(listOfUsers);
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Container(
        height: 300,
        child: new Column(
          children: [
            Image.asset('assets/loading.gif'
                ,height:200
                ,width:300
            ),
            // CircularProgressIndicator(),
            Container(
                margin: EdgeInsets.only(left: 7), child: Text(" ... جار تحديث البيانات",
              style: TextStyle(fontWeight: FontWeight.bold),)),
          ],
        ),
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
  Widget setupAlertDialoadContainer() {
    return Container(
      height: 500.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: SingleChildScrollView(
        child: Column(
          children: [




            Container(margin: EdgeInsets.only(bottom: 2),width:300,child: Center( child: Text("ملخص تحديث البيانات",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),))),




            ListView.builder(
              shrinkWrap: true,
              itemCount: messageupdate.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Row(
                    children: [
                      Text(messageupdate[index],style: TextStyle(color: messageupdate[index]=="تم التحديث"?Colors.black:Colors.redAccent,)),
                      Spacer(),
                      Text(updateitems[index]),

                    ],
                  ),
                );
              },
            ),

            Center(
              child: Image.asset('assets/done.gif'

                  ,height:200
                  ,width:300
              ),
            ),

          ],
        ),
      ),
    );
  }
}
