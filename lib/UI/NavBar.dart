import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../GlobalVar.dart';
import '../HexaColor.dart';
import '../Models/CompanyInfo.dart';
import '../Sqlite/DatabaseHandler.dart';
import '../Sqlite/SharePrefernce.dart';
import '../provider/CompanyProvider.dart';
import 'package:http/http.dart' as http;

class NavBar extends StatelessWidget {
  final handler = DatabaseHandler();
  var prefs;

  Future<CompanyInfo> getUser() async {
    var handler = DatabaseHandler();
    var x = await handler.getPersonWithId();
    print(x.CName + "tytytytyty");
    prefs = await SharedPreferences.getInstance();

    return x;
  }

  @override
  Widget build(BuildContext context) {
    getUser();
    return Drawer(
      child: FutureBuilder<CompanyInfo>(
          future: getUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data!.CName.toString() + " nnnname");
              var data = snapshot.data;

              return Directionality(
                textDirection: TextDirection.ltr,
                child: Container(
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new AssetImage("assets/shape2.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 60, left: 15, right: 15),
                          child: Row(children: [
                            Spacer(),
                            Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Column(children: [
                                  Container(
                                      margin: EdgeInsets.only(
                                          top: 8, left: 5, right: 5),
                                      child: Text(
                                        prefs.getString('EMPName'),
                                        style: TextStyle(
                                            color:
                                                HexColor(Globalvireables.white),
                                            fontSize: 25,
                                            fontWeight: FontWeight.w500),
                                      )),
                                  Text(
                                    data!.CName,
                                    style: TextStyle(
                                      color: HexColor(Globalvireables.white),
                                      fontSize: 13,
                                    ),
                                  )
                                ])),
                            Container(
                              height: 65,
                              width: 65,
                              decoration: BoxDecoration(
                                  color: HexColor(Globalvireables.white),
                                  borderRadius: BorderRadius.circular(100)
                                  //more than 50% of width makes circle
                                  ),
                              child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    prefs
                                        .getString('EMPName')
                                        .toString()
                                        .substring(0, 1),
                                    style: TextStyle(
                                        color:
                                            HexColor(Globalvireables.basecolor),
                                        fontSize: 33,
                                        fontWeight: FontWeight.w900),
                                  )),
                            )
                          ]),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top:
                                  MediaQuery.of(context).size.longestSide / 10),
                          child: Row(
                            children: [
                              Spacer(),
                              Text(
                                "جرد كميات العميل",
                                style: TextStyle(
                                    color: HexColor(Globalvireables.basecolor),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w200),
                              ),
                              Icon(
                                Icons.bar_chart,
                                size: 40.0,
                                color: HexColor(Globalvireables.basecolor),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          child: Row(
                            children: [
                              Spacer(),
                              Text(
                                "الزيارات",
                                style: TextStyle(
                                    color: HexColor(Globalvireables.basecolor),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w200
                                ),
                              ),
                              Icon(
                                Icons.bar_chart,
                                size: 40.0,
                                color: HexColor(Globalvireables.basecolor),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          child: Row(
                            children: [
                              Spacer(),
                              Text(
                                "المواد",
                                style: TextStyle(
                                    color: HexColor(Globalvireables.basecolor),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w200),
                              ),
                              Icon(
                                Icons.access_alarm,
                                size: 40.0,
                                color: HexColor(Globalvireables.basecolor),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
