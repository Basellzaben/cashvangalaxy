import 'package:cashvangalaxy/UI/fingerPrint.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../GlobalVar.dart';
import '../HexaColor.dart';
import 'NavBar.dart';

void main() => runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    )
);

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: <Widget>[
         Scaffold(
           key: _scaffoldKey,
             endDrawer: NavBar(),
             appBar: PreferredSize(

               preferredSize: Size.fromHeight(65), // Set this height
               child: Container(
                 height: 180,
                 width: MediaQuery
                     .of(context)
                     .size
                     .width / 1.3,
                 decoration: new BoxDecoration(
                     borderRadius: BorderRadius.vertical(
                         bottom: Radius.elliptical(
                             MediaQuery
                                 .of(context)
                                 .size
                                 .width, 0.0)),
                     color: HexColor(Globalvireables.basecolor)),
                 child: Column(
                   children: [
                     Container(
                       margin: EdgeInsets.only(top: 40),
                       child: Row(children: [
                            Container(
                             margin: EdgeInsets.only(left: 10,right: 10,top: 5),
                             alignment: Alignment.center,
                             child: Icon(
                               Icons.logout,size: 30.0,
                               color: HexColor(Globalvireables.white),
                             ),
                           ),

                         Spacer(),

                         Container(
                             margin: EdgeInsets.only(left: 0, right: 0, top: 17),
                             alignment: Alignment.centerLeft,
                             child: Text("الصفحة الرئيسية", style: TextStyle(
                                 color: Colors.white,
                                 fontSize: 20,
                                 fontWeight: FontWeight.w700),)
                         ),
                         GestureDetector(
                             onTap: (){
                               setState(() {
                                 _scaffoldKey.currentState!.openEndDrawer();
                               });
                             }, child: Container(
                             margin: EdgeInsets.only(left: 5, right: 5, top: 18),
                             alignment: Alignment.centerLeft,
                             child: Icon(
                               Icons.menu,
                               size: 35.0,
                               color: HexColor(Globalvireables.white),

                             )
                         )),
                       ]),
                     ),
                   ],
                 ),
               ),
             ),


              backgroundColor: HexColor(Globalvireables.white2),
              body: Container(
                child: SingleChildScrollView(
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(
                        children: <Widget>[


                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                          child: Row(
                              children: [


                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>fingerPrint()));
                                  },

                          child:  Container(
                                 width: 180,
                                 height: 220,
                                 child: Card(
                                   shape: RoundedRectangleBorder(
                                     borderRadius: BorderRadius.circular(20.0),
                                   ),
color: Colors.white,

                                     child: Column(children: [
                                       Container(
                                       margin: EdgeInsets.only(bottom: 36,top: 20),
                                       child: Image.asset(
                                         "assets/img1.jpg",
                                         fit: BoxFit.contain,

                                       ),
                                     ),
                                       Text("الدوام",style: TextStyle(color: HexColor(Globalvireables.black2),
                                           fontSize: 23,
                                           fontWeight: FontWeight.w600),),
                                     ],)

,

                                 ),
                               )
,),


                                Container(
                                  width: 180,
                                  height: 220,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    color: Colors.white,

                                    child: Column(children: [
                                      Container(
                                        margin: EdgeInsets.only(bottom: 36,top: 20),
                                        child: Image.asset(
                                          "assets/img2.jpg",
                                          fit: BoxFit.contain,

                                        ),
                                      ),
                                      Text("الزيارات",style: TextStyle(color: HexColor(Globalvireables.black2),
                                          fontSize: 23,
                                          fontWeight: FontWeight.w600),),
                                    ],)

                                    ,

                                  ),
                                )
                                ,


                                Container(
                                  width: 180,
                                  height: 220,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    color: Colors.white,

                                    child: Column(children: [
                                      Container(
                                        margin: EdgeInsets.only(bottom: 0,top: 0),
                                        child: Image.asset(
                                          "assets/img3.jpg",
                                          fit: BoxFit.contain,

                                        ),
                                      ),
                                      Text("تحديث البيانات",style: TextStyle(color: HexColor(Globalvireables.black2),
                                          fontSize: 23,
                                          fontWeight: FontWeight.w600),),
                                    ],)

                                    ,

                                  ),
                                )
                                ,

                                    ]
                          ),
                        ),
                      )






                        ],
                      ),
                    ),
                  ),
                ),
              )
          )]);




  }
}