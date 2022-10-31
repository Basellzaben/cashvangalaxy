class CompanyInfo {

   int ID=0;
   String CName="";
   String Address="";
   String SuperVisor="";
   String TaxNo1="";
   String TaxNo2="";
   int AllowDay=0;
   String Lat="";
   String Long="";
   String StartDate="";
   String CMobile="";

  CompanyInfo({
    required this.ID,
     required this.CName,
    required this.Address,
    required this.SuperVisor,
    required this.TaxNo1,
    required  this.TaxNo2,
    required this.AllowDay,
    required this.Lat,
    required this.Long,
    required this.StartDate,
    required this.CMobile,
  });

  CompanyInfo.fromMap(Map<String, dynamic> res)
      : ID = res["CID"],
        CName = res["CName"],
        Address = res["Address"],
        SuperVisor = res["SuperVisor"],
        TaxNo1 = res["TaxNo1"],
        TaxNo2 = res["TaxNo2"],
        Lat = res["Lat"],
        Long = res["Long"],
        StartDate = res["StartDate"],
        CMobile = res["CMobile"],
        AllowDay = res["AllowDay"];

  Map<String, Object?> toMap() {
    return {
      'CID': ID,
      'CName': CName,
      'Address': Address,
      'SuperVisor': SuperVisor,
      'TaxNo1': TaxNo1,
      'TaxNo2': TaxNo2,
      'Lat': Lat,
      'StartDate': StartDate,
      'Long': Long,
      'CMobile': CMobile,
      'AllowDay': AllowDay,
    };
  }



  CompanyInfo.fromJson(Map<String, dynamic> json) {
    ID = json['CompanyID'];
    CName = json['CompanyNm'];
    Address = json['Address'];
    SuperVisor = json['SuperVisorMobile'];
    TaxNo1 = json['TaxAcc1'];
    TaxNo2 = json['TaxAcc2'];
    Lat = json['lat'];
    StartDate = json['startdate'];
    Long = json['long1'];
    CMobile = json['CompanyMobile'];
    AllowDay = json['allowday'] ;

  }


}