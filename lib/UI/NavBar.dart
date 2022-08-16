import 'package:flutter/material.dart';

import '../GlobalVar.dart';
import '../HexaColor.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(

      child: Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/shape2.png"),
            fit: BoxFit.fill,
          ),
        ),

child: SingleChildScrollView(
  child:   Column(children: [

    Container(
      margin: EdgeInsets.only(top: 60,left: 15,right: 15),
      child: Row(
          children: [
            Spacer(),


         Container(
           margin: EdgeInsets.only(top: 5),
         child: Column(
      children: [
        Container(
            margin: EdgeInsets.only(top: 8,left: 5,right: 5),
            child: Text("بـاسـل الـزبـن",style: TextStyle(color: HexColor(Globalvireables.white),fontSize: 25,
                fontWeight: FontWeight.w500),))
       , Text("شـركـه الـمـجـره الـدولـيـه",style: TextStyle(color: HexColor(Globalvireables.white),fontSize: 13,
          ),)

      ])
         )
,
            Container(
              height:65,
              width: 65,
              decoration: BoxDecoration(
                  color: HexColor(Globalvireables.white),
                  borderRadius: BorderRadius.circular(100)
                //more than 50% of width makes circle
              ),
              child: Container(
                  alignment: Alignment.center,
                  child: Text("ب",style: TextStyle(color: HexColor(Globalvireables.basecolor),fontSize: 33,fontWeight: FontWeight.w900),)),

            )
          ]
      ),
    ),



    Container(
      margin: EdgeInsets.only(top: 130),
      child: Row(
        children: [
          Spacer(),
          Text("جرد كميات العميل",style: TextStyle(color: HexColor(Globalvireables.basecolor),fontSize: 20,
              fontWeight: FontWeight.w200),),
          Icon(
            Icons.bar_chart,size: 40.0,
            color: HexColor(Globalvireables.basecolor),
          ),
          ],
      ),
    )
,
    Container(
      margin: EdgeInsets.only(top: 30),
      child: Row(
        children: [
          Spacer(),
          Text("الزيارات",style: TextStyle(color: HexColor(Globalvireables.basecolor),fontSize: 20,
              fontWeight: FontWeight.w200),),
          Icon(
            Icons.bar_chart,size: 40.0,
            color: HexColor(Globalvireables.basecolor),
          ),
        ],
      ),
    )
    ,Container(
      margin: EdgeInsets.only(top: 30),
      child: Row(
        children: [
          Spacer(),
          Text("المواد",style: TextStyle(color: HexColor(Globalvireables.basecolor),fontSize: 20,
              fontWeight: FontWeight.w200),),
          Icon(
            Icons.access_alarm,size: 40.0,
            color: HexColor(Globalvireables.basecolor),
          ),
        ],
      ),
    )

  ],),
),




      ),
    ));
  }
}