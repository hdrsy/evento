
class ServiceCategoryModel {
  final int id;
  final String title;
  final String icon;
  
  ServiceCategoryModel({
    required this.id,
    required this.title,
    required this.icon,
   });

  factory ServiceCategoryModel.fromJson(Map<String, dynamic> json) {
    return ServiceCategoryModel(
      id: json['id'],
      title: json['title'],
      icon: json['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'icon': icon,
    };
  }
}
