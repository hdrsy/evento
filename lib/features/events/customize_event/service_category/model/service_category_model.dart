import 'package:evento/core/server/helper_api.dart';

class ServiceCategoryModel {
  final int id;
  final String title;
  final String icon;
  final String description;

  ServiceCategoryModel({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
  });

  factory ServiceCategoryModel.fromJson(Map<String, dynamic> oldJson) {
    Map<String, dynamic> json = removeDuplicateKeysAr(oldJson);

    return ServiceCategoryModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      icon: json['icon'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'icon': icon,
      'description': description,
    };
  }
}
