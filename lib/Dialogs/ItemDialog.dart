import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../GlobalVar.dart';
import '../HexaColor.dart';
import '../Models/Categ.dart';
import '../Sqlite/DatabaseHandler.dart';

class ItemDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LogoutOverlayStatecard();
}

class LogoutOverlayStatecard extends State<ItemDialog>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late http.Response response;
  List<Map<String, dynamic>> _journals = [];
  final TextEditingController searchcontroler = TextEditingController();
  List<String> prices = [];
  int count = 1;

  @override
  void initState() {
    if (Globalvireables.journals.isEmpty) {
      Globalvireables.journals..clear();
      _refreshItems();
    } else {
      final handler = DatabaseHandler();
      _journals.clear();
      _journals = Globalvireables.journals;
    }
//print(_journals[0]['Item_Name'].toString());
  }

  String dropdownvalue = 'Item 1';

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

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
            body: Container(
              child: SingleChildScrollView(
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
                                    setState(() {
                                      showModalBottomSheet(
                                          isScrollControlled: true,
                                          context: context,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          builder: (context) {
                                            return Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.7,
                                              child: Padding(
                                                padding: MediaQuery.of(context)
                                                    .viewInsets,
                                                child: Container(
                                                  child: Stack(
                                                    children: <Widget>[
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            bottom: 100),
                                                        child: Image.asset(
                                                          "assets/product2.png",
                                                          height: 200,
                                                          width: 200,
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: 10),
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Spacer(),
                                                                  Container(
                                                                    width: 200,
                                                                    child:
                                                                        Directionality(
                                                                      textDirection:
                                                                          TextDirection
                                                                              .rtl,
                                                                      child: Text(
                                                                          _journals[index]
                                                                              [
                                                                              'Item_Name'],
                                                                          textAlign: TextAlign
                                                                              .justify,
                                                                          overflow: TextOverflow
                                                                              .ellipsis,
                                                                          maxLines:
                                                                              3,
                                                                          style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontSize: 20,
                                                                              height: 1.3,
                                                                              fontWeight: FontWeight.w900)),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 30,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Spacer(),
                                                                  Text(
                                                                      prefs
                                                                          .getString(
                                                                              'MaxBouns')
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .deepOrange,
                                                                          fontSize:
                                                                              22,
                                                                          height:
                                                                              1.3,
                                                                          fontWeight:
                                                                              FontWeight.bold)),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Text(
                                                                      ' : الحد الاعلى للخصم',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              16,
                                                                          height:
                                                                              1.3,
                                                                          fontWeight:
                                                                              FontWeight.bold)),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Spacer(),
                                                                  Text(
                                                                      prefs
                                                                          .getString(
                                                                              'MaxDiscount')
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .deepOrange,
                                                                          fontSize:
                                                                              22,
                                                                          height:
                                                                              1.3,
                                                                          fontWeight:
                                                                              FontWeight.bold)),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Text(
                                                                      ' : الحد الاعلى للبونص',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              16,
                                                                          height:
                                                                              1.3,
                                                                          fontWeight:
                                                                              FontWeight.bold)),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Spacer(),
                                                                  Container(
                                                                    width: 50,
                                                                    height: 50,
                                                                    child:
                                                                        GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          count +=
                                                                              1;
                                                                          counter.text =
                                                                              count.toString();
                                                                        });
                                                                      },
                                                                      child: Image
                                                                          .asset(
                                                                        "assets/plus.png",
                                                                        height:
                                                                            100,
                                                                        width:
                                                                            100,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Spacer(),
                                                                  Container(
                                                                    width: 50,
                                                                    height: 50,
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets.only(
                                                                          bottom: MediaQuery.of(context)
                                                                              .viewInsets
                                                                              .bottom),
                                                                      child:
                                                                          TextField(
                                                                        scrollPadding:
                                                                            EdgeInsets.only(bottom: 40),
                                                                        keyboardType:
                                                                            TextInputType.number,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                40.0,
                                                                            height:
                                                                                2.0,
                                                                            color:
                                                                                Colors.black,
                                                                            fontWeight: FontWeight.bold),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        controller:
                                                                            counter,
                                                                        decoration:
                                                                            InputDecoration(),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Spacer(),
                                                                  Container(
                                                                    width: 50,
                                                                    height: 50,
                                                                    child: GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        setState(() {
                                                                          if (count >
                                                                              0) {
                                                                            count -=
                                                                                1;
                                                                            counter.text =
                                                                                count.toString();
                                                                          } else {}
                                                                        });},
                                                                      child: Image
                                                                          .asset(
                                                                        "assets/minuse.png",
                                                                        height:
                                                                            100,
                                                                        width:
                                                                            100,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Spacer(),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                              ),
                                                              Container(
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                child: Row(
                                                                  children: [
                                                                    Spacer(),
                                                                    DropdownButton(
                                                                      value:
                                                                          dropdownvalue,
                                                                      icon: const Icon(
                                                                          Icons
                                                                              .keyboard_arrow_down),
                                                                      items: items.map(
                                                                          (String
                                                                              items) {
                                                                        return DropdownMenuItem(
                                                                          value:
                                                                              items,
                                                                          child: Text(
                                                                              items,
                                                                              style: TextStyle(color: Colors.black, fontSize: 25, height: 1.3, fontWeight: FontWeight.bold)),
                                                                        );
                                                                      }).toList(),
                                                                      onChanged:
                                                                          (String?
                                                                              newValue) {
                                                                        setState(
                                                                            () {
                                                                          dropdownvalue =
                                                                              newValue!;
                                                                        });
                                                                      },
                                                                    ),
                                                                    Text(
                                                                        ' : الوحده',
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .black,
                                                                            fontSize:
                                                                                25,
                                                                            height:
                                                                                1.3,
                                                                            fontWeight:
                                                                                FontWeight.bold)),
                                                                    Spacer(),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
                                    });
                                  },
                                  child: Container(
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Container(
                                        margin: EdgeInsets.all(5),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    top: 15),
                                                height: 50,
                                                child: Container(
                                                    child: Text(
                                                  "",
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 30,
                                                      height: 1.3,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                              ),
                                            ),
                                            Spacer(),
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
                                                    child: Container(
                                                        child: Text(
                                                            _journals[index]
                                                                ['Item_Name'],
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 16,
                                                                height: 1.3,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)))),
                                              ),
                                            ),
                                          ],
                                        ),
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

  var prefs;

  void _refreshItems() async {
    final handler = DatabaseHandler();
    prefs = await SharedPreferences.getInstance();
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
    var data = await handler.retrieveItems2search(txt);
    setState(() {
      _journals = data;
    });
    if (prices.length != _journals.length) {
      prices.clear();
      for (int i = 0; i < _journals.length; i++) {
        String p = await handler.retrieveprice("1001", "0.0", "1.0");
        prices.add(p);
        //  prices[i] =
      }
    }
  }
}
