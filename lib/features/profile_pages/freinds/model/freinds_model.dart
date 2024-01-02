class FreindsModel{
  final int id;
  final int senderId;
  final int receiverId;
  final String status;
  
  FreindsModel({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.status,
   });

  factory FreindsModel.fromJson(Map<String, dynamic> json) {
    return FreindsModel(
      id: json['id'],
      senderId: json['sender_id'],
      receiverId: json['receiver_id'],
      status: json['status'],
    );
  }
}
