import 'package:flutter/material.dart';

import '../Models/CompanyInfo.dart';
import '../Sqlite/DatabaseHandler.dart';


final handler = DatabaseHandler();

class CompanyProvider with ChangeNotifier {

  late List<CompanyInfo> companyinfo=<CompanyInfo>[];

   /* Future<void> fetchCoInfo() async {
    final data = await handler.retrieveCompanyInfo();
    companyinfo = data;
  }*/

  CompanyInfo _userOne = CompanyInfo(ID: 1, CName: 'Japan'
  ,Address: 'Address',
  SuperVisor: 'SuperVisor',
  TaxNo1: 'TaxNo1',
  TaxNo2: 'TaxNo2',
  AllowDay:0,
  Lat: 'Lat',
  Long: 'Long',
  StartDate: 'StartDate',
  CMobile: 'CMobile',);
  CompanyInfo get userOne => _userOne;
  /*
User _userTwo = User(name: 'Mutudu', location: 'Hokkaidu');
  User get userTwo => _userTwo;

  User _userThree = User(name: 'John Smith', location: 'East Coast');
  User get userThree => _userThree;
*/
  void addingUsers() {
    _userOne = _userOne;
    //_userTwo = userTwo;
    //_userThree = userThree;

    notifyListeners();
  }
}