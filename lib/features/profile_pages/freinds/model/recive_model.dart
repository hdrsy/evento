class ReceiveRequest {
  int id;
  int senderId;
  int receiverId;
  String status;
  String createdAt;
  String updatedAt;
  Sender sender;

  ReceiveRequest({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.sender,
  });

  factory ReceiveRequest.fromJson(Map<String, dynamic> json) => ReceiveRequest(
        id: json['id'],
        senderId: json['sender_id'],
        receiverId: json['receiver_id'],
        status: json['status'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        sender: Sender.fromJson(json['sender']),
      );
}
class Sender {
  int id;
  String firstName;
  String lastName;
  String image;
  String friendRequestStatusWithAuthUser;

  Sender({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.image,
    required this.friendRequestStatusWithAuthUser,
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        id: json['id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        image: json['image'],
        friendRequestStatusWithAuthUser: json['friend_request_status_with_auth_user'],
      );
}
