import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

import '../Models/Customers.dart';

class SalesInvoiceProvider with ChangeNotifier {
  late String Name = "";
  late String No = "";
  late String MaxOrder = "";

  setSalesInvoice(String Name, String No,String MaxOrder) {
    this.Name = Name;
    this.No = No;
    this.MaxOrder=MaxOrder;
    notifyListeners();
  }
}
