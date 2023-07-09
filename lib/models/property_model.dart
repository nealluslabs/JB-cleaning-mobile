class Property {
  final String? id;
  final String companyId;
  final String propertyAddress;
  final String propertyImg;
  final String? propertyName;
  List<dynamic> rooms;
  // List<dynamic> issues;
  // List<dynamic> checklist;

  Property(
      {this.id,
      required this.companyId,
      required this.propertyAddress,
      required this.rooms,
      required this.propertyImg,
      // required this.issues,
      // required this.checklist,
      this.propertyName});

  static Property fromJson(json) => Property(
        id: json['id'] ?? "",
        propertyAddress: json['propertyAddress'],
        companyId: json['companyId'],
        propertyName: json['propertyName'],
        propertyImg: json['propertyImg'],
        rooms: json['room'] ?? [],
        // issues: json['issues'] ?? [],
        // checklist: json['checklist'] ?? [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "companyId": companyId,
        "propertyAddress": propertyAddress,
        "propertyName": propertyName,
      };
}
