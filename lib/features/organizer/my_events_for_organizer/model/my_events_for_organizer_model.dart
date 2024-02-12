import 'dart:convert';

import 'package:evento/core/server/helper_api.dart';

class MyEventsForOrganizerModel {
  final int id;
  final String title;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final DateTime date;
  final String startTime;
  final String endTime;
  final int adults;
  final int child;
  final List<String> images;
  final String? description;
  final String? additionalNotes;
  final String status;
  final int categoryId;
  final String categoryTitle;
  final List<MyRequestServiceProvider> serviceProviders;
  final MyRequestVenue venue;

  MyEventsForOrganizerModel({
    required this.id,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.adults,
    required this.child,
    required this.images,
    this.description,
    this.additionalNotes,
    required this.status,
    required this.categoryId,
    required this.categoryTitle,
    required this.serviceProviders,
    required this.venue,
  });

  factory MyEventsForOrganizerModel.fromJson(Map<String, dynamic> oldJson) {
    Map<String, dynamic> json = removeDuplicateKeysAr(oldJson);

    var imageList = jsonDecode(json['images']) as List<dynamic>;
    List<String> images = imageList.map((e) => e as String).toList();
    var serviceProvidersList = json['service_providers'] as List;
    List<MyRequestServiceProvider> serviceProviders = serviceProvidersList
        .map((i) => MyRequestServiceProvider.fromJson(i))
        .toList();
    return MyEventsForOrganizerModel(
      id: json['id'],
      title: json['title'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phoneNumber: json['phone_number'],
      date: DateTime.parse(json['date']),
      startTime: json['start_time'],
      endTime: json['end_time'],
      adults: json['adults'],
      child: json['child'],
      images: images,
      description: json['description'],
      additionalNotes: json['additional_notes'],
      status: json['status'],
      categoryId: json['category_id'],
      categoryTitle: json['category']['title'],
      serviceProviders: serviceProviders,
      venue: MyRequestVenue.fromJson(json['venue']),
    );
  }
}

class MyRequestServiceProvider {
  final int id;
  final int categoryId;
  final String categoryTitle;
  final String firstName;
  final String lastName;

  MyRequestServiceProvider({
    required this.id,
    required this.categoryId,
    required this.categoryTitle,
    required this.firstName,
    required this.lastName,
  });

  factory MyRequestServiceProvider.fromJson(Map<String, dynamic> json) {
    return MyRequestServiceProvider(
      id: json['id'],
      categoryId: json['category_id'],
      categoryTitle: json['category']['title'],
      firstName: json['user']['first_name'],
      lastName: json['user']['last_name'],
    );
  }
}

class MyRequestVenue {
  final int id;
  final String name;

  MyRequestVenue({
    required this.id,
    required this.name,
  });

  factory MyRequestVenue.fromJson(Map<String, dynamic> oldJson) {
    Map<String, dynamic> json = removeDuplicateKeysAr(oldJson);

    return MyRequestVenue(
      id: json['id'],
      name: json['name'],
    );
  }
}
