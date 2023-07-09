import 'package:cleaning_llc/models/timelog_model.dart';

class UserDataModel {
  UserDataModel({
    this.id = "",
    this.companyId = "",
    this.email = "",
    this.firstName = "",
    this.lastName = "",
    this.password = "",
    this.timeLog = const [],

    // this.userImages = const [],
  });

  String id;
  String companyId;
  String email;
  String firstName;
  String lastName;
  String password;
  List<TimeLog> timeLog;
  // List<TimeLog> timeLog;

  // List<UserImageResponseModel> userImages;

  factory UserDataModel.fromJson(json) => UserDataModel(
        id: json["id"] ?? "",
        companyId: json["companyId"] ?? "",
        email: json["email"] ?? "",
        firstName: json["firstName"] ?? "",
        lastName: json["lastName"] ?? "",
        // timeLog: json["timeLog"] as List?? "",
        // timeLog: json["timeLog"] ?? [],
// if (json['identityDocuments'] != null) {
//       identityDocuments = <IdentityDocuments>[];
//       json['identityDocuments'].forEach((v) {
//         identityDocuments!.add(IdentityDocuments.fromJson(v));
//       });}

        // timeLog :
        //     json['timeLog'].forEach((v) {
        //       timeLog!.add(TimeLog.fromJson(v));
        //     }),

        timeLog: (json["timeLog"] as List<dynamic>?)?.map((e) {
              // print(e);
              // TimeLog data = TimeLog(
              //     clockIn: e['clockIn'].toDate(),
              //     clockOut: e['clockOut'].toDate());
              // print(data);
              // return data;
              return TimeLog.fromJson(e);
            }).toList() ??
            [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "companyId": companyId,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        // "timeLog": timeLog.map((log) => log.toJson()).toList(),
      };
}
