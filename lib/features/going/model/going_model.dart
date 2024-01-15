class GoingModel {
  final int id;
  final String firstName;
  final String lastName;
  final String image;
  final String type;
   String? friendRequestStatus;

  GoingModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.type,
    required this.image,
    required this.friendRequestStatus
  });


  factory GoingModel.fromJson(Map<String, dynamic> json) {
    
    return GoingModel(
      id: json['id'],
      friendRequestStatus: json['friend_request_status_with_auth_user'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      image: json['image'],
      type: json['type'],
    );
  }


}
