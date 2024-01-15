class FreindsModel {
  final int id;
  final String firstName;
  final String lastName;
  final String image;
  final String status;

  FreindsModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.image,
    required this.status,
  });

  factory FreindsModel.fromJson(Map<String, dynamic> json) {
    
    return FreindsModel(
      id: json['id'],
      lastName: json['last_name'],
      image: json['image'],
      status: json['friend_request_status_with_auth_user'],
      firstName: json['first_name'],
    );
  }
}
