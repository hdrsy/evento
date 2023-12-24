// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrganizerCreateProfileController extends GetxController{
late TextEditingController organizerName;
late TextEditingController bio;
late TextEditingController services;
late TextEditingController createFolderName;
late List<String > states;
late String? selectedState;
late RxList<FolderModel> foldersModel;
@override
  void onInit() {
    organizerName=TextEditingController();
    bio=TextEditingController();
services=TextEditingController();
createFolderName=TextEditingController();
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
    foldersModel.add(FolderModel(folderName: createFolderName.text ,mediaList: []));
    createFolderName.clear();
  }
}


class FolderModel {
  final String folderName;
  List<File> mediaList;
  FolderModel({
    required this.folderName,
     required this.mediaList,
  });

}
