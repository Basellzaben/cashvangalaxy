import 'package:cashvangalaxy/UI/UpdateScreen.dart';
import 'package:cashvangalaxy/UI/fingerPrint.dart';

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../Dialogs/ItemDialog.dart';
import '../GlobalVar.dart';
import '../HexaColor.dart';
import '../Sqlite/DatabaseHandler.dart';
import 'Home.dart';
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

 GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class _SalesInvoiceState extends State<SalesInvoice> {
  List<Map<String, dynamic>> _journals = [];
  final TextEditingController maxcontroler = TextEditingController();
  bool IncludeTex=true;
  bool Cash=true;
  final handler = DatabaseHandler();
  var max;
  double Total=0;
  double Sum=0;
  double SumTax=0;
  double SumDis=0;

  Future<void> FillMax() async {
    max = await handler.GetMaxSal();
    maxcontroler.text ="("+ max+")";
  }

  @override
  void initState() {

    _refreshItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FillMax();
    return WillPopScope(
      onWillPop: _onBackPressed,

      child: Stack(children: <Widget>[
        Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
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
                            height: 230.0,
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
                                          SizedBox(width: 10,),

                                          GestureDetector(
                                            onTap: () {
                                              final handler = DatabaseHandler();
                                              handler.DropsalDetails().then((value) => {
                                                Navigator.of(context).pop(),
                                                Navigator.of(context).push(MaterialPageRoute(
                                                  builder: (context) => Home(),
                                                ))
                                              });
                                            },
                                            child: Icon(
                                              Icons.arrow_back_ios_sharp,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                            width: 90,
                                            child: TextField(
                                                controller: maxcontroler ,
                                                enabled: false,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17)),
                                          ),

                                          Text(" فاتوره المبيعات ",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20)),

                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 5),
                                      child: Row(
                                        children: [
                                          Spacer(),
                                          Spacer(),
                                          Spacer(),
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
                                                  fontSize: 15)),

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
                                                    const Radius.circular(10),
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
                                                    const Radius.circular(10),
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
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.pop(context);

                                                      Navigator.push(
                                                          context,
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
                                                  SizedBox(
                                                    width: MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        3.4,
                                                  ),
                                                  Checkbox(
                                                      value: Cash,
                                                      //set variable for value
                                                      onChanged: (bool? value) {
                                                        setState(() {
                                                          Cash=!Cash;
                                                        });
                                                      }),
                                                  Text("نقدي",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15)),
                                                  Checkbox(
                                                      value: IncludeTex,
                                                      //set variable for value
                                                      onChanged: (bool? value) {
                                                        setState(() {IncludeTex=!IncludeTex;
                                                        _refreshItems();
                                                        });
                                                      }),
                                                  Text("شامل الضريبه",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15)),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),


                      Stack(children: [

                        SizedBox(
                            height: MediaQuery.of(context).size.height/1.55,

                            child: ListView.builder(
                                physics: const ClampingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: _journals.length,
                                itemBuilder: (context, index) => GestureDetector(
                                    onTap: () {},
                                    child: Dismissible(
                                      direction: DismissDirection.startToEnd,
                                      key: UniqueKey(),
                                      onDismissed: (direction) {
                                        setState(() {
                                          deleteitem(_journals[index]['itemno']);});
                                        _refreshItems();
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          content: Text("تم حذف الماده بنجاح"),
                                        ));
                                      },
                                      background: Container(
                                        padding: EdgeInsets.all(10),
                                          margin: EdgeInsets.all(9),

                                          child:Align(
                                            alignment: Alignment.centerLeft,
                                            child: Icon(
                                              Icons.delete,
                                              size: 40,
                                              color: Colors.white,
                                            ),
                                          ),
                                          color: Colors.redAccent),
                                      child: Column(
                                        children: [
                                          Center(
                                            child: Container(
                                              margin: EdgeInsets.all(5),
                                              child: Card(
                                                child: ExpansionTile(
                                                  title: Row(children: [
                                                    Text(
                                                        _journals[index]['netprice']),
                                                    Spacer(),
                                                    Container(width: 200,
                                                      child:Directionality(
                                                        textDirection:
                                                        TextDirection.rtl,child: Text(_journals[index]['name'], overflow:TextOverflow.clip,))
                                                      , ),
                                                  ]),
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Container(
                                                          margin: EdgeInsets.only(
                                                              left: 10, right: 10),
                                                          child: Row(
                                                            children: [
                                                              Spacer(),
                                                              Text(_journals[index]
                                                              ['qt']),
                                                              Text(': الكميه'),
                                                              Spacer(),
                                                              Text(_journals[index]
                                                              ['unit']),
                                                              Text(': الوحده'),
                                                              Spacer(),
                                                              Text(_journals[index]
                                                              ['bounse'].toString()),
                                                              Text(': البونص'),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets.only(
                                                              left: 10, right: 10),
                                                          child: Row(
                                                            children: [
                                                              Spacer(),
                                                              Text(CalculateNetItem(
                                                                  _journals[index]['netprice'].toString(),
                                                                  _journals[index]['tax'].toString(),
                                                                  _journals[index]['dis'].toString(),
                                                                  _journals[index]['distype'].toString(),
                                                                  _journals[index]['qt'].toString(),
                                                                IncludeTex
                                                              )),
                                                              Text(': المجموع'),
                                                              Spacer(),
                                                              Text(_journals[index]
                                                              ['dis']),
                                                              Text(': الخصم'),
                                                              Spacer(),
                                                              Text(_journals[index]
                                                              ['tax']),
                                                              Text(': الضريبه'),

                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )))),
                        Positioned.fill(
                           child: Align(
                            alignment: Alignment.bottomCenter,
                            child: GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15)),
                                    builder: (context) {
                                      return Container(
                                        decoration: new BoxDecoration(
                                            color: HexColor(Globalvireables.basecolor),
                                            borderRadius: new BorderRadius.only(
                                                topLeft: const Radius.circular(15.0),
                                                topRight: const Radius.circular(15.0))),
                                        child: Container(
                                          decoration: new BoxDecoration(
                                              color:
                                                  HexColor(Globalvireables.basecolor),
                                              borderRadius: new BorderRadius.only(
                                                  topLeft: const Radius.circular(22.0),
                                                  topRight:
                                                      const Radius.circular(22.0))),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.all(10),
                                                child: Row(
                                                  children: [
                                                    Spacer(),
                                                    Text(SumDis.toString(),
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 20)),
                                                    Text(": مجموع الخصم",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.w200,
                                                            fontSize: 20)),
                                                    Spacer(),
                                                    Text(Sum.toString(),
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
                                                    Text(Total.toString(),
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
                                                    Text(SumTax.toString(),
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 20)),
                                                    Text(" : مجموع الضريبه ",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.w200,
                                                            fontSize: 20)),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: 40, bottom: 20),
                                                child: Row(
                                                  children: [
                                                    Spacer(),
                                                    ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                        primary: HexColor(
                                                            Globalvireables.white),
                                                      ),
                                                      child: Text(
                                                        "حفظ",
                                                        style: TextStyle(
                                                            color: HexColor(
                                                                Globalvireables
                                                                    .basecolor),
                                                            fontSize: 22),
                                                      ),
                                                      onPressed: () async {},
                                                    ),
                                                    Spacer(),
                                                    ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                        primary: HexColor(
                                                            Globalvireables.white),
                                                      ),
                                                      child: Text(
                                                        "اعتماد",
                                                        style: TextStyle(
                                                            color: HexColor(
                                                                Globalvireables
                                                                    .basecolor),
                                                            fontSize: 22),
                                                      ),
                                                      onPressed: () async {},
                                                    ),
                                                    Spacer(),
                                                    ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                        primary: HexColor(
                                                            Globalvireables.white),
                                                      ),
                                                      child: Text(
                                                        "طباعه",
                                                        style: TextStyle(
                                                            color: HexColor(
                                                                Globalvireables
                                                                    .basecolor),
                                                            fontSize: 22),
                                                      ),
                                                      onPressed: () async {},
                                                    ),
                                                    Spacer(),
                                                    ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                        primary: HexColor(
                                                            Globalvireables.white),
                                                      ),
                                                      child: Text(
                                                        "حذف",
                                                        style: TextStyle(
                                                            color: HexColor(
                                                                Globalvireables
                                                                    .basecolor),
                                                            fontSize: 22),
                                                      ),
                                                      onPressed: () async {},
                                                    ),
                                                    Spacer(),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child: Container(
                                  margin: EdgeInsets.only(bottom: 22),
                                  child: new Image.asset(
                                    'assets/upbottom.png',
                                    width: 55,
                                    height: 55,
                                  )
                                  // child: Icon(Icons.settings_overscan,size: 55,color: HexColor(Globalvireables.basecolor),),
                                  ),
                            ),
                        ),
                         ) ,
                      ],
                      ),
                    ],
                  ),
                ),
              )),
        )
      ]),
    );
  }

  void _refreshItems() async {
    try{
    final handler = DatabaseHandler();
    Globalvireables.journals = await handler.retrievesalDetails();
    setState(() {
      _journals = Globalvireables.journals;
    });}catch(_){}
  }


  String CalculateNetItem(String price ,String tax,String dis,String DisType,String qt,bool IncludeTax){
    double priceT=double.parse(price);
    double taxT=double.parse(tax)/100;
    double disT=double.parse(dis);
    double qtT=double.parse(qt);
    double disVal,taxVal;
    taxVal=priceT*taxT;
    var net;
    if(IncludeTax) {
      if (DisType == "1") {
        disVal = priceT * (disT/100);
        print("type 100");
      } else {
        disVal = disT;
      }
      net = ((priceT * qtT) - disVal);
      print("priceT :" + priceT.toString());
      print("tax :" + taxVal.toString());
      print("disVal :" + disVal.toString());
      print("priceT :" + priceT.toString());
      print("net :" + net.toString());

      Total += net;
      Sum += priceT;
      SumTax += taxT;
      SumDis += disVal;
    }else{

      if (DisType == "1") {
        disVal = priceT * disT;
      } else {
        disVal = disT;
      }
      net = ((priceT * qtT) - disVal) + taxVal;
      print("priceT :" + priceT.toString());
      print("tax :" + taxVal.toString());
      print("disVal :" + disVal.toString());
      print("priceT :" + priceT.toString());
      print("net :" + net.toString());

      Total += net;
      Sum += priceT;
      SumTax += taxT;
      SumDis += disVal;


    }
    return net.toString();
  }


  bool deleteitem(String itemno) {
     final handler = DatabaseHandler();
bool r=false;
     handler.DeleteItemfromSalDet(itemno).then((value) => {

       r= true,
       print("delete state :"+value.toString())
     });
     return r;

  }
  Future<bool> _onBackPressed() async{
     final handler = DatabaseHandler();
    handler.DropsalDetails().then((value) => {
    Navigator.of(context).pop(),
        Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Home(),
    ))
    });

    return true;
  }
}
