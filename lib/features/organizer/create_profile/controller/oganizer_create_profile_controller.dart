// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

import 'package:evento/core/server/server_config.dart';
import 'package:evento/features/profile_pages/account_type_inner_screens/becom_an_organizer/choice_oganizer_category/controller/choice_organizer_category_controller.dart';
import 'package:evento/main.dart';
class OrganizerCreateProfileController extends GetxController{
late TextEditingController organizerName;
late TextEditingController bio;

late TextEditingController createFolderName;
late List<String > states;
late File? profileImage;
late File? coverImage;
late String? selectedState;
late RxList<FolderModel> foldersModel;
@override
  void onInit() {
    organizerName=TextEditingController();
    bio=TextEditingController();
createFolderName=TextEditingController();
coverImage=null;
profileImage=null;
selectedState=null;
    states = [
      'Aleppo',
      'Al-Ḥasakah',
      'Al-Qamishli',
      'Al-Qunayṭirah',
      'Al-Raqqah',
      'Al-Suwayda',
      'Damascus',
      'Daraa',
      'Dayr al-Zawr',
      'Ḥamah',
      'Homs',
      'Idlib',
      'Latakia',
      'Rif Dimashq'
    ];
    foldersModel=<FolderModel>[].obs;
    super.onInit();
  }
   onPressCreateFolder(){
    foldersModel.add(FolderModel(folderName: createFolderName.text ,mediaList:[]));
    createFolderName.clear();
    Get.back();
  }
  final imagePicker = ImagePicker();
  void pickImageForDashbard(ImageSource imageSource,bool isProfile) async {
    final pickedImage = await imagePicker.pickImage(source: imageSource);
    if (pickedImage != null) {
     isProfile==true? profileImage = File(pickedImage.path):coverImage=File(pickedImage.path);
      ///// for isart the custom image iside avatar list on selected position
      update();
      Get.back();
    }
  }
  onPressDone(){

  }

Future<void> sendFormData() async {
  ChoiceOrganizerCategoryController choiceOrganizerCategoryController=Get.find();
  String token = await prefService.readString("token") ?? "";
    
  var uri = Uri.parse(ServerConstApis.becomeOrganizer);
  var request = http.MultipartRequest('POST', uri);
 request.headers.addAll({
    
    "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
    'Authorization': 'Bearer $token', // Adjust this based on your API's requirements
  });
  // Adding text fields
  request.fields['name'] = organizerName.text;
  request.fields['bio'] = bio.text;
  request.fields['state'] = selectedState!;
  request.fields['category_id'] =choiceOrganizerCategoryController.selectedCategories.toString() ;
 
for (var i = 0; i < foldersModel.length; i++) {
  request.fields['album-${i+1}-name'] = foldersModel[i].folderName;
    for (var imageFile in foldersModel[i].mediaList) {
    var stream = http.ByteStream(imageFile.media.openRead());
    var length = await imageFile.media.length();
    var multipartFile = http.MultipartFile(
      'album-${i + 1}-images', // field name in the request
      stream,
      length,
      contentType: MediaType('application', 'octet-stream') ,
      filename:  Uri.file(imageFile.media.path).pathSegments.last,
    );
    request.files.add(multipartFile);
  }
  
}


  // Sending the request
  try {
    var streamedResponse = await request.send();
  var  response = await http.Response.fromStream(streamedResponse);
        print(response.body);
    if (response.statusCode == 200) {
      print('Uploaded!');
    } else {
      print('Failed to upload');
    }
  } catch (e) {
    print('Error: $e');
  }
}

}


class FolderModel {
  final String folderName;
   List<MediaModel> mediaList;
  FolderModel({
    required this.folderName,
     required this.mediaList,
  });

}
class MediaModel {
    String mediaType;
   File media;
  MediaModel({
    required this.mediaType,
    required this.media,
  });
}
