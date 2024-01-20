import 'package:evento/core/shared/widgets/guest/guest_popup.dart';

import '../../../../../core/responsive/responsive.dart';
import '../../../../../core/shared/widgets/buttons/toggle_icon.dart';
import '../../../../../core/shared/widgets/images/network_image.dart';
import '../../../../../core/utils/helper/date_formatter.dart';
import '../../../../../core/utils/helper/flutter_flow_util.dart';
import '../../../../../core/utils/theme/app_fonts_from_google.dart';
import '../../../../../core/utils/theme/text_theme.dart';
import '../../../home/model/event_model.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
class SeeAllCard extends StatelessWidget {
  const SeeAllCard(
      {super.key, required this.eventModel, required this.modelIndex});
  final EventModel eventModel;
  final int modelIndex;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){
  Get.toNamed('/eventDetailes',arguments: [eventModel.id,false,0]);
                    
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: customColors.secondaryBackground,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            boxShadow: const [
              BoxShadow(
                  color: Color(0x33000000), blurRadius: 4, offset: Offset(0, 2)
                  ),
            ]),
        child: Column(
          children: [
            _buildImage(eventModel),
            _dateWithPlayVedio(eventModel),
            
            Divider(
              thickness: 1,
              indent: 12,
              endIndent: 12,
              color: customColors.secondary,
            ),
            _locationWithDistance(eventModel)
          ],
        ),
      ),
    );
  }

  Widget _locationWithDistance(EventModel eventModel) {
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
                  "Dama",
                  style: customTextStyle.bodyMedium.override(
                    fontFamily: breeSerif,
                    color: customColors.primaryText,
                    fontSize: 12,
                    useGoogleFonts: true,
                  ),
                ).tr(),
              ],
            ),
          ),
          InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              // context.pushNamed('Going');
            },
            child: Text(
              "3.7 Km",
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

  Widget _dateWithPlayVedio(EventModel eventModel) {
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
                    DateFormatter.formatDate(eventModel.startDate),
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
                DateFormatter.formatTime(eventModel.startDate),
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
                  ToggleIcon(
                    onPressed: () async {
                       if(isGuset){
                    Get.dialog( const GuestPopupWidget());
                  }else{}
                    },
                    value: false,
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
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImage(EventModel eventModel) {
    return Stack(alignment: const AlignmentDirectional(0, 1), children: [
      ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: getImageNetwork(url: "/storage/${eventModel.images[0]}", width: double.infinity, height: scaleHeight(210))
      ),
      Container(
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
      Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              eventModel.title,
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
                  "${eventModel.ticketPrice} s.p",
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
