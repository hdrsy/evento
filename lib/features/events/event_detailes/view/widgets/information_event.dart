import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/features/events/event_detailes/model/event_detailes_model.dart';
import 'package:evento/features/events/event_detailes/view/widgets/book_now_button.dart';
import 'package:evento/features/events/event_detailes/view/widgets/inforamtion_event_widgets/about_event_section.dart';
import 'package:evento/features/events/event_detailes/view/widgets/inforamtion_event_widgets/amenities_section.dart';
import 'package:evento/features/events/event_detailes/view/widgets/inforamtion_event_widgets/event_detailes.dart';
import 'package:evento/features/events/event_detailes/view/widgets/inforamtion_event_widgets/event_time_line_button.dart';
import 'package:evento/features/events/event_detailes/view/widgets/inforamtion_event_widgets/gallery_section.dart';
import 'package:evento/features/events/event_detailes/view/widgets/inforamtion_event_widgets/header.dart';
import 'package:evento/features/events/event_detailes/view/widgets/inforamtion_event_widgets/links_section.dart';
import 'package:evento/features/events/event_detailes/view/widgets/inforamtion_event_widgets/location_section.dart';
import 'package:evento/features/events/event_detailes/view/widgets/inforamtion_event_widgets/more_events.dart';
import 'package:evento/features/events/event_detailes/view/widgets/inforamtion_event_widgets/orgnization_section.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';

class InformationEvent extends StatelessWidget {
  const InformationEvent({super.key,required this.eventDetailsModel});
final EventDetailsModel eventDetailsModel;
  @override
  Widget build(BuildContext context) {
    return 
       Stack(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        alignment: Alignment.center,
         children: [
           Container(
            height: screenHeight*0.7,
            width: screenWidth*0.9 ,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding:
             EdgeInsets.symmetric(vertical: screenHeight*0.05,horizontal: screenWidth*0.05),
            // padding(16,26,16,26),
            decoration: BoxDecoration(
              color: customColors.secondaryBackground,
              borderRadius: const BorderRadius.all(Radius.circular(16))
            ),
             child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  buildHeader(context,eventDetailsModel.title),
                  // _buildGoingSection(context),
                  Divider(thickness: 1, color: customColors.secondary),
                  buildEventDetails(context),
                  Divider(thickness: 1, color: customColors.secondary),
                  buildOrganizerSection(context,eventDetailsModel.organizer),
                  buildAboutEventSection(context),
                  buildGallerySection(context),
                  buildLocationSection(context),
                  buildAmenitiesSection(context),
                  buildEventTimelineButton(context,eventDetailsModel),
                  LinksSection(),
                  buildMoreEventsSection(context),
                ].divide(const SizedBox(height: 20)).addToStart(const SizedBox(height: 10)).addToEnd(const SizedBox(height: 40)),
              ),
                 
               ),
           ),
           
         
         Positioned(bottom: 16 ,child: const BookNowButton())
         ],
       );
  }

 
}
