class Time{
var timezone;
var timezone_offset;
var timezone_offset_with_dst;
var date;
var date_time;
var date_time_txt;
var date_time_wti;
var date_time_ymd;
var date_time_unix;
var time_24;
var time_12;
var week;
var month;
var year;
var year_abbr;
var is_dst;
var dst_savings;

Time(
      this.timezone,
      this.timezone_offset,
      this.timezone_offset_with_dst,
      this.date,
      this.date_time,
      this.date_time_txt,
      this.date_time_wti,
      this.date_time_ymd,
      this.date_time_unix,

      this.time_24,
      this.time_12,
      this.week,
      this.month,
      this.year,
      this.year_abbr,
      this.is_dst,
      this.dst_savings);



Time.fromJson(Map<String, dynamic> json) {
  timezone = json['timezone'];
  timezone_offset = json['timezone_offset'];
  timezone_offset_with_dst = json['timezone_offset_with_dst'];
  date = json['date'];
  date_time = json['date_time'];
  date_time_txt = json['date_time_txt'];
  date_time_wti = json['date_time_wti'];
  date_time_ymd = json['date_time_ymd'];
  date_time_unix = (json['date_time_unix']);

  time_24 = json['time_24'];
  time_12 = json['time_12'];
  week = json['week'];
  month = json['month'];
  year = json['year'];
  year_abbr = (json['year_abbr']);
  is_dst = json['is_dst'];
  dst_savings = json['dst_savings'];


}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['timezone'] = this.timezone;
  data['timezone_offset'] = this.timezone_offset;
  data['timezone_offset_with_dst'] = this.timezone_offset_with_dst;
  data['date'] = this.date;
  data['date_time'] = this.date_time;
  data['date_time_txt'] = this.date_time_txt;
  data['date_time_wti'] = this.date_time_wti;
  data['date_time_ymd'] = this.date_time_ymd;
  data['date_time_unix'] = this.date_time_unix;
  data['time_24'] = this.time_24;
  data['time_12'] = this.time_12;
  data['week'] = this.week;
  data['month'] = this.month;
  data['year'] = this.year;
  data['year_abbr'] = this.year_abbr;
  data['is_dst'] = this.is_dst;
  data['dst_savings'] = this.dst_savings;

  return data;
}}
