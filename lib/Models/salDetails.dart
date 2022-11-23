class salDetails{

  String name="";
  String itemno="";
  String netprice="";
  String dis="";
  String bounse="";
  String qt="";
  String unit="";
  String distype="";
  String price="";

  salDetails({
    required this.name,
    required this.itemno,
    required this.netprice,
    required this.dis,
    required this.bounse,
    required this.qt,
    required this.unit,
    required this.distype,
    required this.price,
  });

  salDetails.fromMap(Map<dynamic, dynamic> res)
      : itemno = res["itemno"].toString(),
        netprice = res["netprice"].toString(),
        dis = res["dis"].toString(),
        bounse = res["bounse"].toString(),
        qt = res["qt"].toString(),
        unit = res["unit"].toString(),
        distype = res["distype"].toString(),
        name = res["name"].toString(),
        price = res["price"].toString();

  Map<String, Object?> toMap() {
    return {
      'itemno': itemno,
      'netprice': netprice,
      'dis': dis,
      'bounse': bounse,
      'qt': qt,
      'unit': unit,
      'distype': distype,
      'name': name,
      'price': price,
    };
  }

  salDetails.fromJson(Map<String, dynamic> json) {
    itemno = json['itemno'];
    netprice = json['netprice'];
    dis = json['dis'];
    bounse = json['bounse'];
    qt = json['qt'];
    unit = json['unit'];
    distype = json['distype'];
    name = json['name'];
    price = json['price'];

  }


}