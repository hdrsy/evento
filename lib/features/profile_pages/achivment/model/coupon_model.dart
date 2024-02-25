class PromoCode {
  final int id;
  final String title;
  final String description;
  final String image;
  final String code;
  final int discount;
  final int limit;
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
    var eventList = json['events'] != null ? json['events'] as List : [];
    List<PromoCodeEvent> events =
        eventList.map((i) => PromoCodeEvent.fromJson(i)).toList();
    return PromoCode(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      code: json['code'] ?? '',
      discount: json['discount'],
      limit: json['limit'],
      startDate: json['start-date'] != null
          ? DateTime.parse(json['start-date'])
          : DateTime.now(),
      endDate: json['end-date'] != null
          ? DateTime.parse(json['end-date'])
          : DateTime.now(),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
      events: events,
    );
  }
}

class PromoCodeEvent {
  final int id;
  final int eventId;
  final int promoCodeId;
  final PromoCodeEventDetails? eventDetails;

  PromoCodeEvent({
    required this.id,
    required this.eventId,
    required this.promoCodeId,
    required this.eventDetails,
  });

  factory PromoCodeEvent.fromJson(Map<String, dynamic> json) {
    print(json['promo_code_id'] is int);
    return PromoCodeEvent(
      id: json['id'] ?? 0,
      eventId: json['event_id'] ?? 0,
      promoCodeId: json['promo_code_id'] ?? 0,
      eventDetails: json['event'] != null
          ? PromoCodeEventDetails.fromJson(json['event'])
          : null,
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
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      titleAr: json['title_ar'] ?? '',
      isFollowedByAuthUser: json['is_followed_by_auth_user'] ?? false,
    );
  }
}
