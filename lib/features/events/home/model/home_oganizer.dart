class OrganizerHome {
  int id;
  String firstName;
  String lastName;
  String phoneNumber;
  String? emailVerifiedAt;  // Nullable since the data can be null
  String gender;
  DateTime birthDate;
  String state;
  String imageUrl;
  String type;
  DateTime createdAt;
  DateTime updatedAt;
  int followersCount;
  String? friendRequestStatusWithAuthUser;
   bool isFollowedByAuthUser=false;

  OrganizerHome({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    this.emailVerifiedAt,
    required this.gender,
    required this.birthDate,
    required this.state,
    required this.imageUrl,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.followersCount,
    required this.friendRequestStatusWithAuthUser,
  });

  factory OrganizerHome.fromJson(Map<String, dynamic> json) {
    return OrganizerHome(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phoneNumber: json['phone_number'],
      emailVerifiedAt: json['email_verified_at'],
      gender: json['gender'],
      birthDate: DateTime.parse(json['birth_date']),
      state: json['state'],
      imageUrl: json['image'],
      type: json['type'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      followersCount: json['followers_count'],
      friendRequestStatusWithAuthUser: json['friend_request_status_with_auth_user'],
    );
  }

 
}
