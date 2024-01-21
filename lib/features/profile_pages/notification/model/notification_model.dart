class NotificationModel {
  final int id;
  final String title;
  final String description;
  final int userId;
  final String type;
  final DateTime createdAt;

  
  NotificationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.userId,
    required this.type,
    required this.createdAt,
   });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    print(json['created_at'] is String);
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      userId: json['user_id'],
      type: json['type'],
      createdAt: DateTime.parse(json['created_at'])
    );
  }


}
