import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/customize_event/serivce_according_category/model/service_according_category_model.dart';
import 'package:evento/features/customize_event/service_category/controller/service_category_controller.dart';
import 'package:evento/features/customize_event/venue/model/venue_model.dart';
import 'package:evento/features/customize_event/venue_detailes/controller/venue_detailes_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NameCheckBox extends StatelessWidget {
   NameCheckBox({super.key, required this.venue, });
final Venue venue;
final VenueDetailesController venueDetailesController=Get.find();
  @override
  Widget build(BuildContext context) {
    return 
Row(
  mainAxisSize: MainAxisSize.max,
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text(
       "Abernathy Reynolds",
      style: customTextStyle.headlineSmall,
    ),
    InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        // context.pushNamed('Services');
      },
      child: Container(
        decoration: BoxDecoration(
          color: customColors.secondaryBackground,
        ),
        child:
 venueDetailesController.isInCustomuzEvent?
         Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              " Add To Event",
              style: customTextStyle.bodyMedium.override(
                    fontFamily: 'Nunito',
                    color: customColors.primary,
                    fontSize: 12,
                    useGoogleFonts: true,
                  ),
            ),
            GetBuilder<ServiceCategoryController>(
              builder: (serviceCategoryController) {
                return Theme(
                  data: ThemeData(
                    checkboxTheme: CheckboxThemeData(
                      visualDensity: VisualDensity.compact,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    unselectedWidgetColor:
                        customColors.secondaryText,
                  ),
                  child: Checkbox(
                    value: serviceCategoryController.selectedVenue.value==venue.id,
                                onChanged: (newValue) async {
                                  serviceCategoryController.changeSelectedVenue(venue.id,"La Rosa");
                                  // serviceCategoryController.changeSelectedServiceProviderInEachCategory(serviceProvider.id, serviceCategoryIndex);
                                },
                    activeColor: customColors.success,
                    checkColor: customColors.info,
                  ),
                );
              }
            ),
          ],
        )
    : Text( "Review Venue",
              style: customTextStyle.bodyMedium.override(
                    fontFamily: 'Nunito',
                    color: customColors.primary,
                    fontSize: 12,
                    useGoogleFonts: true,
                  ),)
    
      ),
    ),
  ],
)
;
  }
}