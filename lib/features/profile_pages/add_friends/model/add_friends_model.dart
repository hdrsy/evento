class AddFriendsModel {
  final int id;
  final String firstName;
  final String lastName;
  final String image;
  final String type;
  String? friendRequestStatus;

  AddFriendsModel(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.type,
      required this.image,
      required this.friendRequestStatus});

  factory AddFriendsModel.fromJson(Map<String, dynamic> json) {
    print(json["image"]);
    return AddFriendsModel(
      id: json['id'],
      friendRequestStatus: json['friend_request_status_with_auth_user'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      image: json['image'] ?? "1",
      type: json['type'],
    );
  }
}
