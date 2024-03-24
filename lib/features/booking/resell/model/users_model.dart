class UsersModel {
  final int id;
  final String firstName;
  final String lastName;
  final String image;
  final String type;

  UsersModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.type,
    required this.image,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) {
    return UsersModel(
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      image: json['image'] ?? "1",
      type: json['type'] ?? "",
    );
  }
}
