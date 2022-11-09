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

  List<Map<String, dynamic>> Unites = [];

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

  TextEditingController PriceCounter = TextEditingController();
   TextEditingController dropcontroler = TextEditingController();

  // List of items in our dropdown menu
  List<String> items =[];
  List<String> uniitem =[];
 String selectedUnit="0";
  @override
  Widget build(BuildContext context) {

     TextEditingController counter = TextEditingController();
    counter.text = count.toString();
   // PriceCounter.text="44";
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
                                      getUnites( _journals[index]['Item_No']);

try {
  selectedUnit = uniitem.last.toString();
  PriceCounter.text =
      getprice(_journals[index]['Item_No'], selectedUnit, '1.0').substring(
          0, 4);
  print("lastindex  " + selectedUnit);
}catch(_){}
                                      /*   print("elllle "+items.elementAt(items.length-1).toString());
                                      selectedUnit=items.indexOf(items.elementAt(items.length-1).toString()).toString();
                                      PriceCounter.text=getprice(_journals[index]['Item_No'],selectedUnit,'1.0').substring(0,4);
*/
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
                                                                      child:
                                                                          SizedBox(
                                                                        width: MediaQuery.of(context).size.width /
                                                                            1.2,
                                                                        child: Text(
                                                                            _journals[index][
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
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                ],
                                                              ),

                                                              Align(
                                                                alignment: Alignment.centerRight,
                                                                child: Padding(
                                                                  padding: const EdgeInsets.all(9.0),
                                                                  child: Align(
                                                                    child: Row(
                                                                      children: [
                                                                        Spacer(),
                                                                        Container(
                                                                          width: MediaQuery.of(context).size.width/2.8,
                                                                          child: TextField(
                                                                            style: TextStyle(fontSize: 50,fontWeight: FontWeight.w900),
                                                                            controller: PriceCounter,
                                                                            textAlign: TextAlign.center,
                                                                            decoration: InputDecoration(
                                                                              border: InputBorder.none,
                                                                             enabled: false,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Container(margin:EdgeInsets.only(top: 11),child: Text("JD"))
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),


                                                              Row(
                                                                children: [
                                                                  Spacer(),
                                                                  Text(
                                                                      prefs.getString('MaxBouns').toString(),
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
                                                                      prefs.getString('MaxDiscount').toString(),
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
                                                                    child:
                                                                        GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          if (count >
                                                                              0) {
                                                                            count -=
                                                                                1;
                                                                            counter.text =
                                                                                count.toString();
                                                                          } else {}
                                                                        });
                                                                      },
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
                                                                 /*   DropdownButton(
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
                                                                    ),*/

                                                                    Container(
                                                                      width: MediaQuery.of(context).size.width/1.1,
                                                                      height: 50,
                                                                      child: TextField(
                                                                        textAlign: TextAlign.center,
                                                                        readOnly: true,
                                                                        controller: dropcontroler,
                                                                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                                                                        decoration: InputDecoration(
                                                                          enabledBorder: const OutlineInputBorder(
                                                                            borderSide: const BorderSide(color: Colors.grey, width: 3.0),
                                                                          ),
                                                                          suffixIcon: PopupMenuButton<String>(
                                                                            icon: const Icon(Icons.arrow_drop_down),
                                                                            onSelected: (String value) {
                                                                              dropcontroler.text = value;
                                                                              selectedUnit=uniitem.elementAt(items.indexOf(value));//(Unites.indexOf(value)+1).toString();
                                                                            print("indexselected "+selectedUnit.toString());
                                                                              PriceCounter.text=getprice(_journals[index]['Item_No'],selectedUnit,'1.0').substring(0,4);

                                                                            },
                                                                            itemBuilder: (BuildContext context) {
                                                                              return items
                                                                                  .map<PopupMenuItem<String>>((String? value) {
                                                                                return new PopupMenuItem(
                                                                                    child: new Text(value!, style: TextStyle(
                                                                                        color: Colors
                                                                                            .black,
                                                                                        fontSize:
                                                                                        25,
                                                                                        height:
                                                                                        1.3,
                                                                                        fontWeight:
                                                                                        FontWeight.bold)), value: value);
                                                                              }).toList();
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),

                                                                   /* Text(
                                                                        ' : الوحده',
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .black,
                                                                            fontSize:
                                                                                25,
                                                                            height:
                                                                                1.3,
                                                                            fontWeight:
                                                                                FontWeight.bold))*/
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
                                                        width: MediaQuery.of(context).size.width / 1.2,
                                                        child: Directionality(
                                                          textDirection:
                                                              TextDirection.rtl,
                                                          child: Text(
                                                              _journals[index]
                                                                  ['Item_Name'],
                                                              overflow:
                                                                  TextOverflow
                                                                      .clip,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 16,
                                                                  height: 1.3,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ))),
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

    print("inputs  itemno="+itemno+", unitno="+unitno);

    final handler = DatabaseHandler();
    // return handler.retrieveprice(itemno,unitno,catNo).;
    handler.retrieveprice(itemno, unitno, catNo).then((result) {
        PriceCounter.text=result;
print("priiiice  = "+result);
      return result;
    });
    return "66.666";
  }

  var prefs;

  void _refreshItems() async {
    getUnites("All");
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


  void getUnites(String itemNo) async {
    final handler = DatabaseHandler();
    var data = await handler.retrieveUnitesOfItem(itemNo);
    setState(() {
      Unites = data;
      print("lennnngth  "+data.length.toString());
    });
if(data.length>0){
    items.clear();
    uniitem.clear();
      for (int i = 0; i < data.length; i++) {
        items.add(data[i]['UnitName']);
        uniitem.add(data[i]['Unitno']);
        //if(i==data.length-1)
       //   selectedUnit=1.toString();

      //  selectedUnit=items.indexOf(data[data.length-1]['UnitName']).toString();

      }
    dropcontroler.text = items.last;

}
  }

}
