class Time{
var Dayofnumber;
var Nameofday;
var Date,Timee;

Time(
      this.Dayofnumber,
      this.Nameofday,
      this.Date,
      this.Timee);


Time.fromJson(Map<String, dynamic> json) {
  Dayofnumber = json['Dayofnumber'].toString();
  Nameofday = json['Nameofday'].toString();
  Date = json['Date'].toString();
  Timee = json['Time'].toString();


}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['Dayofnumber'] = this.Dayofnumber;
  data['Nameofday'] = this.Nameofday;
  data['Date'] = this.Date;
  data['Time'] = this.Timee;


  return data;
}}
