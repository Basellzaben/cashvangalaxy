import 'dart:async';
import 'package:cashvangalaxy/provider/CompanyProvider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'GlobalVar.dart';
import 'HexaColor.dart';
import 'UI/Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
Future<void> main() async {
  Provider.debugCheckInvalidValueType = null;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CompanyProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Galaxy group',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5),
          ()=>
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login())),

    );
  }

  @override
  Widget build(BuildContext context) {
    var isLargeScreen = false;
    var selectedValue = 0.0;
    if (MediaQuery.of(context).size.width > 600) {
      isLargeScreen = true;
      selectedValue=MediaQuery.of(context).size.width as double;
    } else {
      isLargeScreen = false;
      selectedValue=MediaQuery.of(context).size.height as double;

    }
    return Scaffold(

        backgroundColor:HexColor(Globalvireables.basecolor),
        body: Container(
          margin: EdgeInsets.only(top: 200),

          child: Column(children: [
            Center(
              child: new Image.asset('assets/logo.png'
      ,height:selectedValue/3
      ,width:selectedValue/3),
                  ),

            Container(
              margin: EdgeInsets.only(top: 5,bottom: 20),
              child: Center(
                //aBeeZee
               /* child: Text('',
                  style: GoogleFonts.alef(
                      textStyle: Theme.of(context).textTheme.displayMedium,
                      fontSize: 33,fontWeight: FontWeight.w800,color: Colors.black87
                  ),
                ),*/
              ),
            ),




          ]

          ),
        ));

  }}
