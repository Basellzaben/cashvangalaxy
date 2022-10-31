class users {


  String man="" ;
  String name ="";
  String MEName="";
  String StoreNo="" ;
  String Stoped ="";
  String SupNo ="";
  String UserName="" ;
  String Password="" ;
  String MobileNo ="";
  String MobileNo2 ="";
  String MANTYPE ="";
  String AlternativeMan="" ;
  String ManSupervisor="" ;
  String BranchNo="" ;
  String Email ="";
  String SuperVisor_name="" ;
  String SampleSerial="" ;
  String Sname ="";
  String Acc ="";
  String AccName ="";
  String PosAcc ="";
  String PosAccName ="";
  String MaxBouns="" ;
  String MaxDiscount ="";
  String MobileNoSupervisor="";


  users({
      required this.man,
      required this.name,
      required this.MEName,

      required this.StoreNo,
      required this.Stoped,
      required this.SupNo,

      required this.UserName,
      required this.Password,
      required this.MobileNo,

      required this.MobileNo2,
      required this.MANTYPE,
      required this.AlternativeMan,

      required this.ManSupervisor,
      required this.BranchNo,
      required this.Email,
      required this.SuperVisor_name,
      required this.SampleSerial,
      required this.Sname,
      required this.Acc,
      required this.AccName,
      required this.PosAcc,
      required this.PosAccName,
      required this.MaxBouns,
      required this.MaxDiscount,
      required this.MobileNoSupervisor});

  users.fromMap(Map<String, dynamic> res)
      : man = res["man"],
        name = res["name"],
        MEName = res["MEName"],
        StoreNo = res["StoreNo"],
        Stoped = res["Stoped"],
        SupNo = res["SupNo"],
        UserName = res["UserName"],
        Password = res["Password"],
        MobileNo = res["MobileNo"],
        MobileNo2 = res["MobileNo2"],
        MANTYPE = res["MANTYPE"],
  AlternativeMan = res["AlternativeMan"],
        ManSupervisor = res["ManSupervisor"],
        BranchNo = res["BranchNo"],
        Email = res["Email"],
        SuperVisor_name = res["SuperVisor_name"],
        SampleSerial = res["SampleSerial"],
        Sname = res["Sname"],
        Acc = res["Acc"],
        AccName = res["AccName"],
        PosAcc = res["PosAcc"],
        PosAccName = res["PosAccName"],
        MaxBouns = res["MaxBouns"],
        MaxDiscount = res["MaxDiscount"],
        MobileNoSupervisor = res["MobileNoSupervisor"];

  Map<String, Object?> toMap() {
    return {
      'man' : man,
      'name' :name,
      'MEName' : MEName,
      'StoreNo' : StoreNo,
      'Stoped' : Stoped,
      'SupNo' : SupNo,
      'UserName' : UserName,
      'Password' : Password,
      'MobileNo' : MobileNo,
      'MobileNo2' : MobileNo2,
      'MANTYPE' : MANTYPE,
      'AlternativeMan' : AlternativeMan,
      'ManSupervisor' : ManSupervisor,
      'BranchNo' : BranchNo,
      'Email' : Email,
      'SuperVisor_name' : SuperVisor_name,
      'SampleSerial' : SampleSerial,
      'Sname' : Sname,
      'Acc' : Acc,
      'AccName' : AccName,
      'PosAcc' : PosAcc,
      'PosAccName' : PosAccName,
      'MaxBouns' : MaxBouns,
      'MaxDiscount' : MaxDiscount,
      'MobileNoSupervisor' : MobileNoSupervisor,
    };
  }

  users.fromJson(Map<String, dynamic> json) {
    man = json['man'].toString();
    name = json['name'].toString();
    MEName = json['MEName'].toString();
    StoreNo = json['StoreNo'].toString();
    Stoped = json['Stoped'].toString();
    SupNo = json['SupNo'].toString();
    UserName = json['UserName'].toString();
    Password = json['Password'].toString();
    MobileNo = json['MobileNo'].toString();
    MobileNo2 = json['MobileNo2'].toString();
    MANTYPE = json['MANTYPE'].toString() ;
    AlternativeMan = json['AlternativeMan'].toString() ;
    ManSupervisor = json['ManSupervisor'].toString() ;
    BranchNo = json['BranchNo'].toString() ;
    Email = json['Email'].toString() ;
    SuperVisor_name = json['SuperVisor_name'].toString() ;
    SampleSerial = json['SampleSerial'].toString() ;
    Sname = json['Sname'].toString() ;
    Acc = json['Acc'].toString() ;
    AccName = json['AccName'].toString() ;
    PosAcc = json['PosAcc'] .toString();
    PosAccName = json['PosAccName'] .toString();
    MaxBouns = json['MaxBouns'] .toString();
    MaxDiscount = json['MaxDiscount'] .toString();
    MobileNoSupervisor = json['MobileNoSupervisor'].toString();
  }


}