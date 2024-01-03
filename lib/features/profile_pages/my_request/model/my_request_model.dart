import 'dart:convert';

class MyRequestModel {
  int id;
  int userId;
  String title;
  String firstName;
  String lastName;
  String phoneNumber;
  DateTime date;
  String startTime;
  String endTime;
  int adults;
  int child;
  List<String> images; // Assuming it's a JSON string of an array
  String? description;
  int venueId;
  List<int> serviceProviderId; // Assuming it's a JSON string of an array
  String? additionalNotes;
  String status;
  int categoryId;
  

  MyRequestModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.adults,
    required this.child,
   required this.images ,
    this.description,
    required this.venueId,
    required this.serviceProviderId ,
    this.additionalNotes,
    required this.status,
    required this.categoryId,
   
  });

  factory MyRequestModel.fromJson(Map<String, dynamic> json) {
    List<String> parseImages(String? imagesJson) {
      if (imagesJson == null || imagesJson.isEmpty) return [];
      return List<String>.from(jsonDecode(imagesJson));
    }

    List<int> parseServiceProviders(String? serviceProviderJson) {
      if (serviceProviderJson == null || serviceProviderJson.isEmpty) return [];
      // Decoding and parsing as a list of strings, then converting to int
      var decodedList = jsonDecode(serviceProviderJson) as List;
      return decodedList.map((item) => int.tryParse(item.toString()) ?? 0).toList();
    }

    return MyRequestModel(
      id: json['id'],
      userId: json['user_id'],
      title: json['title'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phoneNumber: json['phone_number'],
      date: DateTime.parse(json['date']),
      startTime: json['start_time'],
      endTime: json['end_time'],
      adults: json['adults'],
      child: json['child'],
       description: json['description'],
      venueId: json['venue_id'],
      images: parseImages(json['images'] ),
    serviceProviderId: parseServiceProviders(json['service_provider_id'] ),
     additionalNotes: json['additional_notes'],
      status: json['status'],
      categoryId: json['category_id'],
     
    );
  }

 }
