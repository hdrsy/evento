import 'package:dartz/dartz.dart';
import 'package:evento/core/server/helper_api.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/utils/error_handling/erroe_handling.dart';
import 'package:evento/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserInfo {
  int id;
  String firstName;
  String lastName;
  String phoneNumber;
  String gender;
  String birthDate;
  String state;
  String image;
  String type;
 
  UserInfo({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.gender,
    required this.birthDate,
    required this.state,
    required this.image,
    required this.type,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'first_name': firstName,
        'last_name': lastName,
        'phone_number': phoneNumber,
        'gender': gender,
        'birth_date': birthDate,
        'state': state,
        'image': image,
        'type': type,
         };

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        id: json['id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        phoneNumber: json['phone_number'],
        gender: json['gender'],
        birthDate: json['birth_date'],
        state: json['state'],
        image: json['image'],
        type: json['type'],
      );

  static Future<void> storeUserInfo(UserInfo userInfo) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userInfoJson = jsonEncode(userInfo.toJson());
    await prefs.setString('userInfo', userInfoJson);
  }

  static Future<UserInfo?> getUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userInfoJson = prefs.getString('userInfo');
    if (userInfoJson != null) {
      storeUserInfo(UserInfo.fromJson(jsonDecode(userInfoJson)));
      return UserInfo.fromJson(jsonDecode(userInfoJson));
    }
    else{
      return getUserInfoFromApi();
    }
   
  }
  static Future<UserInfo?> getUserInfoFromApi()async{
      
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token") ?? "";
    response = await ApiHelper.makeRequest(
        targetRout: ServerConstApis.getprofile,
        method: "GEt",
        token: token);

    dynamic handlingResponse = response.fold((l) => l, (r) => r);
    if (handlingResponse is ErrorResponse) {
     } else {
      storeUserInfo(UserInfo.fromJson(handlingResponse["user"]));
       
     
      return UserInfo.fromJson(handlingResponse["user"]);
      
    }
    
  
  }
}
