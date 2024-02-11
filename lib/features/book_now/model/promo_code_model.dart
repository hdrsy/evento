class PromoCode {
  final int id;
  final String title;
  final String code;
  final String discount;
  final String limit;
  PromoCode({
    required this.id,
    required this.title,
    required this.code,
    required this.discount,
    required this.limit,
  });

  factory PromoCode.fromJson(Map<String, dynamic> json) {
    return PromoCode(
      id: json['id'],
      title: json['title'],
      code: json['code'],
      discount: json['discount'],
      limit: json['limit'],
    );
  }
}
