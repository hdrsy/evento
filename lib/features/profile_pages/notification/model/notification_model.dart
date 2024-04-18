class NotificationModel {
  final int id;
  final String title;
  final String titlear;
  final String description;
  final String descriptionar;
  final int userId;
  int type;
  final DateTime createdAt;

  NotificationModel({
    required this.id,
    required this.title,
    required this.titlear,
    required this.description,
    required this.descriptionar,
    required this.userId,
    required this.type,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
        id: json['id'] ?? 0,
        title: json['title'] ?? '',
        titlear: json['title_ar'] ?? '',
        description: json['description'] ?? '',
        descriptionar: json['description_ar'] ?? '',
        userId: json['user_id'] ?? 0,
        type: json['seen_type'] ?? 0,
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : DateTime.now());
  }
}
