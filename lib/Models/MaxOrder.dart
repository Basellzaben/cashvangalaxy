class MaxOrder{

  String Sales="";
  String Payment="";
  String SalesOrder="";
  String PrepareQty="";
  String RetSales="";
  String PostDely="";
  String ReturnQty="";
  String CustCash="";
  String EnterQty="";
  String TransferQty="";
  String ItemRecepit="";
  String Visits="";

  MaxOrder({
    required this.Sales,
    required this.Payment,
    required this.SalesOrder,
    required this.PrepareQty,
    required this.RetSales,

    required this.PostDely,
    required this.ReturnQty,
    required this.CustCash,
    required this.EnterQty,
    required this.TransferQty,
    required this.ItemRecepit,
    required this.Visits,
  });

  MaxOrder.fromMap(Map<dynamic, dynamic> res)
      : Payment = res["Payment"].toString(),
        SalesOrder = res["SalesOrder"].toString(),
        PrepareQty = res["PrepareQty"].toString(),
        RetSales = res["RetSales"].toString(),
        PostDely = res["PostDely"].toString(),
        ReturnQty = res["ReturnQty"].toString(),
        CustCash = res["CustCash"].toString(),
        EnterQty = res["EnterQty"].toString(),
        TransferQty = res["TransferQty"].toString(),
        ItemRecepit = res["ItemRecepit"].toString(),
        Sales = res["Sales"].toString(),
        Visits = res["Visits"].toString();

  Map<String, Object?> toMap() {
    return {
      'Payment': Payment,
      'SalesOrder': SalesOrder,
      'PrepareQty': PrepareQty,
      'RetSales': RetSales,
      'PostDely': PostDely,
      'ReturnQty': ReturnQty,
      'CustCash': CustCash,
      'EnterQty': EnterQty,
      'TransferQty': TransferQty,
      'Sales': Sales,
      'ItemRecepit': ItemRecepit,
      'Visits': Visits,
    };
  }

  MaxOrder.fromJson(Map<String, dynamic> json) {
    Payment = json['Payment'];
    SalesOrder = json['SalesOrder'];
    PrepareQty = json['PrepareQty'];
    RetSales = json['RetSales'];
    PostDely = json['PostDely'];
    ReturnQty = json['ReturnQty'];
    CustCash = json['CustCash'];
    EnterQty = json['EnterQty'];
    TransferQty = json['TransferQty'];
    Sales = json['Sales'];
    ItemRecepit = json['ItemRecepit'];
    Visits = json['Visits'];

  }
  
  
}