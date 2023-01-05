import 'dart:convert';
import 'dart:io';
import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../../GlobalVar.dart';
import '../../HexaColor.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CatchReceipt(),
    ));

class CatchReceipt extends StatefulWidget {
  @override
  State<CatchReceipt> createState() => _CatchReceiptState();
}

class _CatchReceiptState extends State<CatchReceipt> {
  int val = -1;
  TextEditingController CatchControler = TextEditingController();
  TextEditingController NotesControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CatchControler.text="22.5";
    NotesControler.text="write note here";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor(Globalvireables.basecolor),
        title: Row(children: <Widget>[
          Spacer(),
          Text(
            "سند القبض",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ]),
        leading: GestureDetector(
          onTap: () {},
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              size: 25.0,
              color: HexColor(Globalvireables.white),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }, // add custom icons also
          ),
        ),
      ),
      backgroundColor: HexColor(Globalvireables.white2),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Spacer(),
                      Text(
                        "23459889",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                      ),
                      Text(
                        " : رقم القبض",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 0),
                  child: Row(
                    children: [
                      Spacer(),
                      Text(
                        "0.0",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                      ),
                      Text(
                        " : سقف العميل",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 0),
                  child: Row(
                    children: [
                      Spacer(),
                      Text(
                        "باسل الزبن",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                      ),
                      Text(
                        " : اسم العميل",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                      ),
                      Spacer(),
                      Text(
                        "87357887",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                      ),
                      Text(" : رفم العميل",
                          style:
                              TextStyle(fontWeight: FontWeight.bold, fontSize: 19)),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 0),
                  child: Row(
                    children: [
                      Spacer(),
                      Container(
                        width: MediaQuery.of(context).size.width / 3,
                        child: ListTile(
                          title: Text("شيك",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          leading: Radio(
                            value: 1,
                            groupValue: val,
                            onChanged: (value) {
                              setState(() {
                                val = value!;
                                print(val.toString() + "  vall 1");
                              });
                            },
                            activeColor: Colors.green,
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 3,
                        child: ListTile(
                          title: Text("نقدي",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          leading: Radio(
                            value: 1,
                            groupValue: val,
                            onChanged: (value) {
                              setState(() {
                                val = value!;
                                print(val.toString() + "  vall 1");
                              });
                            },
                            activeColor: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 0),
                  child: Row(
                    children: [
                      Spacer(),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.2,
                        child: ListTile(
                          title: Text("شيك + نقدي",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          leading: Radio(
                            value: 1,
                            groupValue: val,
                            onChanged: (value) {
                              setState(() {
                                val = value!;
                                print(val.toString() + "  vall 1");
                              });
                            },
                            activeColor: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width/1,
                  margin: EdgeInsets.all(5),
                  child: Card(
                    child: ExpansionTile(
                      title: Row(children: [
                        Spacer(),
                        Container(
                          width: 200,
                          child: Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "نقدي",
                                overflow: TextOverflow.clip,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                              )),
                        ),
                      ]),
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Spacer(),
                     Container(
                       width: MediaQuery.of(context).size.width/7,
                       child: TextField(

                          autocorrect: false,
                          controller: CatchControler,
                          style: TextStyle(fontSize: 22.0, color: Colors.black),
                          keyboardType: TextInputType.number,
                        ),
                     ),
                                      Text(
                                        ": المبلغ النقدي",
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(fontSize: 22),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Spacer(),
                                      Text(
                                        ": الملاحظات",
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(fontSize: 22),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Spacer(),
                                      Container(
                                        margin: EdgeInsets.only(top: 10,left: 5,right: 5,bottom: 10),
                                        width: MediaQuery.of(context).size.width/1.3,
                                        child: TextField(
                                          textAlign: TextAlign.center,
                                          autocorrect: false,
                                          controller: NotesControler,
                                          style: TextStyle(fontSize: 18.0, color: Colors.black),
                                          keyboardType: TextInputType.text,

                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:Colors.black, width: 1.0),
                                                borderRadius: BorderRadius.circular(0.0)
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black, width: 0.0),
                                                borderRadius: BorderRadius.circular(0.0)

                                            ),


                                            contentPadding: EdgeInsets.only(
                                                top: 18, bottom: 18, right: 20, left: 20),
                                            fillColor: Colors.white,
                                            filled: true,

                                          ),

                                        ),
                                      ),

                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width/1,
                  margin: EdgeInsets.all(5),
                  child: Card(
                    child: ExpansionTile(
                      title: Row(children: [
                        Spacer(),
                        Container(
                          width: 200,
                          child: Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "شيك",
                                overflow: TextOverflow.clip,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                              )),
                        ),
                      ]),
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Spacer(),
                                      Container(
                                        width: MediaQuery.of(context).size.width/2,
                                        child: TextField(
                                          textAlign: TextAlign.center,

                                          autocorrect: false,
                                          controller: CatchControler,
                                          style: TextStyle(fontSize: 22.0, color: Colors.black),
                                          keyboardType: TextInputType.number,
                                        ),
                                      ),
                                      Container(
                                        width: 100,
                                        child: Text(
                                          ": رقم الشيك",
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(fontSize: 22),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Spacer(),
                                      Container(
                                        width: MediaQuery.of(context).size.width/2,
                                        child: TextField(
                                          textAlign: TextAlign.center,

                                          autocorrect: false,
                                          controller: CatchControler,
                                          style: TextStyle(fontSize: 22.0, color: Colors.black),
                                          keyboardType: TextInputType.number,
                                        ),
                                      ),
                                      Container(
                                        width: 100,

                                        child: Text(
                                          ": اسم البنك",
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(fontSize: 22),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Spacer(),
                                      Container(
                                        width: MediaQuery.of(context).size.width/2,
                                        child: TextField(
                                          textAlign: TextAlign.center,

                                          autocorrect: false,
                                          controller: CatchControler,
                                          style: TextStyle(fontSize: 22.0, color: Colors.black),
                                          keyboardType: TextInputType.number,
                                        ),
                                      ),

                                      Container(
                                        width: 100,
                                        child: Text(
                                          ": المبلغ",
                                          overflow: TextOverflow.clip,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 22),
                                        ),
                                      )

                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Spacer(),
                                      Container(
                                        width: MediaQuery.of(context).size.width/2,
                                        child: TextField(
                                          textAlign: TextAlign.center,
                                          autocorrect: false,
                                          controller: CatchControler,
                                          style: TextStyle(fontSize: 22.0, color: Colors.black),
                                          keyboardType: TextInputType.number,
                                        ),
                                      ),

                                      Container(
                                        width: 100,
                                        child: Text(
                                          ": فترة السماح",
                                          overflow: TextOverflow.clip,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 22),
                                        ),
                                      )


                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
