import '../controller/home_controller.dart';
import 'widgets/category_list.dart';
import 'widgets/events_from_organizer.dart';
import 'widgets/featured_list.dart';
import 'widgets/for_you.dart';
import 'widgets/from_your_city.dart';
import 'widgets/offers.dart';
import 'widgets/orgnizer.dart';
import 'widgets/search_and_notification.dart';
import 'widgets/trending_now.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.secondaryBackground,
      appBar: AppBar(
        backgroundColor: customColors.secondaryBackground,
        title: Text(tr("Home Page"),
            style: customTextStyle.bodyMedium
                .copyWith(color: customColors.primary, fontSize: 20)),
        centerTitle: true,
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          // Load more widgets if at the bottom of the list
          homeController.loadMoreWidgets();
        }
        return true; // to stop propagation
      },
      child: Obx(() {
        return RefreshIndicator(
            onRefresh: () {
              return homeController.onrefresh();
            },
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              itemCount: homeController.loadedWidgetsCount.value +
                  (homeController.loadedWidgetsCount.value <
                          homeController.totalWidgetsCount
                      ? 1
                      : 0),
              itemBuilder: (context, index) {
                if (index >= homeController.loadedWidgetsCount.value) {
                  return const SizedBox();
                } else {
                  return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: _buildWidgetForIndex(index));
                }
              },
            ));
      }),
    );
  }

  Widget _buildWidgetForIndex(int index) {
    // Return the appropriate widget based on the index
    // Similar to how you previously listed your widgets
    // You might need to adjust this logic based on your actual widgets
    switch (index) {
      case 0:
        return CategoryList();
      case 1:
        return const SearchAndNotification();
      // Add cases for your other widgets...
      case 2:
        return FeaturedList();
      case 3:
        return TrendingNow();
      case 4:
        return isGuset ? const SizedBox() : FromYourCity();
      case 5:
        return Offers();
      case 6:
        return isGuset ? const SizedBox() : Orgnizers();
      case 7:
        return isGuset ? const SizedBox() : EventsFromOrganizer();
      case 8:
        return isGuset ? const SizedBox() : ForYou();

      // Add cases for your other widgets...
      default:
        return const SizedBox(); // Placeholder for unhandled indexes
    }
  }
}
