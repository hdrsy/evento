import 'package:evento/core/server/helper_api.dart';

class InterestItem {
  final int id;
  final String icon;
  final String title;

  InterestItem({required this.id, required this.icon, required this.title});

  factory InterestItem.fromJson(Map<String, dynamic> oldJson) {
    Map<String, dynamic> json = removeDuplicateKeysAr(oldJson);

    return InterestItem(
      id: json['id'] ?? 0,
      icon: json['icon'] ?? '',
      title: json['title'] ?? '',
    );
  }
}
