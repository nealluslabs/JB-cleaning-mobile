import 'package:cloud_firestore/cloud_firestore.dart';

class TimeLog {
  TimeLog({
    required this.clockIn,
    required this.clockOut,
  });

  DateTime clockIn;
  DateTime clockOut;

  factory TimeLog.fromJson(Map<String, dynamic> json) {
    return TimeLog(
      clockIn: (json['clockIn'] as Timestamp).toDate(),
      clockOut: (json['clockOut'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() => {
        "clockIn": Timestamp.fromDate(clockIn),
        "clockOut": Timestamp.fromDate(clockOut),
      };
}
