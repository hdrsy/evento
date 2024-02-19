class BookingResponse {
  Map<String, List<BookingO>> booking;

  BookingResponse({
    required this.booking,
  });

  factory BookingResponse.fromJson(Map<String, dynamic> json) {
    Map<String, List<BookingO>> bookingMap = {};
    if (json['Booking'] != null) {
      json['Booking'].forEach((key, value) {
        if (value is List) {
          bookingMap[key] =
              List<BookingO>.from(value.map((x) => BookingO.fromJson(x)));
        }
      });
    }

    return BookingResponse(
      booking: bookingMap,
    );
  }
}

class BookingO {
  int id;
  int userId;
  int classId;
  String firstName;
  String lastName;
  int age;
  String phoneNumber;
  // List<String> interest;
  User user;

  BookingO({
    required this.id,
    required this.userId,
    required this.classId,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.phoneNumber,
    // required this.interest,
    required this.user,
  });

  factory BookingO.fromJson(Map<String, dynamic> json) {
    return BookingO(
      id: json['id'],
      userId: json['user_id'],
      classId: json['class_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      age: json['age'],
      phoneNumber: json['phone_number'],
      // interest: List<String>.from(json['interest'].map((x) => x)),
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  int id;
  String firstName;
  String lastName;
  String image;
  dynamic friendRequestStatusWithAuthUser;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.image,
    required this.friendRequestStatusWithAuthUser,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      image: json['image'],
      friendRequestStatusWithAuthUser:
          json['friend_request_status_with_auth_user'],
    );
  }
}