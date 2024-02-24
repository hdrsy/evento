import 'package:evento/core/responsive/responsive.dart';
import 'package:marquee/marquee.dart';

import '../../../../../core/shared/widgets/images/network_image.dart';
import '../../../../../core/utils/theme/app_fonts_from_google.dart';
import '../../../../../core/utils/theme/text_theme.dart';
import '../../controller/service_according_category_controller.dart';
import '../../model/service_according_category_model.dart';
import '../../../service_category/controller/service_category_controller.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class ServiceAccordingCard extends StatelessWidget {
  ServiceAccordingCard(
      {super.key,
      required this.serviceProvider,
      required this.serviceCategoryIndex});
  final ServiceProvider serviceProvider;
  final int serviceCategoryIndex;
  final ServiceAccordingCategoryController serviceAccordingCategoryController =
      Get.find();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Get.toNamed('/ServiceAccordingDetailesScreen', arguments: [
          serviceProvider,
          serviceCategoryIndex,
          serviceAccordingCategoryController.isInCustomuzEvent
        ]);
      },
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 12),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: getImageNetwork(
                        url: serviceProvider.profile,
                        width: double.infinity,
                        height: 230)),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: screenWidth * 0.60,
                    height: screenHeight * 0.03,
                    child: serviceProvider.user.firstName.length +
                                serviceProvider.user.lastName.length >
                            30
                        ? Marquee(
                            text: serviceProvider.user.firstName +
                                serviceProvider.user.lastName,
                            scrollAxis: Axis.horizontal,
                            blankSpace: 20.0,
                            velocity: 70.0,
                            pauseAfterRound: const Duration(seconds: 3),
                            style: customTextStyle.bodyMedium.override(
                                useGoogleFonts: false,
                                color: customColors.primaryText,
                                fontFamily: secondaryFontFamily,
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                          )
                        : Text(
                            serviceProvider.user.firstName +
                                serviceProvider.user.lastName,
                            style: customTextStyle.headlineSmall,
                          ),
                  ),
                  serviceAccordingCategoryController.isInCustomuzEvent
                      ? Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Add to Event",
                              style: customTextStyle.bodyMedium.override(
                                fontFamily: 'Nunito',
                                color: customColors.primary,
                                fontSize: 12,
                                useGoogleFonts: true,
                              ),
                            ).tr(),
                            //// to update selected service provier in serviceCategoryController
                            GetBuilder<ServiceCategoryController>(
                                builder: (serviceCategoryController) {
                              return Theme(
                                data: ThemeData(
                                  checkboxTheme: CheckboxThemeData(
                                    visualDensity: VisualDensity.compact,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  unselectedWidgetColor:
                                      customColors.secondaryText,
                                ),
                                child: Checkbox(
                                  value: serviceCategoryController
                                      .isSelectedServiceProvider(
                                          serviceProvider.id,
                                          serviceCategoryIndex),
                                  onChanged: (newValue) async {
                                    serviceCategoryController
                                        .changeSelectedServiceProviderInEachCategory(
                                            serviceProvider.id,
                                            serviceCategoryIndex,
                                            serviceProvider.user.firstName +
                                                serviceProvider.user.lastName);
                                  },
                                  activeColor: customColors.success,
                                  checkColor: customColors.info,
                                ),
                              );
                            }),
                          ],
                        )
                      : const SizedBox.shrink()
                ],
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 8, 4),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "${tr("Location")}: ${tr(serviceProvider.address)}",
                        style: customTextStyle.labelMedium.override(
                            fontFamily: secondaryFontFamily,
                            useGoogleFonts: true,
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Text(
                      serviceProvider.rating.toString(),
                      style: customTextStyle.labelMedium,
                    ),
                    Icon(
                      Icons.star_rounded,
                      color: customColors.pending,
                      size: 15,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
