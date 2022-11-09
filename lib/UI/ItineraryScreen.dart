import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../GlobalVar.dart';
import '../HexaColor.dart';
import '../Models/Time.dart';
import 'package:http/http.dart' as http;

import 'Home.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ItineraryScreen(),
    ));

Future<Time> getTime() async {
  prefs = await SharedPreferences.getInstance();

  Uri apiUrl = Uri.parse(Globalvireables.urltime);

  http.Response response = await http.get(apiUrl);

  var jsonResponse = json.decode(response.body);

  // var parsedJson = json.decode(jsonResponse);
  var time = Time.fromJson(jsonResponse);
  return time;
}

class ItineraryScreen extends StatefulWidget {
  @override
  State<ItineraryScreen> createState() => _ItineraryScreenState();
}

var activecheck;

var prefs;

class _ItineraryScreenState extends State<ItineraryScreen> {
  late String _currentAddress;

  LatLng currentLatLng = const LatLng(0.0, 0.0);
  late Position _currentPosition;

  int percentage = 0;
  var date, time;

  late GoogleMapController mapController;

  final Set<Marker> _markers = {};

  //LatLng _currentMapPosition = currentLatLng;
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.

    });
  }
  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(currentLatLng.toString()),
        position: currentLatLng,
        infoWindow:
            const InfoWindow(title: 'Nice Place', snippet: 'Welcome to Poland'),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  void _onCameraMove(CameraPosition position) {
    currentLatLng = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition);
    }).catchError((e) {
      //debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition.latitude, _currentPosition.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        /*  lat =  (_currentPosition!.latitude);*/
        /*  long =  _currentPosition!.longitude;*/

        currentLatLng =
            LatLng(_currentPosition.latitude, _currentPosition.longitude);

        _onAddMarkerButtonPressed();
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((_) {
      // debugPrint(e);
    });
  }

  @override
  void initState() {
    super.initState();
    activecheck = true;
    setState(() {
      _getCurrentPosition();
    });

    // getBatteryPerentage();
  }

  @override
  Widget build(BuildContext context) {
    // getTime();
    String timee = "00:00:00";
    String datee = "";

    return StreamBuilder(
        stream: Stream.periodic(const Duration(seconds: 1))
            .asyncMap((i) => getTime()),
        builder: (context, snapshot) {
          if (snapshot.hasData && prefs != null) {
            date = snapshot.data!.date.toString();
            time = snapshot.data!.time_24.toString();
            if (snapshot.data!.time_24.toString().length > 4) {
              timee = snapshot.data!.time_24.toString();
              datee = snapshot.data!.date_time_txt.toString().substring(0, 27);
            }

            return Scaffold(

                appBar: AppBar(
                  backgroundColor: HexColor(Globalvireables.basecolor),
                  title: Row(children: <Widget>[
                    Text(timee),
                    Spacer(),
                    Text("خط السير"),
                  ]),
                  leading: GestureDetector(
                    onTap: () {},
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        size: 30.0,
                        color: HexColor(Globalvireables.white),
                      ),
                      onPressed: () {}, // add custom icons also
                    ),
                  ),
                ),
                backgroundColor: Colors.white70,
                body: Column(children: [
                  Container(
                    color: Colors.white70,
                    height: 30,
                    child: Center(
                        child: Text(
                      datee,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: HexColor(Globalvireables.basecolor)),
                    )),
                  ),
                  Stack(children: <Widget>[
                    SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: Container(
                        color: Colors.white70,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                          ),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            heightFactor: 0.3,
                            widthFactor: 2.5,
                            child: currentLatLng.longitude == 0.0
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : GoogleMap(
                                    onMapCreated: _onMapCreated,
                                    mapType: MapType.hybrid,
                                    initialCameraPosition: CameraPosition(
                                      target: currentLatLng,
                                      zoom: 18.0,
                                    ),
                                    markers: _markers,
                                    onCameraMove: _onCameraMove),
                          ),
                        ),
                      ),
                    ),
                    SafeArea(
                      child: Container(
                        alignment: Alignment.topCenter,
                        decoration: BoxDecoration(
                            color: HexColor(Globalvireables.white2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        margin: EdgeInsets.only(top: 170),
                        height: MediaQuery.of(context).size.height / 1.6,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 60,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: Container(
                                      margin: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        'assets/barcode.png',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Text("30M"),
                                  Text(":المسافة المسموح بها",
                                      style: TextStyle(fontSize: 10)),
                                  Text("30M"),
                                  Container(
                                      child: Text(":المسافة المسموح بها",
                                          style: TextStyle(fontSize: 10)),
                                      margin: const EdgeInsets.all(8.0)),
                                ],
                              ),
                            ),
                            Card(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: SizedBox(
                                          height: 25,
                                          child: Text(""),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: SizedBox(
                                          height: 25,
                                          child: Text(""),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 25,
                                        child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "محمد الخالدي",
                                              style: TextStyle(fontSize: 12),
                                            )),
                                      ),
                                      SizedBox(
                                        height: 25,
                                        child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(": اسم العميل",
                                                style: TextStyle(
                                                    color: HexColor(
                                                        Globalvireables
                                                            .basecolor),
                                                    fontSize: 16))),
                                      )
                                    ],
                                  ),
                                  Text(""),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: SizedBox(
                                          height: 25,
                                          child: Text(""),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: SizedBox(
                                          height: 25,
                                          child: Text(""),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 25,
                                        child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "158525464",
                                              style: TextStyle(fontSize: 12),
                                            )),
                                      ),
                                      SizedBox(
                                        height: 25,
                                        child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(": رقم العميل",
                                                style: TextStyle(
                                                    color: HexColor(
                                                        Globalvireables
                                                            .basecolor),
                                                    fontSize: 16))),
                                      )
                                    ],
                                  ),
                                  Text(""),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: SizedBox(
                                          height: 25,
                                          child: Text(""),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: SizedBox(
                                          height: 25,
                                          child: Text(""),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 25,
                                        child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "لم تتم فتح الزيارة بعد ",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.red),
                                            )),
                                      ),
                                      SizedBox(
                                        height: 25,
                                        child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              ": وقت بداية الزيارة",
                                              style: TextStyle(
                                                  color: HexColor(
                                                      Globalvireables
                                                          .basecolor),
                                                  fontSize: 16),
                                            )),
                                      )
                                    ],
                                  ),
                                  Text(""),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: SizedBox(
                                          height: 25,
                                          child: Text(""),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: SizedBox(
                                          height: 25,
                                          child: Text(""),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 25,
                                        child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "00:00:00",
                                              style: TextStyle(fontSize: 12),
                                            )),
                                      ),
                                      SizedBox(
                                        height: 25,
                                        child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(": مدة الزيارة",
                                                style: TextStyle(
                                                    color: HexColor(
                                                        Globalvireables
                                                            .basecolor),
                                                    fontSize: 16))),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),

                            Expanded(
                              child: Card(
                                color: HexColor(Globalvireables.white2),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Home()));

                                      //   Navigator.pop(context);
                                    },
                                    child: Container(
                                        margin: EdgeInsets.all(5),
                                        child: Icon(
                                          Icons.add_circle,
                                          color: HexColor(Globalvireables.basecolor),
                                          size: 75,
                                        )),
                                  )
                                    ]),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,

                                      children: [
                                       
                                       SizedBox(width: 100,child: TextButton(onPressed:(){}, child: Text("خروج",style: TextStyle(color: Colors.white)),style: OutlinedButton.styleFrom(backgroundColor: Colors.grey,)))
                                        ,SizedBox(width: 100,child: TextButton(onPressed:(){}, child: Text("جولة استثنائية",style: TextStyle(color: Colors.white)),style: OutlinedButton.styleFrom(backgroundColor: HexColor(Globalvireables.basecolor),)))
                                        ,  SizedBox(width: 100,child: TextButton(onPressed:(){}, child: Text("بداية الزيارة",style: TextStyle(color: Colors.white)),style: OutlinedButton.styleFrom(backgroundColor: HexColor(Globalvireables.basecolor),)))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ])
                ]));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
