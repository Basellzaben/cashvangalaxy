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
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 230.0,
                          color: Colors.transparent,
                          child: Container(
                              decoration: new BoxDecoration(
                                  color: HexColor(Globalvireables.basecolor),
                                  borderRadius: new BorderRadius.only(
                                    bottomLeft: const Radius.circular(0.0),
                                    bottomRight: const Radius.circular(0.0),
                                  )),
                              child: new Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 30),
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

 Container(
                                  width: 200,
                                  child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: CheckboxListTile(
                                      checkColor: HexColor(Globalvireables.white),
                  title: Text(
                    "شامل الضريبه",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  //    <-- label
                  value: true,
                  onChanged: (newValue) {
                    setState(() {
                      // CheckSelected[0] = newValue!;
                    });
                  },
                ),
              ),
            )
,
                                        Container(
                                          width: 200,
                                          child: Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: CheckboxListTile(
                                              checkColor: HexColor(Globalvireables.white),
                                              title: Text(
                                                "نقدي",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                              //    <-- label
                                              value: true,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  // CheckSelected[0] = newValue!;
                                                });
                                              },
                                            ),
                                          ),
                                        )


          ],
                                    ),
                                  ),


                                ],
                              )),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemDialog()));

                         //   Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                margin: EdgeInsets.only(top: 200),
                                child: Icon(
                                  Icons.add_circle,
                                  color: Colors.black,
                                  size: 50,
                                )),
                          ),
                        )
                      ],
                    ),
                    SingleChildScrollView(),
                  ],
                ),
              ),
            )),
      )
    ]);
  }
}
