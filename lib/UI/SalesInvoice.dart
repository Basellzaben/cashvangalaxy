import 'package:cashvangalaxy/UI/UpdateScreen.dart';
import 'package:cashvangalaxy/UI/fingerPrint.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../Dialogs/ItemDialog.dart';
import '../GlobalVar.dart';
import '../HexaColor.dart';
import 'NavBar.dart';

void main() =>
    runApp(ResponsiveSizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: SalesInvoice(),
          ));
    }));

class SalesInvoice extends StatefulWidget {
  @override
  State<SalesInvoice> createState() => _SalesInvoiceState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class _SalesInvoiceState extends State<SalesInvoice> {


  List<Map<String, dynamic>> _journals = [];


  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: HexColor(Globalvireables.white2),
            body: Directionality(
              textDirection: TextDirection.ltr,
              child: Container(
                color: Colors.transparent,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 215.0,
                          color: Colors.transparent,
                          child: Container(
                              decoration: new BoxDecoration(
                                  color: HexColor(Globalvireables.basecolor),
                                  borderRadius: new BorderRadius.only(
                                    bottomLeft: const Radius.circular(0.0),
                                  )),
                              child: new Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 40),
                                    child: Row(
                                      children: [
                                        Spacer(),

                                        Text("65423698",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15)),
                                        Text(" : رقم الفاتوره  ",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w200,
                                                fontSize: 15)),
                                        Spacer(),


                                        Text(" فاتوره المبيعات ",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20)),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Icon(
                                            Icons.arrow_back_ios_sharp,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        ),


                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    child: Row(
                                      children: [
                                        Spacer(),
                                        Text("باسل الزبن",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15)),
                                        Text(" : اسم العميل  ",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w200,
                                                fontSize: 15)),
                                        Spacer(),
                                        Text("6657345",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15)),
                                        Text(" : رقم العميل  ",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w200,
                                                fontSize: 15))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    child: Row(
                                      children: [
                                        Spacer(),
                                        Container(
                                            decoration: new BoxDecoration(
                                                color: HexColor(
                                                    Globalvireables.white),
                                                borderRadius:
                                                new BorderRadius.all(

                                                  const Radius.circular(
                                                      10),
                                                )),
                                            margin: EdgeInsets.only(
                                                left: 10, right: 10),
                                            padding: EdgeInsets.all(3),
                                            child: Text("الذمم : 0.0",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15))),
                                        Container(
                                            decoration: new BoxDecoration(
                                                color: HexColor(
                                                    Globalvireables.white),
                                                borderRadius:
                                                new BorderRadius.all(

                                                  const Radius.circular(
                                                      10),
                                                )),
                                            margin: EdgeInsets.only(
                                                left: 10, right: 10),
                                            padding: EdgeInsets.all(3),
                                            child: Text("سقف العميل : 400",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15)))
                                      ],
                                    ),
                                  ),


                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    child: Row(
                                      children: [

                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Container(
                                            child: Row(children: [

                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ItemDialog()));

                                                  //   Navigator.pop(context);
                                                },
                                                  child: Container(
                                                    margin: EdgeInsets.all(5),
                                                      child: Icon(
                                                        Icons.add_circle,
                                                        color: Colors.white,
                                                        size: 50,
                                                      )),
                                              ),

                                              SizedBox(width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width / 3.4,),
                                              Checkbox(
                                                  value: true,
                                                  //set variable for value
                                                  onChanged: (bool? value) {
                                                    setState(() {});
                                                  }
                                              ),
                                              Text("نقدي",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      fontSize: 15))

                                              ,
                                              Checkbox(
                                                  value: true,
                                                  //set variable for value
                                                  onChanged: (bool? value) {
                                                    setState(() {});
                                                  }
                                              ),
                                              Text("شامل الضريبه",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      fontSize: 15)),


                                            ],),
                                          ),
                                        )
                                        ,


                                      ],
                                    ),
                                  ),


                                ],
                              )),
                        ),
                      ],
                    ),

                          Expanded(
                            child: Container(
                            ),
                          ),
                          /// Below container will go to bottom
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            shape : RoundedRectangleBorder(
                                borderRadius : BorderRadius.circular(15)
                            ),
                            builder: (context) {
                              return Container(
                                decoration: new BoxDecoration(
                                    color: HexColor(Globalvireables.basecolor),
                                    borderRadius: new BorderRadius.only(
                                        topLeft: const Radius.circular(15.0),
                                        topRight: const Radius.circular(15.0))),
                                child: Container(
                                  decoration: new BoxDecoration(
                                      color: HexColor(Globalvireables.basecolor),
                                      borderRadius: new BorderRadius.only(
                                          topLeft: const Radius.circular(22.0),
                                          topRight: const Radius.circular(22.0))),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        child: Row(
                                          children: [
                                            Spacer(),
                                            Text("33",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20)),
                                            Text(": الخصم",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 20)),
                                            Spacer(),
                                            Text("40",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20)),
                                            Text(" : المجموع  ",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 20)),

                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        child: Row(
                                          children: [
                                            Spacer(),
                                            Text("22",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20)),
                                            Text(": الاجمالي",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 20)),
                                            Spacer(),
                                            Text("40",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20)),
                                            Text(" : الضريبه  ",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 20)),
                                          ],
                                        ),
                                      ),

                                      Container(
                                        margin: EdgeInsets.only(top: 40,bottom: 20),
                                        child: Row(children: [
                                          Spacer(),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary:HexColor(Globalvireables.white),
                                            ),
                                            child: Text(
                                              "حفظ"
                                              ,style: TextStyle(color: HexColor(Globalvireables.basecolor),fontSize: 22),
                                            ),
                                            onPressed:
                                                () async {
                                            },
                                          ),
                                          Spacer(),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary:HexColor(Globalvireables.white),
                                            ),
                                            child: Text(
                                              "اعتماد"
                                              ,style: TextStyle(color: HexColor(Globalvireables.basecolor),fontSize: 22),
                                            ),
                                            onPressed:
                                                () async {
                                            },
                                          ),
                                          Spacer(),

                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary:HexColor(Globalvireables.white),
                                            ),
                                            child: Text(
                                              "طباعه"
                                              ,style: TextStyle(color: HexColor(Globalvireables.basecolor),fontSize: 22),
                                            ),
                                            onPressed:
                                                () async {
                                            },
                                          ),
                                          Spacer(),

                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary:HexColor(Globalvireables.white),
                                            ),
                                            child: Text(
                                              "حذف"
                                              ,style: TextStyle(color: HexColor(Globalvireables.basecolor),fontSize: 22),
                                            ),
                                            onPressed:
                                                () async {
                                            },
                                          ),
                                          Spacer(),

                                        ],),
                                      )



                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      child: Container(

margin: EdgeInsets.only(bottom: 22),
                        child: new Image.asset('assets/shop.png'
                        ,width: 55,height: 55,
                        )
                       // child: Icon(Icons.settings_overscan,size: 55,color: HexColor(Globalvireables.basecolor),),
                      ),
                    ),


                  ],
                ),
              ),
            )),
      )
    ]);
  }
}
