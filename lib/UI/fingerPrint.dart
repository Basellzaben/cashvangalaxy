import 'dart:convert';
import 'dart:io';
import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../GlobalVar.dart';
import '../HexaColor.dart';
import '../Models/Time.dart';
import '../Sqlite/SharePrefernce.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: fingerPrint(),
    ));

class fingerPrint extends StatefulWidget {
  @override
  State<fingerPrint> createState() => _fingerPrintState();
}

var activecheck;

var prefs;
Future<void> _launchUrl(String lat1,String lon1,String lat2,String long2) async {
  String googleUrl = "http://maps.google.com/maps?" + "saddr="+ lat1 + "," + lon1 + "&daddr=" + lat2 + "," +long2+"";
  Uri myUri = Uri.parse(googleUrl);
  if (!await launchUrl(myUri)) {
    throw 'Could not launch $myUri';
  }}
Future<Time> getTime() async {
  prefs = await SharedPreferences.getInstance();

  Uri apiUrl = Uri.parse(Globalvireables.urltime);
  http.Response response = await http.get(apiUrl);
  var jsonResponse = json.decode(response.body);
  print("mohh = " + jsonResponse);

  var parsedJson = json.decode(jsonResponse);
  var time = Time.fromJson(parsedJson);
  print("mohh = " + time.Date);
  return time;
}

class _fingerPrintState extends State<fingerPrint> {
  String? _currentAddress;
  Position? _currentPosition;
  var battery = Battery();
  int percentage = 0;
  var date, time;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied,'
                  ' we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      //debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress ='${place.street},'
            ' ${place.subLocality},'
            ' ${place.subAdministrativeArea},'
            ' ${place.postalCode}';
      }
      );
    }).catchError((_) {

      // debugPrint(e);

    });
  }

  var TransType;

  @override
  void initState() {
    super.initState();
    activecheck = true;
    setState(() {
      sharedPrefs();
      _getCurrentPosition();
    });

  }

  Future<void> sharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
    Uri apiUrl = Uri.parse(
        Globalvireables.GetlASTaCTION + prefs.getString('man').toString());
    http.Response response = await http.get(apiUrl);
    var jsonResponse = jsonDecode(response.body);

    if (jsonResponse.toString().contains("1")) {
      TransType = "2";
    } else {
      TransType = "1";
    }
    prefs.setString('TransType', TransType);
    print(Globalvireables.GetlASTaCTION + prefs.getString('man').toString() + "  response.toString()");
  }
  Future<void> _launchUrl(String lat1,String lon1,String lat2,String long2) async {
    String googleUrl = "http://maps.google.com/maps?" + "saddr="+ lat1 + "," + lon1 + "&daddr=" + lat2 + "," +long2+"";
    Uri myUri = Uri.parse(googleUrl);
    if (!await launchUrl(myUri)) {
      throw 'Could not launch $myUri';
    }
  }
  @override
  Widget build(BuildContext context) {
  //   _launchUrl("21.42","39.82","23.76","44.52");
    getTime();
    String timee = "00:00:00";
    String datee = "";
    sharedPrefs();
    return StreamBuilder(
        stream:
            Stream.periodic(Duration(seconds: 1)).asyncMap((i) => getTime()),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              prefs != null /*&& snapshot.data!.Timee.toString().length > 4*/) {
            date = snapshot.data!.Date.toString();
            time = snapshot.data!.Timee.toString();
            if (snapshot.data!.Timee.toString().length > 4) {
              timee = snapshot.data!.Timee.toString();
              datee = snapshot.data!.Date.toString().substring(0, 10);
            }

            return Stack(children: <Widget>[
              Image.asset(
                "assets/shape3.png",
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Container(
                      child: SingleChildScrollView(
                          child: SingleChildScrollView(
                              child: Container(
                                  child: Column(children: <Widget>[
                    Row(
                      children: [
                        Container(
                            margin: EdgeInsets.only(top: 30, left: 20),
                            child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    Navigator.of(context).pop();
                                  });
                                },
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  size: 30.0,
                                  color: HexColor(Globalvireables.white),
                                ))),
                        Spacer(),
                        Container(
                          margin: EdgeInsets.only(top: 30, left: 5, right: 5),
                          child: Text(
                            prefs.getString('TransType').toString() == "1"
                                ? "بدايه الدوام"
                                : "نهايه الدوام",
                            style: TextStyle(
                                color: HexColor(Globalvireables.white),
                                fontSize: 33,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 30, left: 10, right: 10),
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color:
                                  prefs.getString('TransType').toString() == "1"
                                      ? (Colors.green)
                                      : (Colors.redAccent),
                              borderRadius: BorderRadius.circular(100)
                              //more than 50% of width makes circle
                              ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Spacer(),
                        Container(
                          margin: EdgeInsets.only(top: 5, left: 5, right: 5),
                          child: Text(
                            datee,
                            //   "الخميس - 22/8/2022",
                            /* snapshot.data!.date_time_txt.toString().length > 26
                                ? snapshot.data!.date_time_txt
                                    .toString()
                                    .substring(0, 27)
                                : snapshot.data!.date_time_txt.toString(),*/
                            style: TextStyle(
                              color: HexColor(Globalvireables.white),
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Spacer(),
                        Container(
                          margin: EdgeInsets.only(top: 5, left: 5, right: 5),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 1.3,
                            child: Text(
                              textAlign: TextAlign.center,
                              ' ${_currentAddress ?? ""}',
                              style: TextStyle(
                                color: HexColor(Globalvireables.white),
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                            color: HexColor(Globalvireables.white2),
                            borderRadius:BorderRadius.all(Radius.circular(77))),
                        margin: EdgeInsets.only(top: 100),
                        height: MediaQuery.of(context).size.height / 1.5,
                        width: MediaQuery.of(context).size.width,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Center(
                                child: Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text(
                                    timee,
//atkinsonHyperlegible
                                    style: GoogleFonts.asar(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                        fontSize: 50,
                                        fontWeight: FontWeight.w800,
                                        color: HexColor(
                                            Globalvireables.basecolor)),
                                  ),
                                ),
                              ),
                              Center(
                                child: Container(
                                  child: Container(
                                    margin: EdgeInsets.only(top: 30, left: 20),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (activecheck &&
                                              !(time.toString() ==
                                                  "00:00:00")) {
                                            checWork();
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                  "يجب الانتظار لحين جلب الوقت..."),
                                            ));
                                          }
                                        });
                                      },
                                      child: activecheck
                                          ? Icon(
                                              Icons.fingerprint,
                                              size: 200.0,
                                              color: prefs
                                                          .getString(
                                                              'TransType')
                                                          .toString() ==
                                                      "1"
                                                  ? (Colors.green)
                                                  : (Colors.redAccent),
                                            )
                                          : Icon(
                                              Icons.fingerprint,
                                              size: 200.0,
                                              color: (Colors.black12),
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: Container(
                                    child: Text(
                                      prefs.getString('TransType').toString() ==
                                              "1"
                                          ? "بدايه الدوام"
                                          : " نهايه الدوام",
                                      style: TextStyle(
                                          color: HexColor(
                                              Globalvireables.basecolor),
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ]))))))
            ]);
          } else {
            return Stack(children: <Widget>[
              Image.asset(
                "assets/shape3.png",
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Container(
                      child: SingleChildScrollView(
                          child: SingleChildScrollView(
                              child: Container(
                                  child: Column(children: <Widget>[
                    Row(
                      children: [
                        Container(
                            margin: EdgeInsets.only(top: 30, left: 20),
                            child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    Navigator.of(context).pop();
                                  });
                                },
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  size: 30.0,
                                  color: HexColor(Globalvireables.white),
                                ))),
                        Spacer(),
                        Container(
                          margin: EdgeInsets.only(top: 25, left: 5, right: 5),
                          child: Text(
                            "الدوام",
                            style: TextStyle(
                                color: HexColor(Globalvireables.white),
                                fontSize: 33,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 25, left: 10, right: 10),
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(100)
                              //more than 50% of width makes circle
                              ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Spacer(),
                        Container(
                          margin: EdgeInsets.only(top: 5, left: 5, right: 5),
                          child: Text(
                            //   "الخميس - 22/8/2022",
                            "",
                            style: TextStyle(
                              color: HexColor(Globalvireables.white),
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Spacer(),
                        Container(
                          margin: EdgeInsets.only(top: 5, left: 5, right: 5),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 1.3,
                            child: Text(
                              '',
                              style: TextStyle(
                                color: HexColor(Globalvireables.white),
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                            color: HexColor(Globalvireables.white),
                            borderRadius:
                                BorderRadius.all(Radius.circular(77))),
                        margin: EdgeInsets.only(top: 100),
                        height: MediaQuery.of(context).size.height / 1.5,
                        width: MediaQuery.of(context).size.width,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Center(
                                child: Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text(
                                    "00:00:00",
//atkinsonHyperlegible
                                    style: GoogleFonts.asar(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                        fontSize: 50,
                                        fontWeight: FontWeight.w800,
                                        color: HexColor(
                                            Globalvireables.basecolor)),
                                  ),
                                ),
                              ),
                              Center(
                                child: Container(
                                  child: Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Container(
                                          margin: EdgeInsets.all(20),
                                          child: Center(
                                              child:
                                                  Column(
                                                    children: [
                                                      Container(
                                                        width: 200,
                                                        height: 200,
                                                        margin: EdgeInsets.only(
                                                        bottom: 5, top: 10),
                                                        child: Image.asset("assets/load.png", fit: BoxFit.contain,),
                                                      ),
                                                      CircularProgressIndicator(),
                                                    ],
                                                  )))),
                                ),
                              ),
                              Center(
                                child: Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: Container(
                                    child: Text(
                                      "جاري الاتصال بالشبكه",
                                      style: TextStyle(
                                          color: HexColor(
                                              Globalvireables.basecolor),
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ]))))))
            ]);
          }
        });
  }

  void checWork() async {
    //try {
      setState(() {
        activecheck = false;
      });

      try {
        TransType = prefs.getString('TransType').toString();
      } catch (_) {
        TransType = '1';
      }
      if (TransType.toString().isEmpty) {
        Uri apiUrl = Uri.parse(
            Globalvireables.GetlASTaCTION + prefs.getString('man').toString());
        http.Response response = await http.get(apiUrl);
        var jsonResponse = jsonDecode(response.body);

        if (jsonResponse.toString().contains("1")) {
          TransType = "2";
        } else {
          TransType = "1";
        }
        print("TransType " + TransType);
        SharePrefernce.setR('TransType', TransType);
      }
      print("TransType : "+TransType);
      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
        duration: new Duration(seconds: 20),
        content: new Row(
          children: <Widget>[
            new CircularProgressIndicator(),
            new Text("جار ارسال الحركه...")
          ],
        ),
      ));
      var date2 = DateTime.now();
      int c = 0;
      Uri apiUrl = Uri.parse(Globalvireables.checWork);
      final json = {
        "ID": "1",
        "UserID": prefs.getString('man').toString(),
        "ActionNo": TransType, //1 =start , 2 = end
        "ActionDate": date.toString(),
        "ActionTime": time.toString(),
        "Coor_X": _currentPosition?.altitude.toString(),
        "Coor_Y": _currentPosition?.longitude.toString(),
        "ManAddress": _currentAddress,
        "Notes": "1",
        "Img": "1",
        "BattryLevel": "2",
        "TabletName": "Flutter",
        "DayNo": date2.weekday.toString(),
        "DayNm": DateFormat('EEEE').format(date2).toString(),
        "Msg": "Msg",
      };

      if (TransType == '1')
        SharePrefernce.setR('TransType', "2");
      else
        SharePrefernce.setR('TransType', "1");

      http.Response response = await http.post(apiUrl,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(json));

      print(response.body.toString() + "ggggg");
      print(json.toString() + "ggggg");

      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse.toString().contains("2")) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("تم تسجيل الحركه بنجاح"),));
        setState(() {
          activecheck = true;
        });
      } else {
        try {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("يوجد مشكلة , يرجى المحاولة لاحقا1"),
          ));
        } catch (_) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("يوجد مشكلة , يرجى المحاولة لاحقا2"),
          ));
        }
      }

      if (c == 0) {}
   /* } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("يوجد مشكلة , يرجى المحاولة لاحقا3")));
    }*/
  }
}
