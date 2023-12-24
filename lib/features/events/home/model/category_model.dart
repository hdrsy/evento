class CategoryModel {
  final int id;
  final String title;
  final String icon;
   
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
        id: json['id'] ?? 0,
        title: json['title'] ?? '',
        icon: json['icon'] ?? '',

        );
        
  }

  CategoryModel({required this.id, required this.title, required this.icon});
}
