class GoingModel {
  final int id;
  final String firstName;
  final String lastName;
  final String type;

  GoingModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.type,
  });

  factory GoingModel.fromJson(Map<String, dynamic> json) {
    return GoingModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'type': type,
    };
  }
}
