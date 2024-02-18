import 'package:evento/core/server/helper_api.dart';

class CategoryModel {
  final int id;
  final String title;
  final String icon;
  final String? iconlight;

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> newJson = removeDuplicateKeysAr(json);
    return CategoryModel(
      id: newJson['id'] ?? 0,
      title: newJson['title'] ?? '',
      icon: newJson['icon'] ?? '',
      iconlight: newJson['icon'] ?? '',
    );
  }

  CategoryModel(
      {this.iconlight,
      required this.id,
      required this.title,
      required this.icon});
}
