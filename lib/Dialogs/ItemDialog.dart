import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../GlobalVar.dart';
import '../HexaColor.dart';

class ItemDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LogoutOverlayStatecard();
}

class LogoutOverlayStatecard extends State<ItemDialog>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late http.Response response;
  List<Map<String, dynamic>> _journals = [];
  final TextEditingController searchcontroler = TextEditingController();

  @override
  void initState() {


  }


  @override
  Widget build(BuildContext context) {
    //  if(_journals.length>0)
    return Container(
      child:   Center(
        child: Scaffold(

            key: _scaffoldKey,
            backgroundColor: Colors.white,
            body:Container(
              child: SingleChildScrollView(
                child: Column(children: [
                  SizedBox(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        height: 65,
                        margin: const EdgeInsets.only(top: 40,left: 10,right: 10),
                        width: MediaQuery.of(context).size.width/1.3,
                        child: TextField(
                          controller: searchcontroler,
                          onChanged: refrech(),
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: HexColor(Globalvireables.white),
                            suffixIcon: Icon(Icons.search,color: HexColor(Globalvireables.basecolor),),
                            hintText: "البحث",
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: HexColor(Globalvireables.basecolor)),
                            ),
                          ),
                        ),
                      )),
                  if(_journals.isNotEmpty)
                    SizedBox(
                      height: MediaQuery.of(context).size.height,

                      child: ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _journals.length,
                          itemBuilder: (context, index)
                          =>GestureDetector(
                            onTap: () {
                              setState(() {
                               /* Globalvireables.CustomerName=_journals[index]['name'];
                                Globalvireables.cusNo=_journals[index]['no'];

                                print(_journals[index]['no'].toString()+" nooo");

                                Navigator.pop(context);
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Home_Body()));
*/
                              });
                            },child: Container(
                              margin: const EdgeInsets.only(top: 5),
                              color: index %2==0 ? Colors.white:Colors.black26,
                              height: 50,
                              child: Center(child: Text(_journals[index]['name']))
                          ),)






                      ),

                    ) else
                    Container(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          margin: const EdgeInsets.only(top: 120),
                          child: Image.asset('assets/notfound.png'
                            ,height: 100,width: 100, ),

                        ))

                  //
                ],),
              ),
            )
        ),
      ),
    );
    /*else
    return      Container(

        child: Scaffold(

        key: _scaffoldKey,
        backgroundColor: Colors.white,

            body: Container(
        margin: EdgeInsets.only(top: 400),
        child: Center(child: CircularProgressIndicator())
            )
        )
    );*/
  }

  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(margin: const EdgeInsets.only(left: 7),child:const Text("تسجيل الدخول ..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }

  refrech() {
    setState(() {
      refreshSearch(searchcontroler.text);
    });
  }

  void refreshSearch(String txt) async {
   /* var data = await SQLHelper.searchCustomers(txt);
    setState(() {
      _journals = data;
    });*/
  }




}


