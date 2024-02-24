import 'package:expandable/expandable.dart';

import '../../../../../core/utils/helper/flutter_flow_util.dart';
import '../../../../../core/utils/theme/app_fonts_from_google.dart';
import '../../../../../core/utils/theme/text_theme.dart';
import '../../controller/event_detailes_controller.dart';
import '../../model/event_detailes_model.dart';
import 'inforamtion_event_widgets/amenities_section.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class SeeAllAmenities extends StatelessWidget {
  SeeAllAmenities({super.key});
  final EventDetailesController eventDetailesController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.secondaryBackground,
      appBar: AppBar(
        backgroundColor: customColors.secondaryBackground,
        title: Text(tr("Amenities"),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Available  Amenities",
              style: customTextStyle.bodyMedium.override(
                  fontSize: 16,
                  color: customColors.primaryText,
                  fontWeight: FontWeight.w500,
                  fontFamily: primaryFontFamily,
                  useGoogleFonts: true),
            ).tr(),
            ...List.generate(
                eventDetailesController.eventDetailsModel.amenities.length,
                (index) => AmenitiesCard(
                      amenity: eventDetailesController
                          .eventDetailsModel.amenities[index],
                    ))
          ].divide(const SizedBox(
            height: 10,
          )),
        ),
      ),
    );
  }
}

class AmenitiesCard extends StatefulWidget {
  const AmenitiesCard({super.key, required this.amenity});
  final Amenity amenity;

  @override
  State<AmenitiesCard> createState() => _AmenitiesCardState();
}

class _AmenitiesCardState extends State<AmenitiesCard> {
  late ExpandableController expandableController1;
  @override
  initState() {
    expandableController1 = ExpandableController(initialExpanded: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        controller: expandableController1,
        child: ExpandablePanel(
          theme: const ExpandableThemeData(
            tapHeaderToExpand: true,
            tapBodyToExpand: false,
            // useInkWell: false,

            tapBodyToCollapse: false,
            headerAlignment: ExpandablePanelHeaderAlignment.center,
            hasIcon: false,
          ),
          expanded: Text(
            widget.amenity.pivot.description,
            style: customTextStyle.bodyMedium.override(
              fontFamily: 'Nunito',
              color: customColors.secondaryText,
              useGoogleFonts: false,
            ),
          ),
          collapsed: Container(
            width: MediaQuery.sizeOf(context).width * 0,
            height: 0,
            decoration: BoxDecoration(
              color: customColors.secondaryBackground,
            ),
          ),
          header: SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.amenity.title,
                  style: customTextStyle.bodyMedium.override(
                      fontSize: 14,
                      color: customColors.secondaryText,
                      fontWeight: FontWeight.w500,
                      fontFamily: primaryFontFamily,
                      useGoogleFonts: true),
                ),
                amentitesIcon(widget.amenity.icon)
              ],
            ),
          ),
        ));
  }
}
