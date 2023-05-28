class Company {
  final int? id;
  final String companyName;
  final String email;
  final String? password;

  Company(
      {this.id, required this.companyName, required this.email, this.password});

  static Company fromJson(json) => Company(
        id: json['id'] ?? 0,
        email: json['email'],
        companyName: json['companyName'],
        password: json['password'] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "companyName": companyName,
        "email": email,
        "password": password,
      };
}
