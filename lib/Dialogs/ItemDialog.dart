import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
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
                                          context: context,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          builder: (context) {
                                            return Container(



                                            );
                                          });
                                    });
                                  },
                                  child: Container(
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:BorderRadius.circular(10.0),
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

  void _refreshItems() async {
    final handler = DatabaseHandler();

    //print(_journals[0]['price']  + "   thispriiice");

    prices.clear();
    Globalvireables.journals = await handler.retrieveItems2();
    setState(() {
      _journals = Globalvireables.journals;
    });
    if(prices.length!=_journals.length){
      prices.clear();
      for (int i = 0; i < _journals.length; i++) {
      String p = await handler.retrieveprice("1001", "0.0", "1.0");
      prices.add(p);
    }}
  }

  void refreshSearch(String txt) async {
    final handler = DatabaseHandler();
    var data = await handler.retrieveItems2search(txt);
    setState(() {
      _journals = data;
    });
    if(prices.length!=_journals.length){
      prices.clear();
      for (int i = 0; i < _journals.length; i++) {
      String p = await handler.retrieveprice("1001", "0.0", "1.0");
      prices.add(p);
      //  prices[i] =
    }}
  }
}
