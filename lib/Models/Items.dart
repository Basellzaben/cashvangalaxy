class Items{


  String Item_No="";
  String Item_Name="";
  String Ename="";
  String Unit="";
  String OL="";
  String Type_No="";
  String Pack="";
  String Place="";
  String Price="";
  String dno="";
  String tax="";
  String OQ1="";
  String ItemWeight="";

  Items({
    required this.Item_No,
    required this.Item_Name,
    required this.Ename,
    required this.Unit,
    required this.OL,
    required  this.Type_No,
  required this.Pack,
  required this.Place,
    required this.Price,

    required this.dno,
    required this.tax,
    required this.OQ1,
    required this.ItemWeight,


  });

  Items.fromMap(Map<dynamic, dynamic> res)
      : Item_No = res["Item_No"].toString(),
        Item_Name = res["Item_Name"].toString(),
        Ename = res["Ename"].toString(),
        OL = res["OL"].toString(),
        Type_No = res["Type_No"].toString(),
        Unit = res["Unit"].toString(),
        Pack = res["Pack"].toString(),
  Price = res["Price"].toString(),
  Place = res["Place"].toString(),
  dno = res["dno"].toString(),
  tax = res["tax"].toString(),
        OQ1 = res["OQ1"].toString(),
  ItemWeight = res["ItemWeight"].toString();

  Map<String, Object?> toMap() {
    return {
      'Item_No': Item_No,
      'Item_Name': Item_Name,
      'Ename': Ename,
      'OL': OL,
      'Type_No': Type_No,
      'Pack': Pack,
      'Unit': Unit,
  'Place': Place,
  'Price': Price,
      'dno': dno,
      'tax': tax,
      'OQ1': OQ1,
      'ItemWeight': ItemWeight,

    };
  }



  Items.fromJson(Map<String, dynamic> json) {
    Item_No = json['CompanyItem_No'];
    Item_Name = json['CompanyNm'];
    Ename = json['Ename'];
    Unit = json['UnitMobile'];
    OL = json['TaxAcc1'];
    Type_No = json['TaxAcc2'];
  Pack = json['Pack'] ;
  Place = json['Place'] ;
  Price = json['Price'] ;

    Unit = json['Unit'];
    dno = json['dno'];
    tax = json['tax'];
    OQ1 = json['OQ1'] ;
  }

}