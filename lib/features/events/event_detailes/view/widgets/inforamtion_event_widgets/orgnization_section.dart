import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/events/event_detailes/controller/event_detailes_controller.dart';
import 'package:evento/features/events/event_detailes/model/event_detailes_model.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildOrganizerSection(BuildContext context,Organizer? organizer) {
  EventDetailesController eventDetailesController=Get.find();
  return Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
    child: InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        // context.pushNamed('Organizer-Profile');
      },
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              // context.pushNamed('Organizer-Profile');
            },
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/pexels-brett-sayles-992734.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                   organizer!=null?   "${organizer.firstName} ${organizer.lastName}":"Evento",
                      style: customTextStyle.bodyMedium.override(
                        fontFamily: 'BeerSerif',
                        color:customColors.primaryText,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        useGoogleFonts: false,
                      ),
                    ),
                    Text(
                       organizer!=null?   "${organizer.firstName} ${organizer.lastName}":"Evento",
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
          ),
          GetBuilder<EventDetailesController>(
            builder: (context) {
              return ButtonWidget(
                onPressed: () {
                  
                 eventDetailesController.  followAndUnFollowOrganizer();
                },
                text:eventDetailesController.eventDetailsModel.isOrganizerFollowedByAuthUser? "Un Follow":"Follow",
                options: ButtonOptions(
                  width: 85,
                  height: 21,
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                  iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  color:customColors.primary,
                  textStyle: customTextStyle.titleSmall.override(
                    fontFamily: 'BeerSerif',
                    color:customColors.info,
                    fontSize: 10,
                    fontWeight: FontWeight.normal,
                    useGoogleFonts: false,
                  ),
                  borderSide: BorderSide(
                    color:customColors.primary,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              );
            }
          ),
        ],
      ),
    ),
  );
}
