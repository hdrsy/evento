import 'package:easy_localization/easy_localization.dart';
import 'package:evento/core/shared/widgets/guest/guest_popup.dart';
import 'package:evento/core/shared/widgets/images/network_image.dart';

import '../../../../../../core/shared/widgets/buttons/general_button.dart';
import '../../../../../../core/utils/helper/flutter_flow_util.dart';
import '../../../../../../core/utils/theme/text_theme.dart';
import '../../../controller/event_detailes_controller.dart';
import '../../../model/event_detailes_model.dart';
import '../../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildOrganizerSection(BuildContext context, Organizer? organizer) {
  EventDetailesController eventDetailesController = Get.find();
  return Column(
    children: [
      Align(
          alignment: const AlignmentDirectional(-1.00, -1.00),
          child: Text(
            tr("Organizer"),
            style: customTextStyle.bodyMedium.copyWith(
                fontSize: 14,
                color: customColors.primaryText,
                fontWeight: FontWeight.w700),
          )),
      GestureDetector(
        onTap: () async {
          if (isGuset) {
            Get.dialog(GuestPopupWidget());
          } else {
            eventDetailesController.eventDetailsModel.organizer != null
                ? Get.toNamed('/OrganizerProfileScreen',
                    arguments: eventDetailesController
                        .eventDetailsModel.organizer!.organizerInfo.id)
                : null;
          }
        },
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: eventDetailesController.eventDetailsModel.organizer !=
                          null
                      ? getImageNetwork(
                          url: eventDetailesController.eventDetailsModel
                              .organizer!.organizerInfo.profile,
                          width: null,
                          height: null)
                      : Image.asset(
                          'assets/images/Artboard_1.png',
                          fit: BoxFit.cover,
                        ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      organizer != null
                          ? "${organizer.organizerInfo.name} "
                          : "Evento",
                      style: customTextStyle.bodyMedium.override(
                        fontFamily: 'BeerSerif',
                        color: customColors.primaryText,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        useGoogleFonts: false,
                      ),
                    ),
                    Text(
                      "Organizer",
                      style: customTextStyle.bodyMedium.override(
                        fontFamily: 'BeerSerif',
                        fontSize: 12,
                        useGoogleFonts: false,
                      ),
                    ),
                  ],
                ),
              ].divide(const SizedBox(width: 5)),
            ),
            eventDetailesController.eventDetailsModel.organizer == null
                ? SizedBox.shrink()
                : GetBuilder<EventDetailesController>(builder: (context) {
                    return ButtonWidget(
                      onPressed: () {
                        if (isGuset) {
                          Get.dialog(const GuestPopupWidget());
                        } else {
                          eventDetailesController.followAndUnFollowOrganizer();
                        }
                      },
                      text: eventDetailesController
                              .eventDetailsModel.isOrganizerFollowedByAuthUser
                          ? "Un Follow"
                          : "Follow",
                      options: ButtonOptions(
                        width: 85,
                        height: 21,
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                        iconPadding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        color: customColors.primary,
                        textStyle: customTextStyle.titleSmall.override(
                          fontFamily: 'BeerSerif',
                          color: customColors.info,
                          fontSize: 10,
                          fontWeight: FontWeight.normal,
                          useGoogleFonts: false,
                        ),
                        borderSide: BorderSide(
                          color: customColors.primary,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    );
                  }),
          ],
        ),
      ),
    ],
  );
}
