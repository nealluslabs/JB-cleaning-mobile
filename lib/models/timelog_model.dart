class TimeLog {
  TimeLog({
    this.id = "",
    this.date,
    this.endTime,
    this.propertyId = "",
    this.startTime,
    this.workerId = "",

    // this.userImages = const [],
  });

  String id;
  DateTime? date;
  DateTime? endTime;
  DateTime? startTime;
  String propertyId;
  String workerId;

  // List<UserImageResponseModel> userImages;

  factory TimeLog.fromJson(Map<String, dynamic> json) => TimeLog(
        id: json["id"] ?? "",
        date: json["date"] ?? "",
        endTime: json["endTime"] ?? "",
        startTime: json["startTime"] ?? "",
        propertyId: json["propertyId"] ?? "",
        workerId: json["workerId"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "endTime": endTime,
        "startTime": startTime,
        "propertyId": propertyId,
        "workerId": workerId,
      };
}
