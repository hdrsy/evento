import 'package:evento/core/server/helper_api.dart';

class OrganizerHome {
  int id;
  String firstName;
  String lastName;
  String phoneNumber;
  String? emailVerifiedAt; // Nullable since the data can be null
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

  factory OrganizerHome.fromJson(Map<String, dynamic> oldJson) {
    Map<String, dynamic> json = removeDuplicateKeysAr(oldJson);

    return OrganizerHome(
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      phoneNumber: json['phone_number'] ?? 00,
      emailVerifiedAt: json['email_verified_at'],
      gender: json['gender'] ?? 'female',
      birthDate: json['birth_date'] != null
          ? DateTime.parse(json['birth_date'])
          : DateTime.now(),
      state: json['state'] ?? '',
      imageUrl: json['image'] ?? '',
      type: json['type'] ?? '',
      followersCount: json['followers_count'] ?? 0,
      friendRequestStatusWithAuthUser:
          json['friend_request_status_with_auth_user'] ?? "",
      organizerHomeInfo:
          OrganizerHomeInfo.fromJson(json['organizer_info'] ?? {}),
    );
  }
}

class OrganizerHomeInfo {
  final int id;
  final String name;
  final String profile;
  bool isFollowedByAuthUser;

  OrganizerHomeInfo({
    required this.id,
    required this.name,
    required this.profile,
    required this.isFollowedByAuthUser,
  });

  factory OrganizerHomeInfo.fromJson(Map<String, dynamic> oldJson) {
    Map<String, dynamic> json = removeDuplicateKeysAr(oldJson);
    print(json);
    return OrganizerHomeInfo(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      profile: json['profile'] ?? '',
      isFollowedByAuthUser: json['is_followed_by_auth_user'] ?? false,
    );
  }
}
