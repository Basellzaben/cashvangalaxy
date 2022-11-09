class Unites{
  String Unitno="";
  String UnitName="";
  String UnitEname="";

  Unites({
    required this.Unitno,
    required this.UnitName,
    required this.UnitEname,
  });

  Unites.fromMap(Map<dynamic, dynamic> res)
      : Unitno = res["Unitno"].toString(),
        UnitName = res["UnitName"].toString(),
        UnitEname = res["UnitEname"].toString();

  Map<String, Object?> toMap() {
    return {
      'Unitno': Unitno,
      'UnitName': UnitName,
      'UnitEname': UnitEname,
    };
  }

  Unites.fromJson(Map<String, dynamic> json) {
    Unitno = json['CompanyUnitno'];
    UnitName = json['CompanyNm'];
    UnitEname = json['UnitEname'];

  }
  
}