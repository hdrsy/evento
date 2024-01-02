import 'package:evento/core/shared/widgets/images/network_image.dart';
import 'package:evento/core/utils/theme/app_fonts_from_google.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/customize_event/service_category/controller/service_category_controller.dart';
import 'package:evento/features/customize_event/venue/model/venue_model.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VenueCard extends StatelessWidget {
  VenueCard({super.key, required this.venue});
  final Venue venue;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        Get.toNamed('/VenueDetailesScreen',arguments: venue);
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
                        url: venue.profile,
                              width: double.infinity,
                        height: 230)),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    venue.name,
                    style: customTextStyle.headlineSmall,
                  ),
                  Row(
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
                      ),
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
                            unselectedWidgetColor: customColors.secondaryText,
                          ),
                          child: Checkbox(
                            value:
                                serviceCategoryController.selectedVenue.value ==
                                    venue.id,
                            onChanged: (newValue) async {
                              serviceCategoryController
                                  .changeSelectedVenue(venue.id,"La Rosa");
                            },
                            activeColor: customColors.success,
                            checkColor: customColors.info,
                          ),
                        );
                      }),
                    ],
                  ),
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
                        "Location: ${venue.governorate}",
                        style: customTextStyle.labelMedium.override(
                            fontFamily: secondaryFontFamily,
                            useGoogleFonts: true,
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Text(
                      "4.25",
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
