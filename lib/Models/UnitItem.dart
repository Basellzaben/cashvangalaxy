class UnitItem {
  String item_no = "";
  String posprice = "";
  String price = "";
  String Operand = "";
  String Max = "";
  String Min = "";
  String acc_num = "";
  String UnitSale = "";
  String unitno = "";
  String barcode = "";

  UnitItem({
    required this.item_no,
    required this.posprice,
    required this.price,
    required this.Operand,
    required this.Max,
    required this.Min,
    required this.acc_num,
    required this.UnitSale,
    required this.unitno,
    required this.barcode,
  });

  UnitItem.fromMap(Map<dynamic, dynamic> res)
      : item_no = res["item_no"].toString(),
        posprice = res["posprice"].toString(),
        price = res["price"].toString(),
        Operand = res["Operand"].toString(),
        Max = res["Max"].toString(),
        Min = res["Min"].toString(),
        barcode = res["barcode"].toString(),
        unitno = res["unitno"].toString(),
        UnitSale = res["UnitSale"].toString(),
  acc_num = res["acc_num"].toString();

  Map<String, Object?> toMap() {
    return {
      'item_no': item_no,
      'posprice': posprice,
      'price': price,
      'Operand': Operand,
      'Max': Max,
      'Min': Min,
      'acc_num': acc_num,
      'barcode': barcode,
      'unitno': unitno,
      'UnitSale': UnitSale,
    };
  }

  UnitItem.fromJson(Map<String, dynamic> json) {
    item_no = json['Companyitem_no'];
    posprice = json['CompanyNm'];
    price = json['price'];
    Operand = json['OperandMobile'];
    Max = json['TaxAcc1'];
    Min = json['TaxAcc2'];
    acc_num = json['acc_num'];
    UnitSale = json['UnitSale'];
    unitno = json['unitno'];
    barcode = json['barcode'];
  }
}
