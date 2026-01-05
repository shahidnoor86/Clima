import 'package:intl/intl.dart';

class DateTimeUtils {
  static DateModel formatFromTimestamp(int timestamp,
      {bool isSeconds = false}) {
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
      isSeconds ? timestamp * 1000 : timestamp,
    );
    return DateModel(
        date: DateFormat('dd MMM yyyy').format(dateTime),
        day: DateFormat('EEEE').format(dateTime),
        time: DateFormat('hh:mm a').format(dateTime));
    /* return {
      'date': DateFormat('dd MMM yyyy').format(dateTime), // 05 Jan 2024
      'time': DateFormat('hh:mm a').format(dateTime), // 12:00 AM
      'day': DateFormat('EEEE').format(dateTime), // Friday
    }; */
  }
}

class DateModel {
  String? date;
  String? time;
  String? day;

  DateModel({this.date, this.time, this.day});

  DateModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    time = json['time'];
    day = json['day'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['time'] = this.time;
    data['day'] = this.day;
    return data;
  }
}
