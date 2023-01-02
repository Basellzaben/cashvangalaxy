import 'package:cashvangalaxy/provider/CustomerProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../GlobalVar.dart';
import '../HexaColor.dart';
import '../Sqlite/DatabaseHandler.dart';

class CustomersDialog extends StatefulWidget {
  const CustomersDialog({super.key});

  @override
  State<StatefulWidget> createState() => LogoutOverlayStatecard();
}

class LogoutOverlayStatecard extends State<CustomersDialog>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late String day;
  List<Map<String, dynamic>> _journals = [];
  final TextEditingController searchcontroler = TextEditingController();
  List<String> prices = [];
  int count = 1;

  @override
  void initState() {
    super.initState();


    if (Globalvireables.journals.isEmpty) {
      // Globalvireables.journals.clear();


      _refreshItems();
    } else {
      //    final handler = DatabaseHandler();
      // _journals.clear();
      //_journals = Globalvireables.journals;
    }
//print(_journals[0]['Item_Name'].toString());
  }



  // List of items in our dropdown menu


  @override
  Widget build(BuildContext context) {
    final TextEditingController counter = TextEditingController();
    counter.text = count.toString();
    //  if(_journals.length>0)
    return Container(
      color: HexColor(Globalvireables.white2),
      child: Center(
        child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        height: 65,
                        margin: const EdgeInsets.only(
                            top: 40, left: 10, right: 10),
                        width: MediaQuery.of(context).size.width / 1.3,
                        child: TextField(
                          controller: searchcontroler,
                          onChanged: refrech(),
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: HexColor(Globalvireables.white),
                            suffixIcon: Icon(
                              Icons.search,
                              color: HexColor(Globalvireables.basecolor),
                            ),
                            hintText: "البحث",
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: HexColor(Globalvireables.basecolor)),
                            ),
                          ),
                        ),
                      )),
                  if (_journals.isNotEmpty)
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _journals.length,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              print('seleeeected   '+_journals[index]['Latitude'].toString());
                              /*   context.read<CustomerProvider>().Name=_journals[index]['name'];
                              context.read<CustomerProvider>().No=_journals[index]['No'];*/
                              String name=_journals[index]['name'];
                              String No=_journals[index]['No'];
                              String Latitude=_journals[index]['Latitude'];
                              String Longitude=_journals[index]['Longitude'];
                              String BB=_journals[index]['BB'];
                              String BB_Chaq=_journals[index]['BB_Chaq'];
                              if(Latitude.isEmpty){
                                Latitude='0.0';
                              }
                              if(Longitude.isEmpty){
                                Longitude='0.0';
                              }
                              context.read<CustomerProvider>().setCustomers(
                                  name
                                  , No
                                  ,double.parse(Latitude)
                                  ,double.parse(Longitude)
                                  ,BB
                                  ,BB_Chaq);
                              Navigator.of(context).pop();

                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(10.0),
                              ),
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                      const EdgeInsets.all(8.0),
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            top: 15),
                                        height: 50,
                                        child: const Text(
                                          "",
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 30,
                                              height: 1.3,
                                              fontWeight:
                                              FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Padding(
                                      padding:
                                      const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {});
                                        },
                                        child: Container(
                                            margin:
                                            const EdgeInsets.only(
                                                top: 15),
                                            height: 50,
                                            child: SizedBox(
                                              child: Text(
                                                  _journals[index]
                                                  ['name'],
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 13,
                                                      height: 1.3,
                                                      fontWeight:
                                                      FontWeight.bold)),
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )),
                    )
                  else
                    Container(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          margin: const EdgeInsets.only(top: 120),
                          child: Image.asset(
                            'assets/notfound.png',
                            height: 100,
                            width: 100,
                          ),
                        ))

                  //
                ],
              ),
            )),
      ),
    );
    /*else
    return      Container(
        child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
            body: Container(
        margin: EdgeInsets.only(top: 400),
        child: Center(child: CircularProgressIndicator())
            )
        )
    );*/
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("تسجيل الدخول ...")),
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

  refrech() {
    setState(() {
      print(searchcontroler.text);
      refreshSearch(searchcontroler.text);
    });
  }

  String getprice(String itemno, String unitno, String catNo) {
    final handler = DatabaseHandler();
    // return handler.retrieveprice(itemno,unitno,catNo).;
    handler.retrieveprice(itemno, unitno, catNo).then((result) {
      return result;
    });
    return "0.000";
  }

  //var prefs;

  void _refreshItems() async {
    final handler = DatabaseHandler();
    // prefs = await SharedPreferences.getInstance();
    //print(_journals[0]['price']  + "   thispriiice");

    prices.clear();
    Globalvireables.journals = await handler.retrieveItems2();
    setState(() {
      _journals = Globalvireables.journals;
    });
    if (prices.length != _journals.length) {
      prices.clear();
      for (int i = 0; i < _journals.length; i++) {
        String p = await handler.retrieveprice("1001", "0.0", "1.0");
        prices.add(p);
      }
    }
  }

  void refreshSearch(String txt) async {
    final handler = DatabaseHandler();
    print("as");
    print(context.watch<CustomerProvider>().DayWeek);
    print("context.watch<CustomerProvider>().DayWeek");
    if(int.parse(context.watch<CustomerProvider>().DayWeek)==7)
      day= "sat = '1' ";
    else if(int.parse(context.read<CustomerProvider>().DayWeek)==2)
      day="mon = '1'";
    else if(int.parse(context.read<CustomerProvider>().DayWeek)==3)
      day="tues = '1'";
    else if(int.parse(context.read<CustomerProvider>().DayWeek)==5)
      day="thurs = '1'";
    else if(int.parse(context.read<CustomerProvider>().DayWeek)==4)
      day = "wens = '1'";
    else if(int.parse(context.read<CustomerProvider>().DayWeek)==1)
      day ="sun = '1'";


    var data = await handler.GetCustomersList(txt,day);
    print(data);

    setState(() {
      if(data.length!=0) {
        _journals = data;
      }
    });



    //  prices[i] =


  }
}