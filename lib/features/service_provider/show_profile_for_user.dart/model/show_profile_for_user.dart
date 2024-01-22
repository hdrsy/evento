
import 'package:evento/features/customize_event/serivce_according_category/model/service_according_category_model.dart';

class ServiceProvider{
  int id;
  int userId;
  String name;
  String nameAr;
  String bio;
  String bioAr;
  String locationWorkGovernorate;
  String address;
  String addressAr;
  int categoryId;
  String description;
  String descriptionAr;
  String profile;
  String cover;
  String type;
  String createdAt;
  String updatedAt;
  List<Album> albums; // Assuming albums is a list of dynamic objects

  ServiceProvider({
    required this.id,
    required this.userId,
    required this.name,
    required this.nameAr,
    required this.bio,
    required this.bioAr,
    required this.locationWorkGovernorate,
    required this.address,
    required this.addressAr,
    required this.categoryId,
    required this.description,
    required this.descriptionAr,
    required this.profile,
    required this.cover,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.albums,
  });

  factory ServiceProvider.fromJson(Map<String, dynamic> json) {
     var albumsList = json['albums'] as List;
  List<Album> albums = albumsList.map((i) => Album.fromJson(i)).toList();

    return ServiceProvider(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      nameAr: json['name_ar'],
      bio: json['bio'],
      bioAr: json['bio_ar'],
      locationWorkGovernorate: json['location_work_governorate'],
      address: json['address'],
      addressAr: json['address_ar'],
      categoryId: json['category_id'],
      description: json['description'],
      descriptionAr: json['description_ar'],
      profile: json['profile'],
      cover: json['cover'],
      type: json['type'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      albums: albums,
    );
  }
}
