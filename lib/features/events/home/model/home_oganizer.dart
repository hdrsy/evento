import 'package:evento/core/server/helper_api.dart';

class OrganizerHome {
  int id;
  String firstName;
  String lastName;
  String phoneNumber;
  String gender;
  DateTime birthDate;
  String state;
  String imageUrl;
  String type;
  int followersCount;
  String? friendRequestStatusWithAuthUser;
  final String name;
  final String profile;
  bool isFollowedByAuthUser;

  OrganizerHome({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.gender,
    required this.birthDate,
    required this.state,
    required this.imageUrl,
    required this.type,
    required this.followersCount,
    required this.friendRequestStatusWithAuthUser,
    required this.name,
    required this.profile,
    required this.isFollowedByAuthUser,
  });

  factory OrganizerHome.fromJson(Map<String, dynamic> oldJson) {
    Map<String, dynamic> json = removeDuplicateKeysAr(oldJson);

    return OrganizerHome(
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      phoneNumber: json['phone_number'] ?? "",
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
      name: json['name'] ?? '',
      profile: json['profile'] ?? '',
      isFollowedByAuthUser: json['is_followed_by_auth_user'] ?? false,
    );
  }
}
