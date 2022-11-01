class Categ{

  String ItemCode="";
  String CategNo="";
  String price="";
  String MinPrice="";
  String dis="";
  String bonus="";
  String UnitNo="";
  

  Categ({
    required this.ItemCode,
    required this.CategNo,
    required this.price,
    required this.MinPrice,
    required this.dis,
    required  this.bonus,
    required this.UnitNo,

  });

  Categ.fromMap(Map<dynamic, dynamic> res)
      : ItemCode = res["ItemCode"].toString(),
        CategNo = res["CategNo"].toString(),
        price = res["price"].toString(),
        MinPrice = res["MinPrice"].toString(),
        dis = res["dis"].toString(),
        bonus = res["bonus"].toString(),
        UnitNo = res["UnitNo"].toString();

  Map<String, Object?> toMap() {
    return {
      'ItemCode': ItemCode,
      'CategNo': CategNo,
      'price': price,
      'MinPrice': MinPrice,
      'dis': dis,
      'bonus': bonus,
      'UnitNo': UnitNo,
    };
  }



  Categ.fromJson(Map<String, dynamic> json) {
    ItemCode = json['CompanyItemCode'];
    CategNo = json['CompanyNm'];
    price = json['price'];
    MinPrice = json['MinPriceMobile'];
    dis = json['TaxAcc1'];
    bonus = json['TaxAcc2'];
    UnitNo = json['UnitNo'] ;
  }

}