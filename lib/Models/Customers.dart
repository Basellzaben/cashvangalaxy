class Customers {
  String No = "";
  String name = "";
  String Ename = "";
  String CUST_PRV_MONTH = "";
  String CUST_NET_BAL = "";
  String Pay_How = "";
  String PAMENT_PERIOD_NO = "";
  String TaxSts = "";
  String CustType = "";
  String barCode = "";
  String Address = "";
  String SMan = "";
  String Latitude = "";
  String Longitude = "";
  String Note2 = "";
  String sat = "";
  String sun = "";
  String mon = "";
  String tues = "";
  String wens = "";
  String thurs = "";
  String sat1 = "";
  String sun1 = "";
  String mon1 = "";
  String tues1 = "";
  String Chqceling = "";
  String wens1 = "";
  String thurs1 = "";
  String Celing = "";
  String CatNo = "";
  String State = "";
  String Cust_type = "";
  String CheckAlowedDay = "";
  String PromotionFlag = "";
  String CloseVisitWithoutimg = "";
  String countryNo = "";
  String countryNm = "";
  String UpdateDate = "";
  String BB = "";
  String BB_Chaq = "";

  Customers({
    required this.No,
    required this.name,
    required this.Ename,
    required this.CUST_PRV_MONTH,
    required this.CUST_NET_BAL,
    required this.Pay_How,
    required this.PAMENT_PERIOD_NO,
    required this.TaxSts,
    required this.CustType,
    required this.barCode,
    required this.Address,
    required this.SMan,
    required this.Latitude,
    required this.Longitude,
    required this.Note2,
    required this.sat,
    required this.sun,
    required this.mon,
    required this.tues,
    required this.wens,
    required this.thurs,
    required this.sat1,
    required this.sun1,
    required this.mon1,
    required this.tues1,
    required this.Chqceling,
    required this.wens1,
    required this.thurs1,
    required this.Celing,
    required this.CatNo,
    required this.State,
    required this.Cust_type,
    required this.CheckAlowedDay,
    required this.PromotionFlag,
    required this.CloseVisitWithoutimg,
    required this.countryNo,
    required this.countryNm,
    required this.UpdateDate,
    required this.BB,
    required this.BB_Chaq,
  });

  Customers.fromMap(Map<dynamic, dynamic> res)
      : No = res["No"].toString(),
        name = res["name"].toString(),
        Ename = res["Ename"].toString(),
        CUST_PRV_MONTH = res["CUST_PRV_MONTH"].toString(),
        CUST_NET_BAL = res["CUST_NET_BAL"].toString(),
        Pay_How = res["Pay_How"].toString(),
        PAMENT_PERIOD_NO = res["PAMENT_PERIOD_NO"].toString(),
        TaxSts = res["TaxSts"].toString(),
        CustType = res["CustType"].toString(),
        barCode = res["barCode"].toString(),
        Address = res["Address"].toString(),
        SMan = res["SMan"].toString(),
        Latitude = res["Latitude"].toString(),
        Longitude = res["Longitude"].toString(),
        Note2 = res["Note2"].toString(),
        sat = res["sat"].toString(),
        sun = res["sun"].toString(),
        mon = res["mon"].toString(),
        tues = res["tues"].toString(),
        wens = res["wens"].toString(),
        thurs = res["thurs"].toString(),
        sat1 = res["sat1"].toString(),
        sun1 = res["sun1"].toString(),
        mon1 = res["mon1"].toString(),
        tues1 = res["tues1"].toString(),
        Celing = res["Celing"].toString(),
        CatNo = res["CatNo"].toString(),
        State = res["State"].toString(),
        Cust_type = res["Cust_type"].toString(),
        CheckAlowedDay = res["CheckAlowedDay"].toString(),
        PromotionFlag = res["PromotionFlag"].toString(),
        CloseVisitWithoutimg = res["CloseVisitWithoutimg"].toString(),
        countryNo = res["countryNo"].toString(),
        countryNm = res["countryNm"].toString(),
        UpdateDate = res["UpdateDate"].toString(),
        BB = res["BB"].toString(),
        BB_Chaq = res["BB_Chaq"].toString();

  Map<String, Object?> toMap() {
    return {
      'CloseVisitWithoutimg': CloseVisitWithoutimg,
      'countryNo': countryNo,
      'countryNm': countryNm,
      'UpdateDate': UpdateDate,
      'BB': BB,
      'BB_Chaq': BB_Chaq,
      'sat1': sat1,
      'sun1': sun1,
      'mon1': mon1,
      'tues1': tues1,
      'Celing': Celing,
      'CatNo': CatNo,
      'State': State,
      'Cust_type': Cust_type,
      'CheckAlowedDay': CheckAlowedDay,
      'PromotionFlag': PromotionFlag,
      'No': No,
      'name': name,
      'Ename': Ename,
      'CUST_PRV_MONTH': CUST_PRV_MONTH,
      'CUST_NET_BAL': CUST_NET_BAL,
      'Pay_How': Pay_How,
      'PAMENT_PERIOD_NO': PAMENT_PERIOD_NO,
      'TaxSts': TaxSts,
      'CustType': CustType,
      'barCode': barCode,
      'Address': Address,
      'SMan': SMan,
      'Latitude': Latitude,
      'Longitude': Longitude,
      'Note2': Note2,
      'sat': sat,
      'sun': sun,
      'mon': mon,
      'tues': tues,
      'wens': wens,
      'thurs': thurs,
    };
  }

  Customers.fromJson(Map<String, dynamic> json) {
    CloseVisitWithoutimg = json['CloseVisitWithoutimg'];
    countryNo = json['countryNo'];
    countryNm = json['countryNm'];
    UpdateDate = json['UpdateDate'];
    BB = json['BB'];
    BB_Chaq = json['BB_Chaq'];
    sat1 = json['sat1'];
    sun1 = json['sun1'];
    mon1 = json['mon1'];
    tues1 = json['tues1'];
    Celing = json['Celing'];
    CatNo = json['CatNo'];
    State = json['State'];
    Cust_type = json['Cust_type'];
    CheckAlowedDay = json['CheckAlowedDay'];
    PromotionFlag = json['PromotionFlag'];
    No = json['No'];
    name = json['name'];
    Ename = json['Ename'];
    CUST_PRV_MONTH = json['CUST_PRV_MONTH'];
    CUST_NET_BAL = json['CUST_NET_BAL'];
    Pay_How = json['Pay_How'];
    PAMENT_PERIOD_NO = json['PAMENT_PERIOD_NO'];
    TaxSts = json['TaxSts'];
    CustType = json['CustType'];
    barCode = json['barCode'];
    Address = json['Address'];
    SMan = json['SMan'];
    Latitude = json['Latitude'];
    Longitude = json['Longitude'];
    Note2 = json['Note2'];
    sat = json['sat'];
    sun = json['sun'];
    mon = json['mon'];
    tues = json['tues'];
    wens = json['wens'];
    thurs = json['thurs'];
  }
}
