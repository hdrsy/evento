import 'dart:convert';

import 'package:evento/core/server/helper_api.dart';
import 'package:evento/features/events/home/model/offer_model.dart';

class EventDetailsModel {
  final int id;
  final int organizerId;
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final int ticketPrice;
  final String description;
  final String type;
  final String? webSite;
  final String? instagram;
  final String? facebook;
  final String? refundPlicy;
  final String? cancellationPolicy;
  final List<String> images;
  final List<String> videos;
  final bool isFollowedByAuthUser;
  bool isOrganizerFollowedByAuthUser;
  // final List<ServiceProvider> serviceProviders;
  final List<EventTrip> eventTrips;
  final Venue venue;
  final Offer? offer;
  final List<Amenity> amenities;
  final Organizer? organizer;
  final List<CategoryEvent> categoriesEvents;
  final List<Class> classes;
  final List<ServiceProvider> serviceProvider;
  final int capacity;
  final List<Booking> bookings;

  EventDetailsModel({
    required this.bookings,
    required this.id,
    required this.instagram,
    required this.facebook,
    required this.webSite,
    required this.refundPlicy,
    required this.cancellationPolicy,
    required this.capacity,
    required this.organizerId,
    this.organizer,
    this.offer,
    required this.categoriesEvents,
    required this.classes,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.serviceProvider,
    required this.ticketPrice,
    required this.description,
    required this.type,
    required this.images,
    required this.videos,
    required this.isFollowedByAuthUser,
    required this.isOrganizerFollowedByAuthUser,
    // required this.serviceProviders,
    required this.eventTrips,
    required this.venue,
    required this.amenities,

    // Initialize other fields...
  });

  factory EventDetailsModel.fromJson(Map<String, dynamic> oldJson) {
    Map<String, dynamic> json = removeDuplicateKeysAr(oldJson);
    return EventDetailsModel(
      bookings: json['bookings'] != null
          ? List<Booking>.from(json['bookings'].map((x) => Booking.fromJson(x)))
          : [],
      id: json['id'],
      title: json['title'] ?? "UnKnown",
      capacity: json['capacity'] ?? 0,
      startDate: json['start_date'] != null
          ? DateTime.parse(json['start_date'])
          : DateTime.now(),
      endDate: json['end_date'] != null
          ? DateTime.parse(json['end_date'])
          : DateTime.now(),
      ticketPrice: json['ticket_price'] ?? 0,
      description: json['description'] ?? "",
      type: json['type'] ?? "UnKnown",
      instagram: json['instagram'],
      facebook: json['facebook'],
      refundPlicy: json['refund_policy'],
      cancellationPolicy: json['cancellation_policy'],
      webSite: json['website'],
      images: json['images'] != null
          ? jsonDecode(json['images']).cast<String>()
          : [],
      videos: json['videos'] != null
          ? jsonDecode(json['videos']).cast<String>()
          : [],
      isFollowedByAuthUser: json['is_followed_by_auth_user'] ?? false,
      isOrganizerFollowedByAuthUser:
          json['organizer_is_followed_by_auth_user'] ?? false,
      eventTrips: json['event_trips'] != null
          ? List<EventTrip>.from(
              json['event_trips'].map((x) => EventTrip.fromJson(x)))
          : [],
      venue: Venue.fromJson(json['venue'] ?? {}),
      amenities: json['amenities'] != null
          ? List<Amenity>.from(
              json['amenities'].map((x) => Amenity.fromJson(x)))
          : [],
      // Parse other fields...
      organizer: json['organizer'] != null
          ? Organizer.fromJson(json['organizer'])
          : null,
      offer: json['offer'] != null ? Offer.fromJson(json['offer']) : null,
      categoriesEvents: json['categories_events'] != null
          ? List<CategoryEvent>.from(
              json['categories_events'].map((x) => CategoryEvent.fromJson(x)))
          : [],
      classes: List<Class>.from(json['classes'].map((x) => Class.fromJson(x))),
      serviceProvider: json['service_providers'] != null
          ? List<ServiceProvider>.from(json['service_providers']
              .map((x) => ServiceProvider.fromJson(x ?? {})))
          : [],
      organizerId: json['organizer_id'] ?? 0,
    );
  }
}

class Booking {
  final int id;
  final String firstName;
  final String lastName;

  Booking({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      firstName: json['first_name'] ?? "",
      lastName: json['last_name'] ?? '',
    );
  }
}

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String image;

  User({
    required this.id,
    required this.image,
    required this.firstName,
    required this.lastName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? "",
      image: json['image'] ?? "",
      lastName: json['last_name'] ?? '',
    );
  }
}

class Organizer {
  final int id;
  final int mobileUserId;
  final int categoryId;
  final String name;
  final String profile;
  final String bio;
  final String services;
  final String state;
  final String? images; // Assuming images can be null
  bool isOrganizerFollowedByAuthUser;

  Organizer({
    required this.id,
    required this.mobileUserId,
    required this.categoryId,
    required this.name,
    required this.profile,
    required this.bio,
    required this.services,
    required this.state,
    required this.isOrganizerFollowedByAuthUser,
    this.images,
  });

  factory Organizer.fromJson(Map<String, dynamic> json) {
    return Organizer(
      id: json['id'] ?? "",
      mobileUserId: json['mobile_user_id'] ?? 0,
      categoryId: json['category_id'] ?? 1,
      name: json['name'] ?? '',
      profile: json['profile'] ?? '',
      bio: json['bio'] ?? '',
      services: json['services'] ?? '',
      state: json['state'] ?? '',
      images: json['images'] ?? '',
      isOrganizerFollowedByAuthUser: json['is_followed_by_auth_user'] ?? false,
    );
  }
}

class CategoryEvent {
  final int id;
  final String title;
  final String icon;

  CategoryEvent({
    required this.id,
    required this.title,
    required this.icon,
  });

  factory CategoryEvent.fromJson(Map<String, dynamic> oldJson) {
    Map<String, dynamic> json = removeDuplicateKeysAr(oldJson);

    return CategoryEvent(
      id: json['id'],
      title: json['title'] ?? "",
      icon: json['icon'] ?? '',
    );
  }
}

class Class {
  final int id;
  final int eventId;
  final String code;
  final String description;
  final int ticketPrice;
  final int ticketNumber;
  final List<Amenity> interests;

  Class({
    required this.id,
    required this.eventId,
    required this.code,
    required this.description,
    required this.ticketPrice,
    required this.ticketNumber,
    required this.interests,
  });

  factory Class.fromJson(Map<String, dynamic> oldJson) {
    Map<String, dynamic> json = removeDuplicateKeysAr(oldJson);

    return Class(
      id: json['id'] ?? 0,
      eventId: json['event_id'] ?? 0,
      description: json['description'] ?? 0,
      code: json['code'] ?? '',
      ticketPrice: json['ticket_price'] ?? 0,
      ticketNumber: json['ticket_number'] ?? 0,
      interests: json['amenities'] != null
          ? List<Amenity>.from(
              json['amenities'].map((x) => Amenity.fromJson(x)))
          : [],
    );
  }
}

class EventTrip {
  final int id;
  final int eventId;
  final DateTime startDate;
  final DateTime endDate;
  final String description;

  EventTrip({
    required this.id,
    required this.eventId,
    required this.startDate,
    required this.endDate,
    required this.description,
  });

  factory EventTrip.fromJson(Map<String, dynamic> oldJson) {
    Map<String, dynamic> json = removeDuplicateKeysAr(oldJson);

    return EventTrip(
      id: json['id'],
      eventId: json['event_id'] ?? 0,
      startDate: json['start_date'] != null
          ? DateTime.parse(json['start_date'])
          : DateTime.now(),
      endDate: json['end_date'] != null
          ? DateTime.parse(json['end_date'])
          : DateTime.now(),
      description: json['description'] ?? "",
    );
  }
}

class Venue {
  final int id;
  final String name;
  final String? profile;

  final String governorate;
  final double latitude;
  final double longitude;

  Venue({
    required this.id,
    required this.name,
    required this.governorate,
    required this.latitude,
    required this.profile,
    required this.longitude,
  });

  factory Venue.fromJson(Map<String, dynamic> oldJson) {
    Map<String, dynamic> json = removeDuplicateKeysAr(oldJson);

    return Venue(
      id: json['id'] ?? 0,
      name: json['name'] ?? "UnKnown",
      profile: json['profile'] ?? "",
      governorate: json['governorate'] ?? "UnKnown",
      latitude: json['latitude'] != null ? json['latitude'].toDouble() : 0.0,
      longitude: json['longitude'] != null ? json['longitude'].toDouble() : 0.0,
    );
  }
}

class Amenity {
  final int id;
  final String title;
  final String icon;
  final Pivot pivot;
  Amenity({
    required this.id,
    required this.title,
    required this.icon,
    required this.pivot,
  });

  factory Amenity.fromJson(Map<String, dynamic> oldJson) {
    Map<String, dynamic> json = removeDuplicateKeysAr(oldJson);
    return Amenity(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      icon: json['icon'] ?? '',
      pivot: Pivot.fromJson(json['pivot'] ?? {}),
    );
  }
}

class Pivot {
  final int eventId;
  final int aminityId;
  int? price;
  final String description;
  Pivot({
    required this.description,
    required this.aminityId,
    required this.eventId,
    required this.price,
  });

  factory Pivot.fromJson(Map<String, dynamic> oldJson) {
    Map<String, dynamic> json = removeDuplicateKeysAr(oldJson);

    return Pivot(
      eventId: json['event_id'] ?? 0,
      aminityId: json['interest_id'] ?? 0,
      description: json['description'] ?? "",
      price: json['price'] ?? 0,
    );
  }
}

class ServiceProvider {
  int id;
  int userId;
  String name;
  String bio;
  dynamic services;
  String locationWorkGovernorate;
  String address;
  int categoryId;
  String description;
  String profile;
  String cover;
  ServiceProvider({
    required this.id,
    required this.userId,
    required this.name,
    required this.bio,
    this.services,
    required this.locationWorkGovernorate,
    required this.address,
    required this.categoryId,
    required this.description,
    required this.profile,
    required this.cover,
  });

  factory ServiceProvider.fromJson(Map<String, dynamic> oldJson) {
    Map<String, dynamic> json = removeDuplicateKeysAr(oldJson);

    return ServiceProvider(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      name: json['name'] ?? "",
      bio: json['bio'] ?? "",
      services: json['services'] ?? '',
      locationWorkGovernorate: json['location_work_governorate'] ?? '',
      address: json['address'] ?? '',
      categoryId: json['category_id'] ?? 0,
      description: json['description'],
      profile: json['profile'] ?? "",
      cover: json['cover'] ?? "",
    );
  }
}
