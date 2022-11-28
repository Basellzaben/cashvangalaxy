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
import '../Sqlite/DatabaseHandler.dart';
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
  print("mohh = " + jsonResponse);

  var parsedJson = json.decode(jsonResponse);
  var time = Time.fromJson(parsedJson);
  print("mohh = " + time.Date);
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
  String selectedUnit = "...";

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
  TextEditingController dropcontroler = TextEditingController();

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
  List<String> items = [];

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
  List<String> customersitem = [];

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

    return WillPopScope(
      onWillPop: _onBackPressed,

      child: Scaffold(
        body: StreamBuilder(
            stream: Stream.periodic(const Duration(seconds: 1))
                .asyncMap((i) => getTime()),
            builder: (context, snapshot) {
              if (snapshot.hasData && prefs != null) {
                date = snapshot.data!.Date.toString();
                time = snapshot.data!.Timee.toString();
                if (snapshot.data!.Timee.toString().length > 4) {
                  timee = snapshot.data!.Timee.toString();
                  datee = snapshot.data!.Date.toString().substring(0, 10);}
                return Scaffold(
                    appBar: AppBar(
                      backgroundColor: HexColor(Globalvireables.basecolor),
                      title: Row(children: <Widget>[
                        Text(timee),
                        Spacer(),
                        Text("خط السير",style: TextStyle(fontWeight: FontWeight.bold),),
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
                    backgroundColor: Colors.white70,
                    body: SingleChildScrollView(child: Column(children: [
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
                        Container(
                          margin: EdgeInsets.only(top: 30),

                          child: SafeArea(
                            child: Container(
                              alignment: Alignment.topCenter,

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
                                       Spacer(),
                                        Text("30M"),
                                        Text(":المسافة المسموح بها",
                                           ),
                                        Spacer(),

                                        Text("30M"),
                                        Container(
                                            child: Text(":المسافة المسموح بها",
                                           ),
                                            ),
                                        Spacer(),

                                      ],
                                    ),
                                  ),

                                 Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                           Spacer(),
                                            Container(
                                              width: 100,
                                              height: 37,
                                              color: Colors.white12,
                                              child: TextField(

                                                textAlign:
                                                TextAlign.center,
                                                readOnly:
                                                true,
                                                controller:
                                                dropcontroler,
                                                style:
                                                TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                                decoration:
                                                InputDecoration(
                                                  enabledBorder: const OutlineInputBorder(
                                                    borderSide: const BorderSide(color: Colors.black12, width: 3.0),
                                                  ),
                                                  suffixIcon: PopupMenuButton<String>(
                                                    icon: const Icon(Icons.arrow_drop_down),
                                                    onSelected: (String value) {
                                                      dropcontroler.text = value;
                                                      selectedUnit = customersitem.elementAt(items.indexOf(value)); //(Unites.indexOf(value)+1).toString();
                                                      print("indexselected " + selectedUnit.toString());
                                                     // PriceCounter.text = getprice(_journals[index]['Item_No'], selectedUnit, '1.0').substring(0, 4);
                                                     // print("PriceCounter " + PriceCounter.text.toString());
                                                    },
                                                    itemBuilder: (BuildContext context) {
                                                      return items.map<PopupMenuItem<String>>((String? value) {
                                                        return new PopupMenuItem(child: new Text(value!, style: TextStyle(color: Colors.black, fontSize: 25, height: 1.3, fontWeight: FontWeight.bold)), value: value);
                                                      }).toList();
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                           /* SizedBox(
                                              height: 25,
                                              child: Container(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                    " محمد الخالدي ",
                                                    style: TextStyle(fontSize: 16),
                                                  )),
                                            ),*/
                                            SizedBox(
                                              height: 25,
                                              child: Container(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(" : اسم العميل ",
                                                      style: TextStyle(
                                                          color: HexColor(
                                                              Globalvireables
                                                                  .basecolor),
                                                          fontSize: 16,fontWeight: FontWeight.bold))),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 5,),

                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Spacer(),
                                            SizedBox(
                                              height: 25,
                                              child: Container(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                    "158525464",
                                                    style: TextStyle(fontSize: 16),
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
                                                          fontSize: 16 ,fontWeight: FontWeight.bold))),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 5,),

                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Spacer(),
                                            SizedBox(
                                              height: 25,
                                              child: Container(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                    "لم تتم فتح الزيارة بعد ",
                                                    style: TextStyle(
                                                        fontSize: 16,
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
                                                        fontSize: 16,fontWeight: FontWeight.bold),
                                                  )),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 5,),

                                        Container(
                                          alignment: Alignment.center,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [

SizedBox(height: 15,),
                                             Container(
                                                    child: Text("مدة الزيارة",
                                                        style: TextStyle(
                                                            color: HexColor(
                                                                Globalvireables
                                                                    .black),
                                                            fontSize: 26,fontWeight: FontWeight.bold)),
                                              ),
                                             Container(
                                                    child: Text(
                                                      "00:00:00",
                                                      style: TextStyle(fontSize: 33,fontWeight: FontWeight.bold,color: HexColor(
                                                          Globalvireables
                                                          .basecolor)),
                                                    ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),


                                  Expanded(
                                    child: Card(
                                      color: HexColor(Globalvireables.white),
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
                                             ),)
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
                          ),
                        ),

                        Container(
                          child: SizedBox(
                            width: double.infinity,
                            height: 200,
                            child: Container(
                              color: Colors.white70,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(0),
                                  bottomRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(0),
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
                        ),
                      ])
                    ])));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
  Future<bool> _onBackPressed() async{
   /* final handler = DatabaseHandler();
    handler.DropsalDetails();
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Home(),
    ));
*/
    return true;
  }
}
