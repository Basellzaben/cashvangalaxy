import 'package:cashvangalaxy/UI/CatchReceipt.dart';
import 'package:cashvangalaxy/UI/ItineraryScreen.dart';
import 'package:cashvangalaxy/UI/Login.dart';
import 'package:cashvangalaxy/UI/SalesInvoice.dart';
import 'package:cashvangalaxy/UI/UpdateScreen.dart';
import 'package:cashvangalaxy/UI/fingerPrint.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../GlobalVar.dart';
import '../HexaColor.dart';
import '../Models/CompanyInfo.dart';
import '../Sqlite/DatabaseHandler.dart';
import 'NavBar.dart';

void main() =>
    runApp(ResponsiveSizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: Home(),
          ));
    }));

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class _HomeState extends State<Home> {
  @override
  void initState() {
    final handler = DatabaseHandler();
    var data;
    handler.retrieveCompanyInfo().then((value) => {
          if (value.length < 1) {showAlertDialog(context)}
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Stack(children: <Widget>[
        Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              key: _scaffoldKey,
              drawer: NavBar(),
              appBar: AppBar(
                backgroundColor: HexColor(Globalvireables.basecolor),
                title: Text("الصفحة الرئيسية"),
                leading: GestureDetector(
                  onTap: () {},
                  child: IconButton(
                    icon: Icon(
                      Icons.menu,
                      size: 30.0,
                      color: HexColor(Globalvireables.white),
                    ),
                    onPressed: () {
                      _scaffoldKey.currentState!.openDrawer();
                    }, // add custom icons also
                  ),
                ),
                actions: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.logout),
                        ),
                      )),
                ],
              ),
              //----

              backgroundColor: HexColor(Globalvireables.white2),
              body: Directionality(
                textDirection: TextDirection.ltr,
                child: Container(
                  child: SingleChildScrollView(
                    child: SingleChildScrollView(
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  fingerPrint()));
                                    },
                                    child: Container(
                                      width: 180,
                                      height: 220,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        color: Colors.white,
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  bottom: 36, top: 20),
                                              child: Image.asset(
                                                "assets/work.png",
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            Text(
                                              "الدوام",
                                              style: TextStyle(
                                                  color: HexColor(
                                                      Globalvireables.black2),
                                                  fontSize: 23,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ItineraryScreen()));
                                    },
                                    child: Container(
                                      width: 180,
                                      height: 220,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        color: Colors.white,
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  bottom: 20, top: 10),
                                              child: Image.asset(
                                                "assets/visit.png",
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            Text(
                                              "الزيارات",
                                              style: TextStyle(
                                                  color: HexColor(
                                                      Globalvireables.black2),
                                                  fontSize: 23,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UpdateScreen()));
                                      },
                                      child: Container(
                                        width: 180,
                                        height: 220,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          color: Colors.white,
                                          child: Column(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    bottom: 40, top: 10),
                                                child: Image.asset(
                                                  "assets/update.png",
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              Text(
                                                "تحديث البيانات",
                                                style: TextStyle(
                                                    color: HexColor(
                                                        Globalvireables.black2),
                                                    fontSize: 23,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )),
                                ]),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              width: MediaQuery.of(context).size.width / 1.1,
                              height: 90,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                color: HexColor(Globalvireables.basecolor),
                                child: Container(
                                  padding: EdgeInsets.all(17),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.monetization_on_outlined,
                                        size: 45.0,
                                        color: HexColor(Globalvireables.white),
                                      ),
                                      Spacer(),
                                      Text(
                                        "طلب البيع",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 24),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                final handler = DatabaseHandler();
                                handler.DropsalDetails();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SalesInvoice(
                                              fromback: 'home',
                                            )));
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 20),
                                width: MediaQuery.of(context).size.width / 1.1,
                                height: 90,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  color: HexColor(Globalvireables.basecolor),
                                  child: Container(
                                    padding: EdgeInsets.all(17),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.payment,
                                          size: 45.0,
                                          color:
                                              HexColor(Globalvireables.white),
                                        ),
                                        Spacer(),
                                        Text(
                                          "فاتوره المبيعات",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 24),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CatchReceipt(),
                                ));
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 20),
                                width: MediaQuery.of(context).size.width / 1.1,
                                height: 90,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  color: HexColor(Globalvireables.basecolor),
                                  child: Container(
                                    padding: EdgeInsets.all(17),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.payment,
                                          size: 45.0,
                                          color:
                                              HexColor(Globalvireables.white),
                                        ),
                                        Spacer(),
                                        Text(
                                          "سند قبض",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 24),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )),
        )
      ]),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("تم"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("تحديث البيانات"),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => UpdateScreen()));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("يجب تحديث البيانات"),
      content: Text("يجب تحديث البيانات للحصول على افضل تجربه"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<bool> _onBackPressed() async {
    /*  Navigator.pop(context);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SalesInvoice(),
    ));
*/
    return false;
  }
}
