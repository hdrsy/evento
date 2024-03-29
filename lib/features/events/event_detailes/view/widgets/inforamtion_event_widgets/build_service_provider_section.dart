import '../../../../../../core/responsive/responsive.dart';
import '../../../../../../core/shared/widgets/images/network_image.dart';
import '../../../../../../core/utils/theme/app_fonts_from_google.dart';
import '../../../../../../core/utils/theme/text_theme.dart';
import '../../../controller/event_detailes_controller.dart';
import '../../../model/event_detailes_model.dart';
import '../see_all_service_providers.dart';
import '../../../../../../main.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class BuildServiceProviderSection extends StatelessWidget {
  BuildServiceProviderSection({super.key});
  final EventDetailesController eventDetailesController = Get.find();
  @override
  Widget build(BuildContext context) {
    final double itemHeight =
        screenHeight * 0.2; // Height of each item, change as needed
    const double mainAxisSpacing = 10; // Spacing between rows
    const int crossAxisCount = 2; // Number of items in a row

    // Calculate the number of rows
    int totalItems =
        eventDetailesController.eventDetailsModel.serviceProvider.length > 4
            ? 4
            : eventDetailesController.eventDetailsModel.serviceProvider.length;
    int numberOfRows = (totalItems / crossAxisCount).ceil();

    // Calculate the total height of the grid
    double totalHeight =
        (numberOfRows * itemHeight) + ((numberOfRows - 1) * mainAxisSpacing);

    return eventDetailesController.eventDetailsModel.serviceProvider.isEmpty
        ? const SizedBox()
        : Column(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 8),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Service Providers",
                      style: customTextStyle.bodySmall.override(
                          fontFamily: primaryFontFamily,
                          color: customColors.primaryText,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          useGoogleFonts: true),
                    ).tr(),
                    GestureDetector(
                      onTap: () async {
                        Get.to(SeeAllServiceProviders(
                            allServiceProviders: eventDetailesController
                                .eventDetailsModel.serviceProvider));
                      },
                      child: Text(
                        "See All",
                        style: customTextStyle.labelSmall.copyWith(
                          color: customColors.primary,
                          fontSize: 10,
                        ),
                      ).tr(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: totalHeight,
                child: GridView.builder(
                    itemCount: eventDetailesController
                                .eventDetailsModel.serviceProvider.length >
                            4
                        ? 4
                        : eventDetailesController.eventDetailsModel
                            .serviceProvider.length, // Max number of items
                    physics:
                        const NeverScrollableScrollPhysics(), // Disables scrolling
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of items in a row
                      // Adjust child aspect ratio and cross axis spacing if needed
                      childAspectRatio: 1,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      return ServiceProviderCard(
                        serviceProvider: eventDetailesController
                            .eventDetailsModel.serviceProvider[index],
                      );
                    }),
              )
            ],
          );
  }
}

class ServiceProviderCard extends StatelessWidget {
  const ServiceProviderCard({super.key, required this.serviceProvider});
  final ServiceProvider serviceProvider;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/ServiceAccordingDetailesForUserScreen',
            arguments: serviceProvider.id);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: serviceProvider.profile == ''
                ? Image.asset(
                    'assets/images/faceBookProfile.jfif',
                    // fit: BoxFit.,
                    alignment: const Alignment(0, 0),
                  )
                : getImageNetworkforCahing(
                    url: "/storage/${serviceProvider.profile}",
                    width: 100,
                    height: 100),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            serviceProvider.name,
            style: customTextStyle.bodyMedium.override(
                fontFamily: primaryFontFamily,
                useGoogleFonts: true,
                color: customColors.primaryText),
          )
        ],
      ),
    );
  }
}
