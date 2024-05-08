import 'package:evento/core/server/helper_api.dart';
import 'package:evento/features/events/customize_event/serivce_according_category/model/service_according_category_model.dart';

class ServiceProvider {
  int id;
  int userId;
  String name;
  String bio;
  String locationWorkGovernorate;
  String address;
  int categoryId;
  String description;
  String profile;
  String cover;
  String type;
  List<Album> albums; // Assuming albums is a list of dynamic objects

  ServiceProvider({
    required this.id,
    required this.userId,
    required this.name,
    required this.bio,
    required this.locationWorkGovernorate,
    required this.address,
    required this.categoryId,
    required this.description,
    required this.profile,
    required this.cover,
    required this.type,
    required this.albums,
  });

  factory ServiceProvider.fromJson(Map<String, dynamic> oldJson) {
    Map<String, dynamic> json = removeDuplicateKeysAr(oldJson);

    var albumsList = json['albums'] == null ? [] : json['albums'] as List;
    List<Album> albums = albumsList.map((i) => Album.fromJson(i)).toList();
    return ServiceProvider(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? '',
      name: json['name'] ?? '',
      bio: json['bio'] ?? '',
      locationWorkGovernorate: json['location_work_governorate'] ?? '',
      address: json['address'] ?? '',
      categoryId: json['category_id'] ?? 0,
      description: json['description'] ?? '',
      profile: json['profile'] ?? '',
      cover: json['cover'] ?? '',
      type: json['type'],
      albums: albums,
    );
  }
}
