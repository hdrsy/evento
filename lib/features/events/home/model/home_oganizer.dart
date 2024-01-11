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
  int followersCount;
  String? friendRequestStatusWithAuthUser;
   
OrganizerHomeInfo organizerHomeInfo;
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
    required this.followersCount,
    required this.friendRequestStatusWithAuthUser,
    required this.organizerHomeInfo,
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
      followersCount: json['followers_count'],
      friendRequestStatusWithAuthUser: json['friend_request_status_with_auth_user'],
      organizerHomeInfo:OrganizerHomeInfo.fromJson( json['organizer_info']),
    );
  }

 
}
class OrganizerHomeInfo {
  final int id;
  final String name;
   bool isFollowedByAuthUser;

  OrganizerHomeInfo({
    required this.id,
    required this.name,
    required this.isFollowedByAuthUser,
  });

  factory OrganizerHomeInfo.fromJson(Map<String, dynamic> json) {
    return OrganizerHomeInfo(
      id: json['id'],
      name: json['name'],
      isFollowedByAuthUser: json['is_followed_by_auth_user'],
    );
  }
}
