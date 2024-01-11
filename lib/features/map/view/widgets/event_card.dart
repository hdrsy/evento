import 'package:evento/core/shared/widgets/buttons/toggle_icon.dart';
import 'package:evento/core/shared/widgets/images/network_image.dart';
import 'package:evento/core/utils/helper/date_formatter.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/events/home/model/event_model.dart';
import 'package:evento/features/map/controller/map_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key, required this.eventModel, required this.modelIndex});
final EventModel eventModel;
final int modelIndex;
  @override
  Widget build(BuildContext context) {
    return 
        InkWell(
          onTap: (){
              Get.toNamed('/eventDetailes', arguments: eventModel.id);
                 
          },
          child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(15, 15, 15, 10),
              child: Container(
          width: 300,
          height: 200,
          decoration: BoxDecoration(
            color: customColors.secondaryBackground,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: customColors.secondaryBackground,
            ),
          ),
          child: Align(
            alignment: const AlignmentDirectional(0.00, -1.00),
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 130,
                    decoration: const BoxDecoration(),
                    child: SizedBox(
                      width: double.infinity,
                      height: 500,
                      child: PageView(
                        controller: PageController(initialPage: 0),
                        scrollDirection: Axis.horizontal,
                        children: [
                          ...List.generate(eventModel.images.length>3?3:eventModel.images.length, (index) => imageGridView(context,eventModel.images[index],index,eventModel.id,modelIndex))
                        
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 10, 16, 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 100,
                          height: 24,
                          decoration: BoxDecoration(
                            color: customColors.primaryBackground,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Align(
                            alignment: const AlignmentDirectional(0.00, 0.00),
                            child: Text(
                              "${eventModel.ticketPrice} s.p",
                              textAlign: TextAlign.center,
                              style: customTextStyle.bodyMedium.override(
                                fontFamily: 'Nunito',
                                color: customColors.primaryText,
                                useGoogleFonts: true,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                eventModel.title,
                                style: customTextStyle.headlineSmall.override(
                                  fontFamily: 'Nunito',
                                  fontSize: 16,
                                  useGoogleFonts: false,
                                ),
                              ),
                              // Row(
                              //   mainAxisSize: MainAxisSize.max,
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Icon(
                              //       Icons.play_arrow_outlined,
                              //       color: customColors.primaryText,
                              //       size: 25,
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                   DateFormatter.formatDate(eventModel.startDate),
                                  style: customTextStyle.bodyMedium.override(
                                    fontFamily: 'Nunito',
                                    color: customColors.primary,
                                    fontSize: 12,
                                    useGoogleFonts: false,
                                  ),
                                ),
                                Text(
                                  DateFormatter.formatTime(eventModel.startDate),
                                  style: customTextStyle.bodyMedium.override(
                                    fontFamily: 'Nunito',
                                    color: customColors.primary,
                                    fontSize: 12,
                                    useGoogleFonts: false,
                                  ),
                                ),
                              ].divide(const SizedBox(width: 5)),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(1.00, 0.00),
                              child: Padding(
                                padding:
                                    const EdgeInsetsDirectional.fromSTEB(0, 0, 3, 0),
                                child: Icon(
                                  Icons.arrow_forward_outlined,
                                  color: customColors
                                      .secondaryText,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
              ),
            ),
        );
  }

  Align imageGridView(BuildContext context,String imgUrl,int imgIndex,int eventIndex,int modelIndex) {
    return Align(
      alignment: const AlignmentDirectional(1.00, -1.00),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(0),
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child : getImageNetwork(url: "/storage/${imgUrl}", width: double.infinity, height: null)
            
             
          ),
          Container(
            width: 344,
            height: 140,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0x9A2E4052), Color(0x0089CFF0)],
                stops: [0, 1],
                begin: AlignmentDirectional(0, -1),
                end: AlignmentDirectional(0, 1),
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(1.00, -1.00),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 35,
                    height: 20,
                    decoration: BoxDecoration(
                      color: const Color(0x5BFFFFFF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "${imgIndex+1}/3",
                      textAlign: TextAlign.center,
                      style: customTextStyle.bodyMedium.override(
                        fontFamily: 'Nunito',
                        color: customColors.secondaryBackground,
                        fontSize: 12,
                        useGoogleFonts: false,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                  child: GetBuilder<MapController>(
                    builder: (mapController) {
                      return ToggleIcon(
                        onPressed: () async {
mapController.followOrUnFollowEvent(eventIndex, modelIndex);
                        },
                        value: mapController.events[modelIndex].isFollowedByAuthUser,
                        onIcon: Icon(
                          Icons.favorite_rounded,
                          color: customColors.rejected,
                          size: 25,
                        ),
                        offIcon: Icon(
                          Icons.favorite_border,
                          color: customColors.info,
                          size: 25,
                        ),
                      );
                    }
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
