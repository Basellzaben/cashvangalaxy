import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

import '../Models/Customers.dart';

class CustomerProvider with ChangeNotifier {
  late String Name = "";
  late String No = "";
  late var Lat = 0.0;
  late var Long = 0.0;
  late String _distanceInMeters  = "";
  late String DayWeek = '';

  setCustomers(String Name, String No,var Lat,var Long) {
    this.Name = Name;
    this.No = No;
    this.Lat=Lat;
    this.Long=Long;

    notifyListeners();
  }

  setdayOFweek(String DayWeek1) {
    DayWeek = DayWeek1;

    //  notifyListeners();
  }
}
