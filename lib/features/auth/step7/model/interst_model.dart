class InterestItem {
  final int id;
  final String icon;
  final String title;

  InterestItem({required this.id, required this.icon, required this.title});

  factory InterestItem.fromJson(Map<String, dynamic> json) {
    return InterestItem(
      id: json['id'],
      icon: json['icon'],
      title: json['title'],
    );
  }
}
