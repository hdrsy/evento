import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/buttons/icon_with_container.dart';
import 'package:evento/core/shared/widgets/empty_data/empty_data_widget.dart';
import 'package:evento/core/shared/widgets/images/network_image.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/main.dart';
import '../controller/ticket_in_event_for_organization_controller.dart';
import '../model/ticket_in_event_for_organization_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class TicketsInEventForOrganizerScreen extends StatelessWidget {
  TicketsInEventForOrganizerScreen({super.key});
  final TicketsInEventForOrganizerController goingController =
      Get.put(TicketsInEventForOrganizerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: customColors.secondaryBackground,
        appBar: AppBar(
          backgroundColor: customColors.secondaryBackground,
          title: Text(tr("Tickets"),
              style: customTextStyle.bodyMedium
                  .copyWith(color: customColors.primary, fontSize: 20)),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_rounded,
              color: customColors.primaryText,
              size: 30,
            ),
          ),
        ),
        body: Obx(
          () => goingController.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(
                    color: customColors.primary,
                  ),
                )
              : goingController.isError.value
                  ? EmptyData(
                      icon: Icons.error_outline_outlined,
                      message: "SomeThing Wrong!!",
                    )
                  : goingController.bookingResponse.booking.isEmpty
                      ? EmptyData(
                          icon: Icons.people_rounded,
                          message:
                              "It looks like no one has confirmed attendance yet. Be the first to join!",
                        )
                      : SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 16),
                          child: Column(
                              children: goingController
                                  .bookingResponse.booking.keys
                                  .map((e) => TicketsInEventForOrganizerCard(
                                        goingModel: goingController
                                            .bookingResponse
                                            .booking[e]![0]
                                            .user,
                                        modelId: e,
                                      ))
                                  .toList()
                                  .divide(SizedBox(
                                    height: 10,
                                  ))),
                        ),
        ));
  }
}

class TicketsInEventForOrganizerCard extends StatelessWidget {
  const TicketsInEventForOrganizerCard(
      {super.key, required this.goingModel, required this.modelId});
  final User goingModel;
  final String modelId;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TicketsInEventForOrganizerController>(builder: (context) {
      return GestureDetector(
        onTap: () {
          final TicketsInEventForOrganizerController myBookingController =
              Get.find();
          Get.toNamed('/BookingDetailesForMyBookingScreen',
              arguments: [myBookingController.eventId, goingModel.id]);
        },
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 1),
            child: Container(
              width: screenHeight * 0.15,
              decoration: BoxDecoration(
                color: customColors.secondaryBackground,
              ),
              child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: goingModel.image.length > 6
                              ? getImageNetwork(
                                  url: "/storage/${goingModel.image}",
                                  width: 90,
                                  height: 90)
                              : Image.asset(
                                  'assets/images/${goingModel.image}.png',
                                  width: 90,
                                  height: 90,
                                )),
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                          child: Text(
                            "${goingModel.firstName} ${goingModel.lastName}",
                            style: customTextStyle.bodyLarge,
                          ),
                          // userState(goingModel, modelId)
                        ),
                      ),
                      IconWithContainer(
                          icon: Icons.info_outline,
                          buttonSize: 0,
                          borderRadius: 20,
                          backgroundColor: customColors.primary)
                    ],
                  )),
            ),
          ),
        ),
      );
    });
  }
}
