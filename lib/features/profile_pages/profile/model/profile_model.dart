class ProfileModel {
  final int id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String? emailVerifiedAt;
  final String gender;
  final DateTime birthDate;
  final String state;
  final String image;
  final String type;
 
  ProfileModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    this.emailVerifiedAt,
    required this.gender,
    required this.birthDate,
    required this.state,
    required this.image,
    required this.type,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phoneNumber: json['phone_number'],
      emailVerifiedAt: json['email_verified_at'],
      gender: json['gender'],
      birthDate: DateTime.parse(json['birth_date']),
      state: json['state'],
      image: json['image'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'email_verified_at': emailVerifiedAt,
      'gender': gender,
      'birth_date': birthDate.toIso8601String(),
      'state': state,
      'image': image,
      'type': type,
     };
  }
}
