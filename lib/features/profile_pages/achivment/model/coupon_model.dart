
class PromoCode {
  final int id;
  final String title;
  final String description;
  final String image;
  final String code;
  final String discount;
  final String limit;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<PromoCodeEvent> events;

  PromoCode({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.code,
    required this.discount,
    required this.limit,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.updatedAt,
    required this.events,
  });

  factory PromoCode.fromJson(Map<String, dynamic> json) {
    var eventList = json['events'] as List;
    List<PromoCodeEvent> events = eventList.map((i) => PromoCodeEvent.fromJson(i)).toList();
    return PromoCode(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      code: json['code'],
      discount: json['discount'],
      limit: json['limit'],
      startDate: DateTime.parse(json['start-date']),
      endDate: DateTime.parse(json['end-date']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      events: events,
    );
  }

 }

class PromoCodeEvent {
  final int id;
  final int eventId;
  final int promoCodeId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final PromoCodeEventDetails eventDetails;

  PromoCodeEvent({
    required this.id,
    required this.eventId,
    required this.promoCodeId,
    required this.createdAt,
    required this.updatedAt,
    required this.eventDetails,
  });

  factory PromoCodeEvent.fromJson(Map<String, dynamic> json) {
    return PromoCodeEvent(
      id: json['id'],
      eventId: json['event_id'],
      promoCodeId: json['promo_code_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      eventDetails: PromoCodeEventDetails.fromJson(json['event']),
    );
  }

  
}

class PromoCodeEventDetails {
  final int id;
  final String title;
  final String titleAr;
  final bool isFollowedByAuthUser;

  PromoCodeEventDetails({
    required this.id,
    required this.title,
    required this.titleAr,
    required this.isFollowedByAuthUser,
  });

  factory PromoCodeEventDetails.fromJson(Map<String, dynamic> json) {
    return PromoCodeEventDetails(
      id: json['id'],
      title: json['title'],
      titleAr: json['title_ar'],
      isFollowedByAuthUser: json['is_followed_by_auth_user'],
    );
  }


}
