class ContactInfoModel {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String eventTitle;
  final int adultNumber;
  final int childrenNumber;

  ContactInfoModel(
      {required this.eventTitle,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber,
      required this.adultNumber,
      required this.childrenNumber});
}
