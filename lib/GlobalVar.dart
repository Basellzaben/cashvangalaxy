
import 'dart:io';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';


class Globalvireables {
  static String basecolor="#33377B";
  static String white2="#F5F5F5";
  static String white="#ffffff";
  static String black="#000000";
  static String black2="#191919";

  static List<Map<String, dynamic>> journals = [];
  static List<String> price = [];

  static String GetCInfo="http://10.0.1.60:88/api/Company/GetCompanyInfo";
  static String GetUsers="http://10.0.1.60:88/api/Man/GetManf";
  static String checWork="http://10.0.1.60:88/api/Man/SaveManAtten";
  static String GetlASTaCTION="http://10.0.1.60:88/api/Man/GetManAtten/";
  static String GetCateg="http://10.0.1.60:88/api/ItemsCateg/GetItems_Categ/1";
  static String GetItems="http://10.0.1.60:88/api/Items/GetItems_cashVan";
  static String GetCustomers="http://10.0.1.60:88/api/Customer/GetCustomers_CashVan/";
  static String GetUnit="http://10.0.1.60:88/api/Unites/GetUniItem";
  static String GetUnites="http://10.0.1.60:88/api/Unites/GetUnites";
  static String urltime = "http://10.0.1.60:88/api/data/GetDatetimesp";
  static String GetMaxOrder = "http://10.0.1.60:88/api/Order/GetMaxOrders/";

}