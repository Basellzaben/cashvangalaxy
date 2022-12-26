class SalesInvoiceH{
  String Cust_No="";
  String Date="";
  String UserID="";
  String OrderNo="";
  String hdr_dis_per="";

  String hdr_dis_value="";
  String Total="";
  String Net_Total="";
  String Tax_Total="";
  String bounce_Total="";
  String include_Tax="";
  String disc_Total="";

  String inovice_type="";
  String CashCustNm="";
  String V_OrderNo="";

  String DocType="";
  String DriverNo="";
  String Pos_System="";
  String OrderDesc="";
  String MOVE="";
  String GSPN="";
  String posted="";



  SalesInvoiceH({
    required this.Cust_No,
    required this.Date,
    required this.UserID,
    required this.OrderNo,
    required this.hdr_dis_per,
    required  this.hdr_dis_value,
    required this.Total,
    required this.Net_Total,
    required this.Tax_Total,
    required this.bounce_Total,
    required this.include_Tax,
    required this.disc_Total,
    required this.inovice_type,
    required  this.CashCustNm,
    required this.V_OrderNo,

    required this.DocType,
    required this.DriverNo,
    required this.Pos_System,
    required this.OrderDesc,
    required this.MOVE,
    required this.GSPN,
    required this.posted,

  });

  SalesInvoiceH.fromMap(Map<dynamic, dynamic> res)
      : Cust_No = res["Cust_No"].toString(),
        Date = res["Date"].toString(),
        UserID = res["UserID"].toString(),
        OrderNo = res["OrderNo"].toString(),
        hdr_dis_per = res["hdr_dis_per"].toString(),
        hdr_dis_value = res["hdr_dis_value"].toString(),
        Total = res["Total"].toString(),
        Net_Total = res["Net_Total"].toString(),
        Tax_Total = res["Tax_Total"].toString(),
        bounce_Total = res["bounce_Total"].toString(),
        include_Tax = res["include_Tax"].toString(),
        disc_Total = res["disc_Total"].toString(),
        inovice_type = res["inovice_type"].toString(),
        CashCustNm = res["CashCustNm"].toString(),
        V_OrderNo = res["V_OrderNo"].toString(),

        DocType = res["DocType"].toString(),
        DriverNo = res["DriverNo"].toString(),
        Pos_System = res["Pos_System"].toString(),
        OrderDesc = res["OrderDesc"].toString(),
        MOVE = res["MOVE"].toString(),
        posted = res["posted"].toString(),
        GSPN = res["GSPN"].toString();


  Map<String, Object?> toMap() {
    return {
      'Cust_No': Cust_No,
      'Date': Date,
      'UserID': UserID,
      'OrderNo': OrderNo,
      'hdr_dis_per': hdr_dis_per,
      'hdr_dis_value': hdr_dis_value,
      'Total': Total,
      'Net_Total': Net_Total,

      'Tax_Total': Tax_Total,
      'bounce_Total': bounce_Total,
      'include_Tax': include_Tax,
      'disc_Total': disc_Total,
      'inovice_type': inovice_type,
      'CashCustNm': CashCustNm,
      'V_OrderNo': V_OrderNo,

      'DocType': DocType,
      'DriverNo': DriverNo,
      'Pos_System': Pos_System,
      'OrderDesc': OrderDesc,
      'MOVE': MOVE,
      'posted': posted,
      'GSPN': GSPN,
    };
  }



  SalesInvoiceH.fromJson(Map<String, dynamic> json) {
    Cust_No = json['Cust_No'];
    Date = json['Date'];
    UserID = json['UserID'];
    OrderNo = json['OrderNo'];
    hdr_dis_per = json['hdr_dis_per'];
    hdr_dis_value = json['hdr_dis_value'];
    Total = json['Total'] ;

    Net_Total = json['Net_Total'];
    Tax_Total = json['Tax_Total'];
    bounce_Total = json['bounce_Total'];
    include_Tax = json['include_Tax'];
    disc_Total = json['disc_Total'];
    inovice_type = json['inovice_type'];
    CashCustNm = json['CashCustNm'];
    V_OrderNo = json['V_OrderNo'] ;

    DocType = json['DocType'];
    DriverNo = json['DriverNo'];
    Pos_System = json['Pos_System'];
    OrderDesc = json['OrderDesc'];
    MOVE = json['MOVE'];
    GSPN = json['GSPN'];
    posted = json['posted'];

  }

}