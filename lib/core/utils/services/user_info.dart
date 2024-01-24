import 'package:dartz/dartz.dart';
import '../../server/helper_api.dart';
import '../../server/server_config.dart';
import '../error_handling/erroe_handling.dart';
import '../../../main.dart';
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
    String userInfoJson = jsonEncode(userInfo.toJson());
    await prefService.createString('userInfo', userInfoJson);
  }

  static Future<UserInfo?> getUserInfo() async {
     bool userInfoJson =await  prefService.isContainKey('userInfo');

      print("iscontainuserInfoJson:$userInfoJson");
      print("userInfoJson");
    if (userInfoJson ) {
      final userInfo=jsonDecode( await prefService.readString('userInfo'));
      print("userInfofrom storage:$userInfo");
      return UserInfo.fromJson(userInfo);
    }
    else{
      print("userInfoJson");
      return getUserInfoFromApi();
    }
   
  }
  static Future<UserInfo?> getUserInfoFromApi()async{
      
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token") ;
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
    return null;
    
  
  }
}
