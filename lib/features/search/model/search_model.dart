import 'dart:convert';

import 'package:evento/core/server/helper_api.dart';

class SearchModel {
  final int id;
  final String title;
  final DateTime startDate;

  final List<String> images;

  SearchModel(
      {required this.id,
      required this.title,
      required this.startDate,
      required this.images});
  factory SearchModel.fromJson(Map<String, dynamic> oldJson) {
    Map<String, dynamic> json = removeDuplicateKeysAr(oldJson);
    return SearchModel(
        id: json['id'] ?? 0,
        title: json['title'],
        startDate: DateTime.parse(json['start_date']),
        images: json['images'] != null
            ? List<String>.from(jsonDecode(json['images']).map((x) => x))
            : []);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'start_date': startDate.toIso8601String(),
      'images': jsonEncode(images),
    };
  }
}