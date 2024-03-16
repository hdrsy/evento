import 'package:carousel_slider/carousel_slider.dart';
import '../../controller/map_controller.dart';
import 'event_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventsList extends StatelessWidget {
  EventsList({super.key});
  final MapController mapController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: GetBuilder<MapController>(builder: (context) {
        print("is the search active:${mapController.isSearchActive.value}");
        return CarouselSlider(
          items: [
            ...List.generate(
                mapController.isSearchActive.value
                    ? mapController.searchResultSearch.length
                    : mapController.events.length,
                (index) => mapController.isSearchActive.value
                    ? EventCard(
                        eventModel: mapController.searchResultSearch[index],
                        modelIndex: index,
                      )
                    : EventCard(
                        eventModel: mapController.events[index],
                        modelIndex: index,
                      ))
          ],
          carouselController: mapController.carouselController,
          options: CarouselOptions(
            initialPage: 1,
            viewportFraction: 0.8,
            disableCenter: true,
            enlargeCenterPage: true,
            enlargeFactor: 0.1,
            enableInfiniteScroll: false,
            scrollDirection: Axis.horizontal,
            autoPlay: false,
            onPageChanged: (index, _) {
              mapController.carouselCurrentIndex = index;
              mapController.updateMarkerAndPosition(index);
            },
          ),
        );
      }),
    );
  }
}
