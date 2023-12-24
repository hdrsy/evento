import 'dart:async';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController{
  LatLng? googleMapsCenter=const LatLng(13.106061, -59.613158);
  final googleMapsController = Completer<GoogleMapController>();
   CarouselController? carouselController;

  int carouselCurrentIndex = 1;

  // State field(s) for PageView widget.
  // PageController? pageViewController1;
  
}