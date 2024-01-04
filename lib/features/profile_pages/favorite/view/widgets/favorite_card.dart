import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/buttons/toggle_icon.dart';
import 'package:evento/core/shared/widgets/images/network_image.dart';
import 'package:evento/core/utils/helper/date_formatter.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/app_fonts_from_google.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/events/event_detailes/model/event_detailes_model.dart';
import 'package:evento/features/profile_pages/favorite/controller/favorite_controller.dart';
import 'package:evento/features/profile_pages/favorite/model/favorite_model.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteCard extends StatelessWidget {
  const FavoriteCard({super.key, required this.eventWrapper,required this.modelId});
final EventWrapper eventWrapper;
final int modelId;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
               Get.toNamed('/eventDetailes', arguments: eventWrapper.event.id);
                  
               },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: customColors.secondaryBackground,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            boxShadow: const [
              BoxShadow(
                  color: Color(0x33000000), blurRadius: 4, offset: Offset(0, 2)),
            ]),
        child: Column(
          children: [
            _buildImage(eventWrapper.event),
            _dateWithPlayVedio(eventWrapper.event,modelId),
            // Generated code for this Divider Widget...
            Divider(
              thickness: 1,
              indent: 12,
              endIndent: 12,
              color: customColors.secondary,
            ),
            _locationWithDistance(eventWrapper.event.venue,modelId)
          ],
        ),
      ),
    );
  }

  Widget _locationWithDistance(Venue venue,int index) {
   final FavoriteController favoriteController=Get.find();
           
    return 
        Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
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
              // context.pushNamed('Event-Location');
            },
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: customColors.primary,
                  size: 18,
                ),
                Text(
                  venue.governorate,
                  style: customTextStyle.bodyMedium.override(
                    fontFamily: breeSerif,
                    color: customColors.primaryText,
                    fontSize: 12,
                    useGoogleFonts: true,
                  ),
                ),
              ],
            ),
          ),
          Obx(
            ()=> Text(
              favoriteController.distances[index].value,
              style: customTextStyle.bodyMedium.override(
                fontFamily: breeSerif,
                color: customColors.primary,
                useGoogleFonts: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dateWithPlayVedio(FavoriteEventModel favoriteEventModel,int modelIndex) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    DateFormatter.formatDate(favoriteEventModel.startDate),
                    style: customTextStyle.bodyMedium.override(
                      fontFamily: breeSerif,
                      color: customColors.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      useGoogleFonts: true,
                    ),
                  ),
                ],
              ),
              Text(
                DateFormatter.formatTime(favoriteEventModel.startDate),
                style: customTextStyle.bodyMedium.override(
                  fontFamily: breeSerif,
                  fontSize: 12,
                  useGoogleFonts: true,
                ),
              ),
            ].divide(const SizedBox(width: 10)),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                    child: Icon(
                      Icons.play_arrow_outlined,
                      color: customColors.primaryText,
                      size: 20,
                    ),
                  ),
                  GetBuilder<FavoriteController>(
                    builder: (controller) {
                      return ToggleIcon(
                        onPressed: ()  {

                  controller.followOrUnFollowEvent(
                      favoriteEventModel.id, modelIndex);
                        },
                        value: favoriteEventModel.isFollowedByAuthUser,
                        onIcon: Icon(
                          Icons.favorite_sharp,
                          color: customColors.error,
                          size: 25,
                        ),
                        offIcon: Icon(
                          Icons.favorite_border,
                          color: customColors.secondaryText,
                          size: 20,
                        ),
                      );
                    }
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImage(FavoriteEventModel favoriteEventModel) {
    return Stack(alignment: const AlignmentDirectional(0, 1), children: [
      ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child:favoriteEventModel.images.isEmpty?
         Image.asset(
          'assets/images/alumni2.webp',
          width: double.infinity,
          height: scaleHeight(200),
          fit: BoxFit.cover,
          alignment: const Alignment(0.00, 1.00),
        ):getImageNetwork(url: "/storage/${favoriteEventModel.images[0]}", width: double.infinity,
          height: scaleHeight(200),alignmentGeometry:const Alignment(0.00, 1.00)),
      ),
      InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () async {
          // context.pushNamed('Event-Details');
        },
        child: Container(
          width: double.infinity,
          height: 200,
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                color: Color(0x33000000),
                offset: Offset(0, 2),
              )
            ],
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(0),
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              favoriteEventModel.title,
              style: customTextStyle.headlineSmall.override(
                fontFamily: breeSerif,
                color: customColors.info,
                fontWeight: FontWeight.w600,
                useGoogleFonts: true,
              ),
            ),
            Container(
              width: 80,
              height: 24,
              decoration: BoxDecoration(
                color: customColors.secondaryBackground,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Align(
                alignment: const AlignmentDirectional(0.00, 0.00),
                child: Text(
                  "${favoriteEventModel.ticketPrice} s.p",
                  textAlign: TextAlign.center,
                  style: customTextStyle.bodyMedium.override(
                    fontFamily: breeSerif,
                    color: customColors.primaryText,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    useGoogleFonts: true,
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    ]);
  }
}
