class Room {
  final String? id;
  final String propertyId;
  final String name;
  List<dynamic> items;

  Room({
    this.id,
    required this.propertyId,
    required this.name,
    required this.items,
  });

  static Room fromJson(json) => Room(
        id: json['id'] ?? "",
        name: json['name'],
        propertyId: json['propertyId'],
        items: json['items'] ?? [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "propertyId": propertyId,
        "name": name,
      };
}
