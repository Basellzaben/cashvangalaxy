import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sizer/sizer.dart';
import '../GlobalVar.dart';
import '../HexaColor.dart';
import '../Models/users.dart';
import '../Sqlite/DatabaseHandler.dart';
import '../Sqlite/SharePrefernce.dart';
import '../provider/CompanyProvider.dart';
import 'Home.dart';
import 'Home.dart';
import 'package:http/http.dart' as http;

void main() => runApp(

  ResponsiveSizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Login(),
        );
      }
  )


);
class Login extends StatelessWidget {

  final handler = DatabaseHandler();
   TextEditingController UserNameControler= TextEditingController();
   TextEditingController UserPasswordControler= TextEditingController();
  @override
  void initState(){
  }

  @override
  Widget build(BuildContext context) {
    Future<void> FillDataUsers() async {


      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          handler.DropCompanyInfo();
          showLoaderDialog(context);
          Uri apiUrl = Uri.parse(Globalvireables.GetUsers);

          http.Response response = await http.get(apiUrl).catchError((){
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("تآكد من الاتصال بالانترنت وحاول لاحقا"),
            ));

          });
          if (response.statusCode == 200){
            handler.Dropusers();
            var  jsonResponse = json.decode(response.body) ;

            print (jsonResponse.toString() +"reqquestt");

            String receivedJson = jsonResponse;
            List<dynamic> list = json.decode(receivedJson);

            if(response.body.isNotEmpty) {
              jsonResponse = json.decode(response.body) ;
            }else{
              print (users.fromJson(jsonDecode(jsonResponse[0])).Sname);
            }

            for(int j=0;j<list.length ;j++){
              jsonResponse = json.decode(response.body)[j];
              handler.initializeDB().whenComplete(() async {
                users firstUser = users(
                    man :  users.fromJson((list[j])).man,
                    name : users.fromJson((list[j])).name,
                    MEName : users.fromJson((list[j])).MEName,
                    StoreNo : users.fromJson((list[j])).StoreNo,
                    Stoped : users.fromJson((list[j])).Stoped,
                    SupNo : users.fromJson((list[j])).SupNo,
                    UserName : users.fromJson((list[j])).UserName,
                    Password : users.fromJson((list[j])).Password,
                    MobileNo : users.fromJson((list[j])).MobileNo,
                    MobileNo2 : users.fromJson((list[j])).MobileNo2,
                    MANTYPE : users.fromJson((list[j])).MANTYPE,
                    AlternativeMan : users.fromJson((list[j])).AlternativeMan,
                    ManSupervisor : users.fromJson((list[j])).ManSupervisor,
                    BranchNo : users.fromJson((list[j])).BranchNo,
                    Email : users.fromJson((list[j])).Email,
                    SuperVisor_name : users.fromJson((list[j])).SuperVisor_name,
                    SampleSerial : users.fromJson((list[j])).SampleSerial,
                    Sname : users.fromJson((list[j])).Sname,
                    Acc : users.fromJson((list[j])).Acc,
                    AccName : users.fromJson((list[j])).AccName,
                    PosAcc : users.fromJson((list[j])).PosAcc,
                    PosAccName : users.fromJson((list[j])).PosAccName,
                    MaxBouns : users.fromJson((list[j])).MaxBouns,
                    MaxDiscount : users.fromJson((list[j])).MaxDiscount,
                    MobileNoSupervisor : users.fromJson((list[j])).MobileNoSupervisor
                );

                int i=   await addUsers(firstUser);
                print(i.toString()+" iiiii");
                if(i>0){
                  SharePrefernce.setR('CName', users.fromJson((list[0])).Sname);
                  SharePrefernce.setR('man', users.fromJson((list[0])).man);
                }else{
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("تآكد من الاتصال بالانترنت وحاول لاحقا"),
                  ));
                }
              });}
            Navigator.pop(context);
          }else{

            Navigator.pop(context);
          }

        }
      } on SocketException catch (_) {
        //Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("تآكد من الاتصال بالانترنت وحاول لاحقا"),
        ));
      }




    }

    var isLargeScreen = false;
    var selectedValue = 0.0;
    if (MediaQuery.of(context).size.width > 600) {
      isLargeScreen = true;
      selectedValue=MediaQuery.of(context).size.width as double;
    } else {
      isLargeScreen = false;
      selectedValue=MediaQuery.of(context).size.height as double;
    }

    return Stack(
        children: <Widget>[



          Image.asset(
            "assets/shape1.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),



          Scaffold(
              backgroundColor: Colors.transparent,
              body: SizedBox(
                child: SingleChildScrollView(
                    child: Container(
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              child: Center(
                                child: new Image.asset('assets/logo.png'

    ,height:selectedValue/4
    ,width:selectedValue/3
                                ),
                              ),
                            ),


                            Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                  width:MediaQuery.of(context).size.width/1.1,
                                  height:MediaQuery.of(context).size.width,
                                  child: Card(
                                    elevation: 10,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),

                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              Container(
                                                alignment: Alignment.topLeft,
                                                margin: EdgeInsets.only(top: 40,left: 40),
                                                child: Text('Login !'
                                                  , style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600,color: HexColor(Globalvireables.black)),),
                                              ),

Spacer(),


                                            ],
                                          ),

                                          Container(
                                              margin: EdgeInsets.only(left: 25,right: 25,top: 44),
                                              child: TextField(
                                                controller: UserNameControler,
                                                decoration: InputDecoration(
                                                  prefixIcon: Icon(Icons.email),
                                                  border: OutlineInputBorder(),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:HexColor(Globalvireables.basecolor), width: 0.0),
                                                      borderRadius: BorderRadius.circular(10.0)
                                                  ),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.black, width: 0.0),
                                                      borderRadius: BorderRadius.circular(10.0)

                                                  ),


                                                  contentPadding: EdgeInsets.only(
                                                      top: 18, bottom: 18, right: 20, left: 20),
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  hintText:'Username',

                                                ),
                                              )),

                                          Container(
                                              margin: EdgeInsets.only(left: 25,right: 25,top: 30),
                                              child: TextField(
                                                controller: UserPasswordControler,
keyboardType: TextInputType.visiblePassword,
                                                decoration: InputDecoration(
                                                  prefixIcon: Icon(Icons.password),
                                                  border: OutlineInputBorder(),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:HexColor(Globalvireables.basecolor), width: 0.0),
                                                      borderRadius: BorderRadius.circular(10.0)
                                                  ),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.black, width: 0.0),
                                                      borderRadius: BorderRadius.circular(10.0)

                                                  ),


                                                  contentPadding: EdgeInsets.only(
                                                      top: 18, bottom: 18, right: 20, left: 20),
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  hintText:'Password',

                                                ),
                                              )),


                                          Align(
                                            alignment: Alignment.bottomCenter,

                                            child: Container(
                                              height: 50,
                                              width: 240,
                                              margin: EdgeInsets.only(top: 60,bottom: 30),
                                              color:HexColor(Globalvireables.white),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary:HexColor(Globalvireables.basecolor),
                                                ),
                                                child: Text(
                                                  "Login"
                                                  ,style: TextStyle(color: HexColor(Globalvireables.white),fontSize: 22),
                                                ),
                                                onPressed:
                                                    () async {

                                                    if (await handler.getLogin('Omarmaaitah', '1987')) {
                                                      Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (
                                                                  context) =>
                                                                  Home()));
                                                      print('doneee');
                                                    } else {
                                                      showCustomDialog(context);
                                                      print('errrr');

                                                    }
                                                //  }

                                                },
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),




                                  )),
                            ),

                            Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(top: 15,bottom: 0),
                              child: Center(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        child: Center(
                                          child: Text('Powered by galaxy group @2022'
                                            , style: TextStyle(fontSize: 15,color: HexColor(Globalvireables.basecolor)),),
                                        ),
                                      ),



                                    ]),
                              ),),

                            Container(
                              height: 70,
                              child: IconButton(onPressed: (){
                                FillDataUsers();


                              }, icon: Icon(Icons.update,size: 33,)),
                            ),

                          ],
                        ),
                      ),
                    ),

                ),
              )
          )]);




  }

  void showCustomDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Error",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Container(
            height: 300,
            child: Column(
              children: [
                 Image.asset("assets/loginerror.png",height:300,width: 300,)
             ,
              ],
            ),
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(40)),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }



Future<int> addUsers(users firstUser) async {
  /*CompanyInfo firstUser = CompanyInfo(
        ID: 22,
        CName: 'userProvider.userOne.CName',
        Address: '',
        SuperVisor: '',
        TaxNo1: '',
        TaxNo2: '',
        AllowDay: '',
        Lat: '',
        Long: '',
        StartDate: '',
        CMobile: '',
      );*/
  List<users> listOfUsers = [
    firstUser,
  ];
  return await handler.insertusers(listOfUsers);
}
  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
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

}