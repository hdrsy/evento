import 'package:carousel_slider/carousel_slider.dart';
import 'package:evento/features/map/controller/map_controller.dart';
import 'package:evento/features/map/view/widgets/event_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventsList extends StatelessWidget {
   EventsList({super.key});
final MapController mapController=Get.find();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
  width: double.infinity,
  child: CarouselSlider(
    items: [
      ...List.generate(3, (index) => const EventCard())
    ],
    carouselController: mapController.carouselController,
    options: CarouselOptions(
          initialPage: 1,
          viewportFraction: 0.8,
          disableCenter: true,
          enlargeCenterPage: true,
          enlargeFactor: 0.1,
          enableInfiniteScroll: true,
          scrollDirection: Axis.horizontal,
          autoPlay: false,
          onPageChanged: (index, _) {
            // setState(() {
            //   _currentCarouselIndex = index;
            // });
          },
        ),
  ));
  }
}