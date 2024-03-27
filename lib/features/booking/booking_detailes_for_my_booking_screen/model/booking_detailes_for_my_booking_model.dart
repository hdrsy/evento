import 'package:evento/features/booking/book_now/model/promo_code_model.dart';
import 'package:evento/features/events/event_detailes/model/event_detailes_model.dart';

class UserBooking {
  final int id;
  final int userId;
  final int eventId;
  final int classId;
  final int? promoCodeId;
  final int invoiceId;
  final String userPhoneNumber;
  final String eventTitle;
  final String classType;
  final String firstName;
  final String lastName;
  final int age;
  final String phoneNumber;
  final List<Amenity> amenities;
  final int classTicketPrice;
  final String status;
  final UserEvent event;
  final PromoCode? promoCode;

  UserBooking({
    required this.id,
    required this.userId,
    required this.eventId,
    required this.classId,
    this.promoCodeId,
    required this.invoiceId,
    required this.userPhoneNumber,
    required this.eventTitle,
    required this.classType,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.phoneNumber,
    required this.amenities,
    required this.classTicketPrice,
    required this.status,
    required this.event,
    this.promoCode,
  });

  factory UserBooking.fromJson(Map<String, dynamic> json) {
    return UserBooking(
      id: json['id'],
      userId: json['user_id'],
      eventId: json['event_id'],
      classId: json['class_id'],
      promoCodeId: json['promo_code_id'],
      invoiceId: json['invoice_id'],
      userPhoneNumber: json['user_phone_number'],
      eventTitle: json['event_title'],
      classType: json['class_type'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      age: json['age'],
      phoneNumber: json['phone_number'],
      amenities: json['amenities'] != null
          ? List<Amenity>.from(
              json['amenities'].map((x) => Amenity.fromJson(x)))
          : [],
      classTicketPrice: json['class_ticket_price'],
      status: json['status'],
      event: UserEvent.fromJson(json['event']),
      promoCode: json['promo_code'] != null
          ? PromoCode.fromJson(json['promo_code'])
          : null,
    );
  }
}

class UserEvent {
  final int id;
  final int organizerId;
  final String title;
  final String description;
  final Organizer? organizer;
  final Venue venue;
  final List<Amenity> amenities;
  UserEvent({
    required this.id,
    required this.organizerId,
    required this.title,
    required this.amenities,
    required this.organizer,
    required this.venue,
    required this.description,
  });

  factory UserEvent.fromJson(Map<String, dynamic> json) {
    return UserEvent(
      id: json['id'],
      organizerId: json['organizer_id'],
      title: json['title'],
      amenities: json['amenities'] != null
          ? List<Amenity>.from(
              json['amenities'].map((x) => Amenity.fromJson(x)))
          : [],
      description: json['description'],
      organizer: json['organizer'] != null
          ? Organizer.fromJson(json['organizer'])
          : null,
      venue: Venue.fromJson(json['venue'] ?? {}),
    );
  }
}
