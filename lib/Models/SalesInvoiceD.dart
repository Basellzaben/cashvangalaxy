class SalesInvoiceD{
  
  String Bounce="";
  String DisAmtFromHdr="";
  String DisPerFromHdr="";
  String Dis_Amt="";
  String Discount="";
  String ItemOrgPrice="";
  String Operand="";
  String ProID="";
  String Pro_amt="";
  String Pro_bounce="";
  String Pro_dis_Per="";
  String Unite="";
  String UniteNm="";
  String name="";
  String no="";
  String price="";
  String pro_Total="";
  String qty="";
  String tax="";
  String tax_Amt="";
  String total="";
  String weight="";
  String orderno="";
  String distype="";

  SalesInvoiceD({
    required this.Bounce,
    required this.DisAmtFromHdr,
    required this.DisPerFromHdr,
    required this.Dis_Amt,
    required this.Discount,
    required  this.ItemOrgPrice,
    required this.Operand,
    required this.ProID,
    required this.Pro_amt,
    required this.Pro_bounce,
    required this.Pro_dis_Per,
    required this.Unite,
    required this.UniteNm,
    required  this.name,
    required this.no,

    required this.price,
    required this.pro_Total,
    required this.qty,
    required this.tax,
    required this.tax_Amt,
    required this.total,
    required this.weight,
    required this.orderno,
    required this.distype,

  });

  SalesInvoiceD.fromMap(Map<dynamic, dynamic> res)
      : Bounce = res["Bounce"].toString(),
        DisAmtFromHdr = res["DisAmtFromHdr"].toString(),
        DisPerFromHdr = res["DisPerFromHdr"].toString(),
        Dis_Amt = res["Dis_Amt"].toString(),
        Discount = res["Discount"].toString(),
        ItemOrgPrice = res["ItemOrgPrice"].toString(),
        Operand = res["Operand"].toString(),
        ProID = res["ProID"].toString(),
        Pro_amt = res["Pro_amt"].toString(),
        Pro_bounce = res["Pro_bounce"].toString(),
        Pro_dis_Per = res["Pro_dis_Per"].toString(),
        Unite = res["Unite"].toString(),
        UniteNm = res["UniteNm"].toString(),
        name = res["name"].toString(),
        no = res["no"].toString(),

        price = res["price"].toString(),
        pro_Total = res["pro_Total"].toString(),
        qty = res["qty"].toString(),
        tax = res["tax"].toString(),
        tax_Amt = res["tax_Amt"].toString(),
        total = res["total"].toString(),
        weight = res["weight"].toString(),
        distype = res["distype"].toString(),

  orderno = res["orderno"].toString();


  Map<String, Object?> toMap() {
    return {
      'Bounce': Bounce,
      'DisAmtFromHdr': DisAmtFromHdr,
      'DisPerFromHdr': DisPerFromHdr,
      'Dis_Amt': Dis_Amt,
      'Discount': Discount,
      'ItemOrgPrice': ItemOrgPrice,
      'Operand': Operand,
      'ProID': ProID,

      'Pro_amt': Pro_amt,
      'Pro_bounce': Pro_bounce,
      'Pro_dis_Per': Pro_dis_Per,
      'Unite': Unite,
      'UniteNm': UniteNm,
      'name': name,
      'no': no,

      'price': price,
      'pro_Total': pro_Total,
      'qty': qty,
      'tax': tax,
      'tax_Amt': tax_Amt,
      'total': total,
      'weight': weight,
      'orderno': orderno,
      'distype': distype,

    };
  }



  SalesInvoiceD.fromJson(Map<String, dynamic> json) {
    Bounce = json['Bounce'];
    DisAmtFromHdr = json['DisAmtFromHdr'];
    DisPerFromHdr = json['DisPerFromHdr'];
    Dis_Amt = json['Dis_Amt'];
    Discount = json['Discount'];
    ItemOrgPrice = json['ItemOrgPrice'];
    Operand = json['Operand'] ;

    ProID = json['ProID'];
    Pro_amt = json['Pro_amt'];
    Pro_bounce = json['Pro_bounce'];
    Pro_dis_Per = json['Pro_dis_Per'];
    Unite = json['Unite'];
    UniteNm = json['UniteNm'];
    name = json['name'];
    no = json['no'] ;

    price = json['price'];
    pro_Total = json['pro_Total'];
    qty = json['qty'];
    tax = json['tax'];
    tax_Amt = json['tax_Amt'];
    total = json['total'];
    weight = json['weight'];
    orderno = json['orderno'];
    distype = json['distype'];

  }

}