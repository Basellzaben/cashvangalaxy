
import 'dart:io';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';


class Globalvireables {
  static String basecolor="#33377B";
  static String white2="#F5F5F5";
  static String white="#ffffff";
  static String black="#000000";
  static String black2="#191919";



  static String GetCInfo="http://10.0.1.60:88/api/Company/GetCompanyInfo";
  static String GetUsers="http://10.0.1.60:88/api/Man/GetManf";
  static String urltime = "https://api.ipgeolocation.io/timezone?apiKey=df8fec67e8274796b4692ba576c3fbe5&lat=32.01931692665541&long=35.92699122528424";
  static String checWork="http://10.0.1.60:88/api/Man/SaveManAtten";
  static String GetlASTaCTION="http://10.0.1.60:88/api/Man/GetManAtten/";
  static String GetCateg="http://10.0.1.60:88/api/ItemsCateg/GetItems_Categ/1";
  static String GetItems="http://10.0.1.60:88/api/Items/GetItems_cashVan";
  static String GetCustomers="http://10.0.1.60:88/api/Customers/GetCustomers_CashVan/";

}