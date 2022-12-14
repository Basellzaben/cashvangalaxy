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
      home: screen1(),
    ));

class screen1 extends StatefulWidget {
  @override
  State<screen1> createState() => _screen1State();
}

class _screen1State extends State<screen1> {
  int val = -1;
  TextEditingController CatchControler = TextEditingController();
  TextEditingController NotesControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CatchControler.text="22.5";
    NotesControler.text="write note here";
    return Scaffold(

      backgroundColor: HexColor(Globalvireables.white),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.all(20),
                  child: Image.asset(
                    "assets/update.png",
                    fit: BoxFit.contain,
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
