class Time{
var Dayofnumber;
var NameofDay;
var Date,Timee;

Time( this.Dayofnumber,
      this.NameofDay,
      this.Date,
      this.Timee
    );

Time.fromJson(Map<String, dynamic> json) {
  Dayofnumber = json['Dayofnumber'].toString();
  NameofDay = json['NameofDay'].toString();
  Date = json['Date'].toString();
  Timee = json['Time'].toString();
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['Dayofnumber'] = this.Dayofnumber;
  data['NameofDay'] = this.NameofDay;
  data['Date'] = this.Date;
  data['Time'] = this.Timee;

  return data;
}}
