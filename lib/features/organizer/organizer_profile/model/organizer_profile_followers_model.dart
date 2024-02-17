class OrganizerFollowersModel {
  int? id;
  String? firstName;
  String? lastName;
  String? friendRequestStatusWithAuthUser;
  String? profile;
  OrganizerFollowersModel({
    this.id,
    this.firstName,
    this.profile,
    this.lastName,
    this.friendRequestStatusWithAuthUser,
  });

  factory OrganizerFollowersModel.fromJson(Map<String, dynamic> json) {
    return OrganizerFollowersModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      profile: json['image'],
      friendRequestStatusWithAuthUser:
          json['friend_request_status_with_auth_user'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['friend_request_status_with_auth_user'] =
        friendRequestStatusWithAuthUser;
    return data;
  }
}
