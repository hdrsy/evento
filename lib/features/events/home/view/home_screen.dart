import '../../../../core/responsive/responsive.dart';
import '../../../../core/utils/helper/flutter_flow_util.dart';
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
      body: RefreshIndicator(
          onRefresh: () {
            return homeController.onrefresh();
          },
          child: buildBody()),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      padding: padding(10, 15, 10, 15),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CategoryList(),
          const SearchAndNotification(),
          FeaturedList(),
          TrendingNow(),
          isGuset ? const SizedBox() : FromYourCity(),
          Offers(),
          isGuset ? const SizedBox() : Orgnizers(),
          isGuset ? const SizedBox() : EventsFromOrganizer(),
          ForYou()
        ].divide(const SizedBox(height: 10)),
      ),
    );
  }
}
