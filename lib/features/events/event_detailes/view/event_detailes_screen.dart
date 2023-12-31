import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/events/event_detailes/controller/event_detailes_controller.dart';
import 'package:evento/features/events/event_detailes/view/widgets/information_event.dart';
import 'package:evento/features/events/event_detailes/view/widgets/main_image.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventDetailesScreen extends StatelessWidget {
  EventDetailesScreen({super.key});
  final EventDetailesController eventDetailesController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: customColors.primaryBackground,
      body: Obx(() => eventDetailesController.isLoading.value
          ? Center(
              child: CircularProgressIndicator(
                color: customColors.secondaryText,
              ),
            )
          : _buildBody()),
    );
  }

  Widget _buildBody() {
    return Stack(
      alignment: Alignment.center,
      children: [
        MainImage(
            imgUrl:
                "/storage/${eventDetailesController.eventDetailsModel.images[0]}"),
        // Positioned(

        //     top: screenHeight * 0.25,
        //     child: Offerprice()),
        Positioned(
            top: screenHeight * 0.32,
            child: InformationEvent(
                eventDetailsModel: eventDetailesController.eventDetailsModel)),
      ],
    );
  }
}

class Offerprice extends StatelessWidget {
  const Offerprice({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 0.9,
      height: 60,
      decoration: const BoxDecoration(
        color: Color(0x95000000),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "300,000 sp",
            style: customTextStyle.bodyMedium.override(
              fontFamily: 'Nunito',
              color: customColors.info,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.lineThrough,
              useGoogleFonts: false,
            ),
          ),
          Text(
            "200,000 sp",
            style: customTextStyle.bodyMedium.override(
              fontFamily: 'Nunito',
              color: customColors.info,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              useGoogleFonts: false,
            ),
          ),
        ].divide(const SizedBox(width: 30)),
      ),
    );
  }
}
