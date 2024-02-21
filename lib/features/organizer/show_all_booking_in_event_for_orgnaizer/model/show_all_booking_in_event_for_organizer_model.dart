class ShowAllBookingInEventForOrganizerModel {
  final int id;
  final String profile;
  final String firstName;
  final String lastName;

  ShowAllBookingInEventForOrganizerModel({
    required this.id,
    required this.profile,
    required this.firstName,
    required this.lastName,
  });

  factory ShowAllBookingInEventForOrganizerModel.fromJson(
      Map<String, dynamic> json) {
    return ShowAllBookingInEventForOrganizerModel(
      id: json['id'] ?? 0,
      profile: json['profile'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
    );
  }
}
