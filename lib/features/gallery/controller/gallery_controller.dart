import 'package:get/get.dart';

class GalleryController extends GetxController{
  late List<String> images;
@override
  void onInit() {
   images=Get.arguments??[
    'assets/images/Encore_EventType_TheatreConcertandSpecialEvents_4.jpg',
    'assets/images/events-management.jpg',
    'assets/images/unique-and-exciting-adult-birthday-party-ideas-hero-image.webp',
    'assets/images/unique-and-exciting-adult-birthday-party-ideas-hero-image.webp'
  ];
    super.onInit();
  } 
}