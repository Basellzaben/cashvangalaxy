import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../GlobalVar.dart';
import '../HexaColor.dart';
import 'Home.dart';

void main() => runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: fingerPrint(),
    )
);
class fingerPrint extends StatefulWidget {
  @override
  State<fingerPrint> createState() => _fingerPrintState();
}

class _fingerPrintState extends State<fingerPrint> {
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: <Widget>[
          Image.asset(
            "assets/shape3.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),Scaffold(


              backgroundColor: Colors.transparent,
              body: Container(
                child: SingleChildScrollView(
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(
                        children: <Widget>[


                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.all(30),


    child: GestureDetector(
    onTap: (){
    setState(() {
    Navigator.of(context).pop();
    });},
                                child: Icon(
                                  Icons.arrow_back_ios,size: 30.0,
                                  color: HexColor(Globalvireables.white),
                                )

    )

                              ),
 Spacer(),
    Container(
      margin: EdgeInsets.only(top: 60,left: 5,right: 5),
      child: Text("اهلا بعودتك",style: TextStyle(color: HexColor(Globalvireables.white),fontSize: 33,
      fontWeight: FontWeight.w500),),
    ),

                              Container(
                                margin: EdgeInsets.only(top: 55,left: 10,right: 10),
                                height:30,
                                width: 30,
                                decoration: BoxDecoration(
                                    color: Colors.green,
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
                                margin: EdgeInsets.only(top: 5,left: 5,right: 5),
                                child: Text("الخميس - 22/8/2022",style: TextStyle(color: HexColor(Globalvireables.white),
                                  fontSize: 18,
                                   ),),
                              ),


                            ],
                          ),
                          Row(
                            children: [
                              Spacer(),
                              Container(
                                margin: EdgeInsets.only(top: 5,left: 5,right: 5),
                                child: Text("الفضيله - عمان ، الاردن",style: TextStyle(color: HexColor(Globalvireables.white),
                                  fontSize: 18,
                                ),),
                              ),


                            ],
                          ),

                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: HexColor(Globalvireables.white2),
                                  borderRadius: BorderRadius.all(Radius.circular(77))
                              ),
                              margin: EdgeInsets.only(top: 100),
                              height: MediaQuery.of(context).size.height/1.5,
                              width: MediaQuery.of(context).size.width,


    child: Column(children: [

    Center(
      child: Container(
        margin: EdgeInsets.only(top: 20),
        child: Text("12 : 33 : 55", style: GoogleFonts.atkinsonHyperlegible(
    textStyle: Theme.of(context).textTheme.displayMedium,
    fontSize: 44,fontWeight: FontWeight.w800,color: HexColor(Globalvireables.basecolor)
        ),),
      ),
    ),


      Center(
        child: Container(
          margin: EdgeInsets.only(top: 44),
          child: Container(
            margin: EdgeInsets.only(top: 80),
            child: Icon(
              Icons.fingerprint,size: 200.0,
              color: HexColor(Globalvireables.basecolor),
            ),
          ),


        ),
      ),
      Center(
        child: Container(
          margin: EdgeInsets.only(top: 44),
                 child: Container(
            child: Text(
             "بدايه الدوام",style: TextStyle(color: HexColor(Globalvireables.basecolor),fontSize: 30,fontWeight: FontWeight.bold),
            ),
          ),


        ),
      )


    ],),


                            ),
                          )



          ]))))))]);




  }
}