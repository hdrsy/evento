
class SentRequest {
  int id;
  int senderId;
  int receiverId;
  String status;
  String createdAt;
  String updatedAt;
  Receiver receiver;

  SentRequest({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.receiver,
  });

  factory SentRequest.fromJson(Map<String, dynamic> json) => SentRequest(
        id: json['id'],
        senderId: json['sender_id'],
        receiverId: json['receiver_id'],
        status: json['status'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        receiver: Receiver.fromJson(json['receiver']),
      );
}

class Receiver {
  int id;
  String firstName;
  String lastName;
  String image;
  String friendRequestStatusWithAuthUser;

  Receiver({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.image,
    required this.friendRequestStatusWithAuthUser,
  });

  factory Receiver.fromJson(Map<String, dynamic> json) => Receiver(
        id: json['id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        image: json['image'],
        friendRequestStatusWithAuthUser: json['friend_request_status_with_auth_user'],
      );
}
