import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../AuthenticationService/LocalAuthApi.dart';
import '../GlobalVar.dart';
import '../HexaColor.dart';
import '../Models/users.dart';
import '../Sqlite/DatabaseHandler.dart';
import '../Sqlite/SharePrefernce.dart';
import '../provider/CompanyProvider.dart';
import 'Home.dart';
import 'Home.dart';
import 'package:http/http.dart' as http;

import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

import 'package:flutter/services.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
void main() =>
    runApp(ResponsiveSizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Login(),
      );
    }));

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late SharedPreferences prefs;

  var islarge;

  final handler = DatabaseHandler();

  TextEditingController UserNameControler = TextEditingController();

  TextEditingController UserPasswordControler = TextEditingController();

  @override
  void initState() {
    sharedPrefs();
    //  inisial();
  }
String userlogin='';
  var check = false;
var RE=false;
  final LocalAuthentication localAuth = LocalAuthentication();
  late bool canCheckBiometrics;
  late List<BiometricType> availableBiometrics;

  inisial(BuildContext context) async {

    availableBiometrics = await localAuth.getAvailableBiometrics();
    canCheckBiometrics = await localAuth.canCheckBiometrics;
    prefs = await SharedPreferences.getInstance();
    if (prefs.getString('rememberme').toString() == 'true') {
      setState(() {
        check = true;
        RE=true;
      });
     // UserNameControler.text = prefs.getString('userlogin')!;
      // UserPasswordControler.text = prefs.getString('passwordlogin')!;
    } else {
      check = false;
      RE=false;
    }
    print("reeeeeeee " + prefs.getString('rememberme').toString());
  }

  @override
  Widget build(BuildContext context) {
    inisial(context);

    Future<void> FillDataUsers() async {
      prefs = await SharedPreferences.getInstance();
      islarge = prefs.getString('isLargeScreen');

      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          handler.DropCompanyInfo();
          showLoaderDialog(context);
          Uri apiUrl = Uri.parse(Globalvireables.GetUsers);

          http.Response response = await http.get(apiUrl).catchError(() {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("تآكد من الاتصال بالانترنت وحاول لاحقا"),
            ));
          });
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
              jsonResponse = json.decode(response.body)[j];
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
                  prefs.setString('CName', users.fromJson((list[0])).Sname);
                  prefs.setString('man', users.fromJson((list[0])).man);
                  prefs.setString('MaxDiscount',
                      users.fromJson((list[0])).MaxDiscount.toString());
                  prefs.setString('MaxBouns',
                      users.fromJson((list[0])).MaxBouns.toString());

                  print(i.toString() +
                      " newdatta " +
                      users.fromJson((list[0])).MaxDiscount.toString());

                  // prefs.setString('TransType', TransType);
                } else {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("تآكد من الاتصال بالانترنت وحاول لاحقا"),
                  ));
                }
              });
            }
            Navigator.pop(context);
          } else {
            Navigator.pop(context);
          }
        }
      } on SocketException catch (_) {
        //Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("تآكد من الاتصال بالانترنت وحاول لاحقا"),
        ));
      }
    }

    var isLargeScreen = false;
    var selectedValue = 0.0;
    if (MediaQuery.of(context).size.width > 600) {
      isLargeScreen = true;
      selectedValue = MediaQuery.of(context).size.width as double;
    } else {
      isLargeScreen = false;
      selectedValue = MediaQuery.of(context).size.height as double;
    }

    return Stack(children: <Widget>[
      Image.asset(
        "assets/shape1.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
          backgroundColor: Colors.transparent,
          body: SizedBox(
            child: SingleChildScrollView(
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        child: Center(
                          child: new Image.asset('assets/logogif.gif',
                              height: selectedValue / 3,
                              width: selectedValue / 2),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width / 1.1,
                            height: isLargeScreen == "1"
                                ? MediaQuery.of(context).size.width / 1.1
                                : MediaQuery.of(context).size.height / 1.5,
                            child: Card(
                              elevation: 10,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        Container(
                                          alignment: Alignment.topLeft,
                                          margin: EdgeInsets.only(
                                              top: 40, left: 40),
                                          child: Text(
                                            'Login !',
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.w600,
                                                color: HexColor(
                                                    Globalvireables.black)),
                                          ),
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: 25, right: 25, top: 44),
                                        child: TextField(
                                          controller: UserNameControler,
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(Icons.email),
                                            border: OutlineInputBorder(),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: HexColor(
                                                        Globalvireables
                                                            .basecolor),
                                                    width: 0.0),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0)),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 0.0),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0)),
                                            contentPadding: EdgeInsets.only(
                                                top: 18,
                                                bottom: 18,
                                                right: 20,
                                                left: 20),
                                            fillColor: Colors.white,
                                            filled: true,
                                            hintText: 'Username',
                                          ),
                                        )),
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: 25, right: 25, top: 30),
                                        child: TextField(
                                          controller: UserPasswordControler,
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(Icons.password),
                                            border: OutlineInputBorder(),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: HexColor(
                                                        Globalvireables
                                                            .basecolor),
                                                    width: 0.0),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0)),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 0.0),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0)),
                                            contentPadding: EdgeInsets.only(
                                                top: 18,
                                                bottom: 18,
                                                right: 20,
                                                left: 20),
                                            fillColor: Colors.white,
                                            filled: true,
                                            hintText: 'Password',
                                          ),
                                        )),
                                    Platform.isIOS? Container(
                                      padding: EdgeInsets.all(12),
                                      child: Row(
                                        children: [
                                          Spacer(),
                                          Text("تفعيل التعرف على الوجه",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                                  .size
                                                                  .width >
                                                              600
                                                          ? 22
                                                          : 15)),
                                          Checkbox(
                                              value: check,
                                              //set variable for value
                                              onChanged: (bool? value) async {
                                                setState(() {
                                                  check = !check;
                                                  saveREstate(check.toString());
                                                });
                                              }),
                                        ],
                                      ),
                                    ):Container(),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        height: 50,
                                        width: 240,
                                        margin: EdgeInsets.only(
                                            top: 60, bottom: 30),
                                        color: HexColor(Globalvireables.white),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: HexColor(
                                                Globalvireables.basecolor),
                                          ),
                                          child: Text(
                                            "Login",
                                            style: TextStyle(
                                                color: HexColor(
                                                    Globalvireables.white),
                                                fontSize: 22),
                                          ),
                                          onPressed: () async {
                                            if (prefs.getString('rememberme').toString() == 'true') {



                                              }
                                            if (await handler.getLogin(
                                                'Omarmaaitah', '1987')) {
                                              if (prefs
                                                      .getString('rememberme')
                                                      .toString() ==
                                                  'true') {
                                                await prefs.setString(
                                                    'userlogin', 'Omarmaaitah');
                                                await prefs.setString(
                                                    'passwordlogin', '1987');
                                              } else {
                                                await prefs.setString(
                                                    'userlogin', '');
                                                await prefs.setString(
                                                    'passwordlogin', '');
                                              }

                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Home()));
                                              print('doneee');
                                            } else {
                                              showCustomDialog(context);
                                              print('errrr');
                                            }
                                            //  }
                                          },
                                        ),
                                      ),
                                    ),
                                    userlogin!=''? Align(
    alignment: Alignment.bottomCenter,
    child: Container(
    height: 40,
    width: 300,
    margin: EdgeInsets.only(
    top: 0, bottom: 30),
    color: HexColor(Globalvireables.basecolor),
    child: ElevatedButton(
    style: ElevatedButton.styleFrom(
    primary: HexColor(
    Globalvireables.white),
    ),
    child: Text(
    "تسجيل الدخول من خلال التعرف على الوجه",
    style: TextStyle(
    color: HexColor(
    Globalvireables.basecolor),
    fontSize: 14),
    ),
    onPressed: () async {
      final isAuthenticated = await LocalAuthApi.authenticate();

      if (isAuthenticated) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Home()));
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("ليس لديك الصلاحيإت للدخولًًًًًٌٌٍٍََُُِِِّْْ"),
        ));
      }
    },
    ),
    ),
    ):Container()
                                  ],
                                ),
                              ),
                            )),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 15, bottom: 0),
                        child: Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: Center(
                                    child: Text(
                                      'Powered by galaxy group @2022',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: HexColor(
                                              Globalvireables.basecolor)),
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                      ),
                      Container(
                        height: 70,
                        child: IconButton(
                            onPressed: () {
                              FillDataUsers();
                            },
                            icon: Icon(
                              Icons.update,
                              size: 33,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ))
    ]);
  }

  void showCustomDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Error",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Container(
            height: 300,
            child: Column(
              children: [
                Image.asset(
                  "assets/loginerror.png",
                  height: 300,
                  width: 300,
                ),
              ],
            ),
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(40)),
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

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          Image.asset('assets/loading.gif', height: 100, width: 100),
          //CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7),
              child: Text("جار تسجيل الدخول...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  saveREstate(String check) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setString('rememberme', check.toString());
  }
  Future<void> sharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      if(Platform.isIOS)
      userlogin= prefs.getString('userlogin').toString();

    });
  }
}
