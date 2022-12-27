import 'dart:convert';
import 'package:cashvangalaxy/Models/MaxOrder.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Dialogs/ItemDialog.dart';
import '../GlobalVar.dart';
import '../HexaColor.dart';
import '../Models/SalesInvoiceD.dart';
import '../Models/SalesInvoiceH.dart';
import '../Sqlite/DatabaseHandler.dart';
import '../provider/CustomerProvider.dart';
import '../provider/SalesInvoice.dart';
import 'Home.dart';
import 'NavBar.dart';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;

import 'Printing.dart';

void main() =>
    runApp(ResponsiveSizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Directionality(
            textDirection: ui.TextDirection.rtl,
            child: SalesInvoice(
              fromback: '',
            ),
          ));
    }));

class SalesInvoice extends StatefulWidget {
  String fromback;

  @override
  State<SalesInvoice> createState() => _SalesInvoiceState();

  SalesInvoice({required this.fromback}) : super();
}

GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class _SalesInvoiceState extends State<SalesInvoice> {
  var products = <Map<String, dynamic>>[];
  var productstosave = <Map<String, dynamic>>[];
  List<Map<String, dynamic>> _journalsOrders = [];

  List<Map<String, dynamic>> _journals = [];
  final TextEditingController maxcontroler = TextEditingController();
  final TextEditingController CustomerNamecontroler = TextEditingController();
  final TextEditingController CustomerNocontroler = TextEditingController();

  bool IncludeTex = true;
  bool Cash = true;
  final handler = DatabaseHandler();
  var max;
  double Total = 0;
  double Sum = 0;
  double SumTax = 0;
  double SumDis = 0;
  var prefs;

  Future<void> FillMax(BuildContext c) async {
    prefs = await SharedPreferences.getInstance();
    max = await handler.GetMaxSal();

    String inphonemax = await handler.GetMaxSalOrderNonshare();

    if (int.parse(max) > int.parse(inphonemax)) {
      setState(() {
        max = (int.parse(max) + 1).toString();
        maxcontroler.text = "(" + max + ")";
        print("maxxxx "+maxcontroler.text);
      });
    } else {
      int mm = int.parse(inphonemax) + 1;
      maxcontroler.text = "(" + mm.toString() + ")";
    }

    context.read<SalesInvoiceProvider>().MaxOrder = maxcontroler.text;

   // setState(() {});
  }

  setControlers(BuildContext context) {
    CustomerNamecontroler.text = "${context.read<CustomerProvider>().Name}";
    CustomerNocontroler.text = "${context.read<CustomerProvider>().No}";

    context.read<SalesInvoiceProvider>().Name = CustomerNamecontroler.text;
    context.read<SalesInvoiceProvider>().No = CustomerNocontroler.text;



    print("setControlers1 " + CustomerNamecontroler.text);
    print("setControlers2 " + CustomerNocontroler.text);
  }

  @override
  void initState() {
    _refreshItems();
    _refreshOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    print(CustomerNamecontroler.text +" nameControler");

    if (maxcontroler.text.length<3 && widget.fromback != 'ItemDialog') {
      FillMax(context);
      print('FillMaxcalled');
    }
    if (CustomerNamecontroler.text.isEmpty && widget.fromback != 'ItemDialog')
      setControlers(context);
    else
      setControler();
    Total = 0;
    Sum = 0;
    SumTax = 0;
    SumDis = 0;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Stack(children: <Widget>[
        Directionality(
          textDirection: ui.TextDirection.rtl,
          child: Scaffold(
              backgroundColor: HexColor(Globalvireables.white2),
              body: Directionality(
                textDirection: ui.TextDirection.ltr,
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.width > 600?345:230.0,
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
                                          SizedBox(
                                            width: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              final handler = DatabaseHandler();
                                              handler.DropsalDetails()
                                                  .then((value) => {

                                                        Navigator.of(context).pop(),

                                                        Navigator.of(context)
                                                            .push(
                                                                MaterialPageRoute(
                                                          builder: (context) =>
                                                              Home(),
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
                                          GestureDetector(
                                            onTap: () {
                                              showListOfOrders(context);
                                            },
                                            child: Container(
                                              width: MediaQuery.of(context).size.width > 600?135:90,
                                              child: TextField(
                                                  controller: maxcontroler,
                                                  enabled: false,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: MediaQuery.of(context).size.width > 600?25:17)),
                                            ),
                                          ),
                                          Text(" فاتوره المبيعات ",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: MediaQuery.of(context).size.width > 600?30:20)),
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
                                          /*  Text(
                                             ,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15)),*/
                                          Container(
                                            height: MediaQuery.of(context).size.width > 600?33:22,
                                            width: MediaQuery.of(context).size.width > 600?270:180,
                                            child: TextField(
                                                textAlign: TextAlign.center,
                                                controller:
                                                    CustomerNamecontroler,
                                                enabled: false,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: MediaQuery.of(context).size.width > 600?23:15)),
                                          ),
                                          Text(" : اسم العميل  ",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: MediaQuery.of(context).size.width > 600?23:15)),
                                          Spacer(),
                                          Container(
                                            height: MediaQuery.of(context).size.width > 600?30:20,
                                            width: MediaQuery.of(context).size.width > 600?97:65,
                                            child: TextField(
                                                textAlign: TextAlign.right,
                                                controller: CustomerNocontroler,
                                                enabled: false,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: MediaQuery.of(context).size.width > 600?23:15)),
                                          ),
                                          /*  Text(
                                              "${context.watch<CustomerProvider>().No}",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15)),*/
                                          Text(" : رقم العميل  ",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w200,
                                                  fontSize: MediaQuery.of(context).size.width > 600?23:15)),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.width > 600?15:5),
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
                                                  left: MediaQuery.of(context).size.width > 600?15:10, right: MediaQuery.of(context).size.width > 600?15:10),
                                              padding: EdgeInsets.all(3),
                                              child: Text(
                                                  "${context.read<CustomerProvider>().slander}" +
                                                      ": الذمم",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: MediaQuery.of(context).size.width > 600?22:15))),
                                          Container(
                                              decoration: new BoxDecoration(
                                                  color: HexColor(
                                                      Globalvireables.white),
                                                  borderRadius:
                                                      new BorderRadius.all(
                                                    const Radius.circular(10),
                                                  )),
                                              margin: EdgeInsets.only(
                                                  left: MediaQuery.of(context).size.width > 600?15:10, right: MediaQuery.of(context).size.width > 600?15:10),
                                              padding: EdgeInsets.all(3),
                                              child: Text(
                                                  "${context.read<CustomerProvider>().floorCustomer}" +
                                                      ": سقف العميل",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: MediaQuery.of(context).size.width > 600?22:15)))
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
                                                        margin:
                                                            EdgeInsets.all(MediaQuery.of(context).size.width > 600?10:5),
                                                        child: Icon(
                                                          Icons.add_circle,
                                                          color: Colors.white,
                                                          size: MediaQuery.of(context).size.width > 600?75:50,
                                                        )),
                                                  ),

                                                  SizedBox(
                                                    width: MediaQuery.of(context).size.width > 600?MediaQuery.of(context)
                                                        .size
                                                        .width /2:MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            3.4,
                                                  ),
                                                  Checkbox(
                                                      value: Cash,
                                                      //set variable for value
                                                      onChanged: (bool? value) {
                                                        setState(() {
                                                          Cash = !Cash;
                                                        });
                                                      }),
                                                  Text("نقدي",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: MediaQuery.of(context).size.width > 600?22:15)),
                                                  Checkbox(
                                                      value: IncludeTex,
                                                      //set variable for value
                                                      onChanged: (bool? value) {
                                                        setState(() {
                                                          IncludeTex =
                                                              !IncludeTex;
                                                          _refreshItems();
                                                        });
                                                      }),
                                                  Text("شامل الضريبه",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize:MediaQuery.of(context).size.width > 600?22: 15)),
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
                      Stack(
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 1.55,
                              child: ListView.builder(
                                  physics: const ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: _journals.length,
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                          onTap: () {},
                                          child: Dismissible(
                                            direction:
                                                DismissDirection.startToEnd,
                                            key: UniqueKey(),
                                            onDismissed: (direction) {
                                              setState(() {
                                                deleteitem(
                                                    _journals[index]['itemno']);
                                              });
                                              _refreshItems();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content:
                                                    Text("تم حذف الماده بنجاح"),
                                              ));
                                            },
                                            background: Container(
                                                padding: EdgeInsets.all(10),
                                                margin: EdgeInsets.all(9),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
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
                                                          Text(_journals[index]
                                                              ['netprice']),
                                                          Spacer(),
                                                          Container(
                                                            width: 200,
                                                            child:
                                                                Directionality(
                                                                    textDirection:
                                                                    ui.TextDirection.rtl,
                                                                    child: Text(_journals[index]['name'],
                                                                      overflow: TextOverflow.clip,)),
                                                          ),
                                                        ]),
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Container(
                                                                margin: EdgeInsets.only(
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10),
                                                                child: Row(
                                                                  children: [
                                                                    Spacer(),
                                                                    Text(_journals[
                                                                            index]
                                                                        ['qt']),
                                                                    Text(': الكميه'),
                                                                    Spacer(),
                                                                    Text(_journals[index]
                                                                        ['unit']),
                                                                    Text(': الوحده'),
                                                                    Spacer(),
                                                                    Text(_journals[index]
                                                                            ['bounse'].toString()),
                                                                    Text(
                                                                        ': البونص'),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10),
                                                                child: Row(
                                                                  children: [
                                                                    Spacer(),
                                                                    Text(CalculateNetItem(
                                                                        _journals[index]['netprice']
                                                                            .toString(),
                                                                        _journals[index]['tax']
                                                                            .toString(),
                                                                        _journals[index]['dis']
                                                                            .toString(),
                                                                        _journals[index]['distype']
                                                                            .toString(),
                                                                        _journals[index]['qt']
                                                                            .toString(),
                                                                        IncludeTex)),
                                                                    Text(': المجموع'),
                                                                    Spacer(),
                                                                    Text(_journals[index]['dis']),
                                                                    Text(': الخصم'),
                                                                    Spacer(),
                                                                    Text(_journals[index]['tax']),
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
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      builder: (context) {
                                        return Container(
                                          decoration: new BoxDecoration(
                                              color: HexColor(
                                                  Globalvireables.basecolor),
                                              borderRadius:
                                                  new BorderRadius.only(
                                                      topLeft:
                                                          const Radius.circular(
                                                              15.0),
                                                      topRight:
                                                          const Radius.circular(
                                                              15.0))),
                                          child: Container(
                                            decoration: new BoxDecoration(
                                                color: HexColor(
                                                    Globalvireables.basecolor),
                                                borderRadius: new BorderRadius
                                                        .only(
                                                    topLeft:
                                                        const Radius.circular(
                                                            22.0),
                                                    topRight:
                                                        const Radius.circular(
                                                            22.0))),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.all(10),
                                                  child: Row(
                                                    children: [
                                                      Spacer(),
                                                      Text(
                                                          SumDis.toStringAsFixed(
                                                                  3)
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20)),
                                                      Text(": مجموع الخصم",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w200,
                                                              fontSize: 20)),
                                                      Spacer(),
                                                      Text(
                                                          Sum.toStringAsFixed(3)
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20)),
                                                      Text(" : المجموع  ",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w200,
                                                              fontSize: 20)),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.all(10),
                                                  child: Row(
                                                    children: [
                                                      Spacer(),
                                                      Text(
                                                          Total.toStringAsFixed(
                                                                  3)
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20)),
                                                      Text(": الاجمالي",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w200,
                                                              fontSize: 20)),
                                                      Spacer(),
                                                      Text(
                                                          SumTax.toStringAsFixed(
                                                                  3)
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20)),
                                                      Text(" : مجموع الضريبه ",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w200,
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
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary: HexColor(
                                                              Globalvireables
                                                                  .white),
                                                        ),
                                                        child: Text(
                                                          "حفظ",
                                                          style: TextStyle(
                                                              color: HexColor(
                                                                  Globalvireables
                                                                      .basecolor),
                                                              fontSize: 22),
                                                        ),
                                                        onPressed: () async {

                                                          if(maxcontroler.text.isEmpty || CustomerNocontroler.text.isEmpty||
                                                              CustomerNamecontroler.text.isEmpty||_journals.length<1){
                                                            Navigator.of(context).pop();

                                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                              content: Text("لا يمكن حفظ الفاتوره"),
                                                            ));
                                                          }else{
                                                            SaveSalData(context);

                                                          }

                                                        },
                                                      ),
                                                      Spacer(),
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary: HexColor(
                                                              Globalvireables
                                                                  .white),
                                                        ),
                                                        child: Text(
                                                          "جديد",
                                                          style: TextStyle(
                                                              color: HexColor(
                                                                  Globalvireables
                                                                      .basecolor),
                                                              fontSize: 22),
                                                        ),
                                                        onPressed: () async {
                                                          FillMax(context);
                                                          handler.DropsalDetails();
                                                          _refreshItems();
                                                        },
                                                      ),
                                                      Spacer(),
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary: HexColor(
                                                              Globalvireables
                                                                  .white),
                                                        ),
                                                        child: Text(
                                                          "اعتماد",
                                                          style: TextStyle(
                                                              color: HexColor(
                                                                  Globalvireables
                                                                      .basecolor),
                                                              fontSize: 22),
                                                        ),
                                                        onPressed: () async {

                                                          if(maxcontroler.text.isEmpty || CustomerNocontroler.text.isEmpty||
                                                              CustomerNamecontroler.text.isEmpty||_journals.length<1){
                                                            Navigator.of(context).pop();
                                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                              content: Text("لا يمكن اعتماد الفاتوره"),
                                                            ));
                                                          }else{
                                                            PostSalData(context);

                                                          }

                                                        },
                                                      ),
                                                      Spacer(),
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
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
                                                        onPressed: () async {

                                                          if(maxcontroler.text.isEmpty || CustomerNocontroler.text.isEmpty||
                                                              CustomerNamecontroler.text.isEmpty||_journals.length<1){
                                                            Navigator.of(context)
                                                                .push(
                                                                MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      Prinitng(),
                                                                ));
                                                          }else{
                                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                              content: Text("لا يمكن طباعه الفاتوره"),
                                                            ));
                                                          }




                                                        },
                                                      ),
                                                      Spacer(),
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary: HexColor(
                                                              Globalvireables
                                                                  .white),
                                                        ),
                                                        child: Text(
                                                          "حذف",
                                                          style: TextStyle(
                                                              color: HexColor(
                                                                  Globalvireables
                                                                      .basecolor),
                                                              fontSize: 22),
                                                        ),
                                                        onPressed: () async {

                                                          DeleteSalInvoice(context);

                                                        },
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
                                    margin: EdgeInsets.only(bottom: 0),
                                    child: new Image.asset(
                                      'assets/upbottom.png',
                                      width: 44,
                                      height: 44,
                                    )
                                    // child: Icon(Icons.settings_overscan,size: 55,color: HexColor(Globalvireables.basecolor),),
                                    ),
                              ),
                            ),
                          ),
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
    try {
      final handler = DatabaseHandler();
      Globalvireables.journals = await handler.retrievesalDetails();
      setState(() {
        _journals = Globalvireables.journals;
        Total = 0;
        Sum = 0;
        SumTax = 0;
        SumDis = 0;
      });
    } catch (_) {}
  }

  /* calculatenets(){
    Total=0.0;

    for(int i=-0;i<_journals.length;i++) {

      if(IncludeTex){
        Total+=double.parse(_journals[i]['netprice']);
        Sum+=(double.parse(_journals[i]['netprice'])-(
            double.parse(_journals[i]['netprice'])*(double.parse(_journals[i]['tax'])/100)
        ));
      }else{
        Total+=double.parse(_journals[i]['netprice'])+(
            double.parse(_journals[i]['netprice'])*(double.parse(_journals[i]['tax'])/100)
        );
        Sum+=double.parse(_journals[i]['netprice']);
      }
      SumTax+=Sum*(double.parse(_journals[i]['tax'])/100);

    }


      Total += net;
    Sum += priceT;
    SumTax += taxT;
    SumDis += disVal;
  }*/

  String CalculateNetItem(String price, String tax, String dis, String DisType,
      String qt, bool IncludeTax) {
    double priceT = double.parse(price);
    double taxT = double.parse(tax) / 100;
    double disT = double.parse(dis);
    double qtT = double.parse(qt);
    double disVal, taxVal;
    taxVal = priceT * taxT;
    /* Total=0;
    Sum=0;
    SumTax=0;
    SumDis=0;*/

    var net;
    if (IncludeTax) {
      if (DisType == "1") {
        /*    disVal = priceT * (disT/100);
        print("type 100");*/
        disVal = disT;
      } else {
        disVal = disT;
      }
      Sum += priceT;

    //  taxVal = (Sum * (double.parse(tax) / 100));
      net = ((priceT * qtT) - disVal);
      print("priceT :" + priceT.toString());
      print("tax :" + taxVal.toString());
      print("disVal :" + disVal.toString());
      print("priceT :" + priceT.toString());
      print("net :" + net.toString());

      Total += net;
      SumTax += (taxVal);
      SumDis += disVal;
    } else {
      if (DisType == "1") {
        disVal = disT;
        // disVal = priceT * disT;
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
     // SumTax += (taxT * Sum);
      SumTax += (taxVal);
      SumDis += disVal;
      Globalvireables.Total=Total.toString();
    }
    //String inString = d.toStringAsFixed(2);
    return net.toStringAsFixed(3);
  }

  bool deleteitem(String itemno) {
    final handler = DatabaseHandler();
    bool r = false;
    handler.DeleteItemfromSalDet(itemno).then(
        (value) => {r = true, print("delete state :" + value.toString())});
    return r;
  }

  Future<bool> _onBackPressed() async {
    final handler = DatabaseHandler();
    handler.DropsalDetails().then((value) => {
          Navigator.of(context).pop(),
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Home(),
          ))
        });

    return true;
  }

  void PostSalData(BuildContext c) async {
    if(await SaveSalData(c)){
      var hdr_dis_value = 0.0;
      showLoaderDialog(c, "جار اعتماد الفاتوره...");
      String operand;
      for (int i = -0; i < _journals.length; i++) {
        String UniteNm = await handler.retrieveunitName(_journals[i]['unit']);
        operand = await handler.retrieveunitItem(_journals[i]['itemno']);
        var DisAmtFromHdr, DisPerFromHdr, ItemOrgPrice, price;
        if (_journals[i]['price'] == '0') {
          DisAmtFromHdr = _journals[i]['dis'];
          DisPerFromHdr = double.parse(_journals[i]['dis']) /
              double.parse(_journals[i]['netprice']);
        } else {
          DisAmtFromHdr = ((double.parse(_journals[i]['dis']) / 100) *
              double.parse(_journals[i]['netprice']))
              .toString();
          DisPerFromHdr = _journals[i]['dis'];
        }
        hdr_dis_value += double.parse(DisAmtFromHdr);
        if (IncludeTex) {
          ItemOrgPrice = double.parse(_journals[i]['netprice']);
          price = double.parse(_journals[i]['netprice']) -
              (double.parse(_journals[i]['netprice']) *
                  (double.parse(_journals[i]['tax']) / 100));
        } else {
          ItemOrgPrice = double.parse(_journals[i]['netprice']);
          price = double.parse(_journals[i]['netprice']);
        }
        if (DisAmtFromHdr.toString().length > 5)
          DisAmtFromHdr = DisAmtFromHdr.toString().substring(0, 5);
        products.add({
          "Bounce": _journals[i]['bounse'].toString(),
          "DisAmtFromHdr": DisAmtFromHdr.toString(),
          "DisPerFromHdr": DisPerFromHdr.toString(),
          "Dis_Amt": "0.0",
          "Discount": DisAmtFromHdr,
          "ItemOrgPrice": ItemOrgPrice.toString(),
          "Operand": operand,
          "ProID": "0",
          "Pro_amt": "0",
          "Pro_bounce": "0",
          "Pro_dis_Per": "0",
          "Unite": await _journals[i]['unit'].toString().substring(0, 1),
          "UniteNm": UniteNm,
          "name": _journals[i]['name'].toString(),
          "no": _journals[i]['itemno'].toString(),
          "price": price.toString(),
          "pro_Total": "0",
          "qty": _journals[i]['qt'].toString(),
          "tax": _journals[i]['tax'].toString(),
          "tax_Amt": ((double.parse(_journals[i]['tax']) / 100) *
              double.parse(_journals[i]['netprice']))
              .toString(),
          "total": CalculateNetItem(
              _journals[i]['netprice'].toString(),
              _journals[i]['tax'].toString(),
              _journals[i]['dis'].toString(),
              _journals[i]['distype'].toString(),
              _journals[i]['qt'].toString(),
              IncludeTex)
              .toString(),
          "weight": "0.0"
        });
      }

/*
Total += net;
Sum += priceT;
SumTax += taxT;
SumDis += disVal;
*/

      var now = new DateTime.now();
      var formatter = new DateFormat('yyyy-MM-dd');
      String formattedDate = formatter.format(now);


      Map<String, dynamic> _body = {
        'Cust_No': CustomerNocontroler.text,
        'Date': formattedDate,
        'UserID': prefs.getString('EMPMan'),
        'OrderNo':
        maxcontroler.text.toString().replaceAll('(', '').replaceAll(')', ''),
        'hdr_dis_per': "0.0",
        'hdr_dis_value': SumDis.toString(),
        'Total': Sum.toString(),
        'Net_Total': Total.toString(),
        'Tax_Total': SumTax.toString(),
        'bounce_Total': "0",
        'include_Tax': IncludeTex ? '0' : '-1',
        'disc_Total': SumDis.toString(),
        'inovice_type': Cash ? '0' : '1',
        'CashCustNm': CustomerNamecontroler.text,
        'V_OrderNo':
        maxcontroler.text.toString().replaceAll('(', '').replaceAll(')', ''),
        "DocType": "1",
        'DriverNo': "0",
        'Pos_System': "0",
        'OrderDesc': "",
        'MOVE': "0.0",
        'GSPN': "0.0",
        'detailsmodel': products
      };
      print("wheen" + _body.toString());

      var bytes = json.encode(_body);
      Uri apiUrl = Uri.parse(Globalvireables.PostSales);
      http.Response response = await http
          .post(apiUrl,
          headers: {"Content-Type": "application/json"}, body: bytes)
          .catchError(() {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("تآكد من الاتصال بالانترنت وحاول لاحقا"),
        ));
      });

      if (response.statusCode == 200) {
        handler.UpdatePosted(maxcontroler.text.toString().replaceAll('(', '').replaceAll(')', ''),'1').then((value) =>
        {
          print("updateTable "+value.toString()),
        Navigator.pop(context),
          Navigator.pop(context),
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("تم حفظ الفاتوره و ترحيلها"),
        ))
        });
        handler.DropsalDetails();
        _refreshItems();
        _refreshOrders();
      }

      var jsonResponse = jsonDecode(response.body);
      print("wheen" + _body.toString());
      print("wheenresponse" + jsonResponse.toString());

    }

  }

  Future<bool> SaveSalData(BuildContext c) async {
    bool save=false;
    //var products = <Map<String, dynamic>>[
    int countsavedtl = 0;


  String posted= await handler.CheckPosdted(maxcontroler.text.toString().replaceAll('(', '').replaceAll(')', ''));
    if(posted=='1'){
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("لا يمكن الحفظ او التعديل بعد ترحيل الفاتوره"),
      ));
      return false;
    }else{
      try {
        var hdr_dis_value = 0.0;
        showLoaderDialog(c, "جار حفظ الفاتوره...");
        bool saveHdr = true;
        String operand;
        prefs = await SharedPreferences.getInstance();
        var now = new DateTime.now();
        var formatter = new DateFormat('yyyy-MM-dd');
        String formattedDate = formatter.format(now);

        SalesInvoiceH firstCustomers = new SalesInvoiceH(
            Cust_No: CustomerNocontroler.text,
            Date: formattedDate,
            UserID: prefs.getString('EMPMan'),
            OrderNo: maxcontroler.text
                .toString()
                .replaceAll('(', '')
                .replaceAll(')', ''),
            hdr_dis_per: "0.0",
            hdr_dis_value: SumDis.toString(),
            Total: Sum.toString(),
            Net_Total: Total.toString(),
            Tax_Total: SumTax.toString(),
            bounce_Total: "0",
            include_Tax: IncludeTex ? '0' : '-1',
            disc_Total: SumDis.toString(),
            inovice_type: Cash ? '0' : '1',
            CashCustNm:CustomerNamecontroler.text,
            V_OrderNo: maxcontroler.text
                .toString()
                .replaceAll('(', '')
                .replaceAll(')', ''),
            DocType: "1",
            DriverNo: "0",
            Pos_System: "0",
            OrderDesc: "",
            MOVE: "0.0",
            GSPN: "0.0",
            posted: '0');
        List<SalesInvoiceH> listOfItems = [
          firstCustomers,
        ];
        handler.insertSalesInvoiceH(listOfItems)
            .then((value) => {
          saveHdr = true,
          //  countsavedtl++
        })
            .catchError((e) {
          saveHdr = false;

          if (e.toString().contains('UNIQUE constraint failed')) {
            Navigator.pop(context);
          } else {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(e.toString() + "1لم يتم الحفظ ، حاول مره اخرى"),
            ));

            print(e.toString() +"  thiserror");
          }
        });
        print(saveHdr.toString() + "saveHDR??");
        if (saveHdr) {
          for (int i = 0; i < _journals.length; i++) {
            operand = await handler.retrieveunitItem(_journals[i]['itemno']);
            var DisAmtFromHdr, DisPerFromHdr, ItemOrgPrice, price;
            if (_journals[i]['price'] == '0') {
              DisAmtFromHdr = _journals[i]['dis'];
              DisPerFromHdr = double.parse(_journals[i]['dis']) /
                  double.parse(_journals[i]['netprice']);
            } else {
              DisAmtFromHdr = ((double.parse(_journals[i]['dis']) / 100) *
                  double.parse(_journals[i]['netprice']))
                  .toString();
              DisPerFromHdr = _journals[i]['dis'];
            }
            hdr_dis_value += double.parse(DisAmtFromHdr);
            if (IncludeTex) {
              ItemOrgPrice = double.parse(_journals[i]['netprice']);
              price = double.parse(_journals[i]['netprice']) -
                  (double.parse(_journals[i]['netprice']) *
                      (double.parse(_journals[i]['tax']) / 100));
            } else {
              ItemOrgPrice = double.parse(_journals[i]['netprice']);
              price = double.parse(_journals[i]['netprice']);
            }
            if (DisAmtFromHdr.toString().length > 5)
              DisAmtFromHdr = DisAmtFromHdr.toString().substring(0, 5);

            SalesInvoiceD SalesInvoiceDitems = new SalesInvoiceD(
                Bounce: _journals[i]['bounse'].toString(),
                DisAmtFromHdr: DisAmtFromHdr.toString(),
                DisPerFromHdr: DisPerFromHdr.toString(),
                Dis_Amt: "0.0",
                Discount: DisAmtFromHdr,
                ItemOrgPrice: ItemOrgPrice.toString(),
                Operand: operand,
                ProID: "0",
                Pro_amt: "0",
                Pro_bounce: "0",
                Pro_dis_Per: "0",
                Unite: _journals[i]['unit'].toString().substring(0, 1),
                UniteNm: handler.retrieveunitName(_journals[i]['unit']).toString(),
                name: _journals[i]['name'].toString(),
                no: _journals[i]['itemno'].toString(),
                price: price.toString(),
                pro_Total: "0",
                qty: _journals[i]['qt'].toString(),
                tax: _journals[i]['tax'].toString(),
                tax_Amt: ((double.parse(_journals[i]['tax']) / 100) *
                    double.parse(_journals[i]['netprice']))
                    .toString(),
                total: CalculateNetItem(
                    _journals[i]['netprice'].toString(),
                    _journals[i]['tax'].toString(),
                    _journals[i]['dis'].toString(),
                    _journals[i]['distype'].toString(),
                    _journals[i]['qt'].toString(),
                    IncludeTex)
                    .toString(),
                weight: "0.0",
                distype: (int.parse(_journals[i]['distype']) - 1).toString(),
                orderno: maxcontroler.text
                    .toString()
                    .replaceAll('(', '')
                    .replaceAll(')', ''));
            List<SalesInvoiceD> listOfItemsDtl = [
              SalesInvoiceDitems,
            ];
            handler.insertSalesInvoiceD(listOfItemsDtl).then((value) =>
            {countsavedtl = _journals.length, print("donnnne save")});

            if (i == _journals.length - 1) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("تم حفظ الفاتوره "),
              ));
              //dsfds
              handler.DropsalDetails();
              _refreshItems();
              _refreshOrders();
              save=true;
            }
          }
        } else {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("2لم يتم الحفظ ، حاول مره اخرى"),
          ));
          handler.DeleteSalesInvoiceH(maxcontroler.text.replaceAll('(', '').replaceAll(')', ''));
        }
      } catch (e) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("لم يتم الحفظ ، حاول مره اخرى3"),
        ));
        print(e.toString()+"  thiserror");
      }
      print("_journals.length :" + _journals.length.toString());
      print("countsavedtl :" + countsavedtl.toString());
      FillMax(context);
      _refreshItems();
      return save;
    }

    // Navigator.pop(context);
  }

  showLoaderDialog(BuildContext context, String txt) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          Image.asset('assets/loading.gif', height: 100, width: 100),
          Container(
              margin: EdgeInsets.only(left: 7),
              child: Text("جار اعتماد الفاتوره...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _refreshOrders() async {
    try {
      final handler = DatabaseHandler();
      _journalsOrders = await handler.SalOrderHDR();
      setState(() {
        _journalsOrders = _journalsOrders;
      });
    } catch (_) {}
  }

  setControler() {
    maxcontroler.text = "${context.read<SalesInvoiceProvider>().MaxOrder}";
    CustomerNamecontroler.text = "${context.read<SalesInvoiceProvider>().Name}";
    CustomerNocontroler.text = "${context.read<SalesInvoiceProvider>().No}";
  }

  showListOfOrders(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Container(
        height: MediaQuery.of(context).size.height / 1.1,
        child: SingleChildScrollView(
          child: new Column(
            children: [
              Center(
                  child: Text(
                'فواتير البيع',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              )),
              Container(
                margin: EdgeInsets.only(top: 22),
                //padding: EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height / 1.1,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    itemCount: _journalsOrders.length,
                    itemBuilder: (context, index) => Container(
                          color: index % 2 == 0 ? Colors.white : Colors.black12,
                          padding: EdgeInsets.only(bottom: 10, top: 10),
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _refreshItemsById(
                                      _journalsOrders[index]['OrderNo']);
                                  maxcontroler.text =
                                      _journalsOrders[index]['OrderNo'];
                                  CustomerNamecontroler.text =
                                      _journalsOrders[index]['CashCustNm'];
                                  CustomerNocontroler.text =
                                      _journalsOrders[index]['Cust_No'];

                                  context
                                      .read<SalesInvoiceProvider>()
                                      .setSalesInvoice(
                                          _journalsOrders[index]['CashCustNm'],
                                          _journalsOrders[index]['OrderNo'],
                                          _journalsOrders[index]['OrderNo']);

                                  Navigator.pop(context);

                                  context.read<CustomerProvider>().No =
                                      _journalsOrders[index]['OrderNo'];
                                });
                              },
                              child: Row(
                                children: [
                                  Text(_journalsOrders[index]['OrderNo']),
                                  Spacer(),
                                  Text(_journalsOrders[index]['CashCustNm'])
                                ],
                              )),
                        )),
              ),
            ],
          ),
        ),
      ),
    );
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _refreshItemsById(String orderno) async {
    try {
      final handler = DatabaseHandler();
      handler.DropsalDetails();
      List<Map<String, dynamic>> journals2 = [];

      journals2 = await handler.retrievesalDetailsById(orderno);
      if (journals2.length == 0) _refreshItems();
      print("sizeofinput = " + journals2.length.toString());
      setState(() {
        for (int i = 0; i < journals2.length; i++) {
          var name = journals2[i]['name'];
          var itemno = journals2[i]['no'];
          var netprice = journals2[i]['total'];
          var dis = journals2[i]['dis_Amt'];
          var bounse = journals2[i]['Bounce'];
          var qt = journals2[i]['qty'];
          var unit = journals2[i]['Unite'];
          var distype = journals2[i]['distype'];
          var price = journals2[i]['ItemOrgPrice'];
          var tax = journals2[i]['tax'];
          if (dis == null) {
            dis = '0.0';
          }

          handler.SaveSal(name, itemno, netprice, dis, bounse, qt, unit,
                  distype, price, tax)
              .then((value) => {
                    _refreshItems(),
                  });
        }
      });
    } catch (_) {}
  }



  DeleteSalInvoice(BuildContext c) async {
    showLoaderDialog(c,'جار حذف الفاتوره');
    String posted= await handler.CheckPosdted(maxcontroler.text.toString().replaceAll('(', '').replaceAll(')', ''));
    if(posted=='1'){
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("لا يمكن حذف الفاتوره بعد ترحيلها"),
      ));
    }else{

      handler.DeleteSalesInvoiceH(maxcontroler.text.replaceAll('(', '').replaceAll(')', '')).then((value) =>
      {
        handler.DeleteSalesInvoiceD(maxcontroler.text.replaceAll('(', '').replaceAll(')', '')).then((value) => {

        Navigator.pop(context),

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("تم حذف الفاتوره"),
      )),
        FillMax(c),
          handler.DropsalDetails(),
          _refreshItems(),

        })
      });



    }
  }

}
