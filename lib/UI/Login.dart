import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../GlobalVar.dart';
import '../HexaColor.dart';
import 'Home.dart';

void main() => runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    )
);
class Login extends StatelessWidget {
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

    return Stack(
        children: <Widget>[
          Image.asset(
            "assets/shape1.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),Scaffold(
              backgroundColor: Colors.transparent,
              body: Container(
                child: SingleChildScrollView(
                    child: Container(
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Center(
                                child: new Image.asset('assets/logo.png'

    ,height:selectedValue/5
    ,width:selectedValue/5
                                ),
                              ),
                            ),

                            
                            Container(
                                height:MediaQuery.of(context).size.height/1.8,
                                width:MediaQuery.of(context).size.width/1.1,
                                child: Card(
                                  elevation: 10,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),

                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.topLeft,
                                          margin: EdgeInsets.only(top: 40,left: 40),
                                          child: Text('Login !'
                                            , style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600,color: HexColor(Globalvireables.black)),),
                                        ),

                                        Container(
                                            margin: EdgeInsets.only(left: 25,right: 25,top: 44),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                prefixIcon: Icon(Icons.phone),
                                                border: OutlineInputBorder(),
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:HexColor(Globalvireables.basecolor), width: 0.0),
                                                    borderRadius: BorderRadius.circular(10.0)
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.black, width: 0.0),
                                                    borderRadius: BorderRadius.circular(10.0)

                                                ),


                                                contentPadding: EdgeInsets.only(
                                                    top: 18, bottom: 18, right: 20, left: 20),
                                                fillColor: Colors.white,
                                                filled: true,
                                                hintText:'Username',

                                              ),
                                            )),

                                        Container(
                                            margin: EdgeInsets.only(left: 25,right: 25,top: 30),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                prefixIcon: Icon(Icons.password),
                                                border: OutlineInputBorder(),
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:HexColor(Globalvireables.basecolor), width: 0.0),
                                                    borderRadius: BorderRadius.circular(10.0)
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.black, width: 0.0),
                                                    borderRadius: BorderRadius.circular(10.0)

                                                ),


                                                contentPadding: EdgeInsets.only(
                                                    top: 18, bottom: 18, right: 20, left: 20),
                                                fillColor: Colors.white,
                                                filled: true,
                                                hintText:'Password',

                                              ),
                                            )),


                                        Container(
                                          height: 50,
                                          width: 240,
                                          margin: EdgeInsets.only(top: 60),
                                          color:HexColor(Globalvireables.white),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary:HexColor(Globalvireables.basecolor),
                                            ),
                                            child: Text(
                                              "Login"
                                              ,style: TextStyle(color: HexColor(Globalvireables.white),fontSize: 22),
                                            ),
                                            onPressed:
                                                () async {

                                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));

                                            },
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),




                                )),

                            Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(top: 15,bottom: 0),
                              child: Center(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        child: Center(
                                          child: Text('Powered by galaxy group @2022'
                                            , style: TextStyle(fontSize: 15,color: HexColor(Globalvireables.basecolor)),),
                                        ),
                                      ),

                                    ]),
                              ),)


                          ],
                        ),
                      ),
                    ),
                  
                ),
              )
          )]);




  }
}