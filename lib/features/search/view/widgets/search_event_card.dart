import 'package:evento/core/shared/widgets/images/network_image.dart';
import 'package:evento/core/utils/helper/date_formatter.dart';
import 'package:evento/features/events/home/model/event_model.dart';
import 'package:evento/features/map/view/widgets/event_card.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';

class SearchEventCard extends StatelessWidget {
  const SearchEventCard({super.key,
  required this.eventModel,
 
  });
final EventModel eventModel;
  @override
  Widget build(BuildContext context) {
    return    Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: 
                 getImageNetwork(
              url: "/storage/${eventModel.images[0]}", width: 45,
                height: 45,),
               
                
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                eventModel.title,
                style: customTextStyle.bodyMedium,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                    child: Text(
                      DateFormatter.formatDate(eventModel.startDate),
                      style: customTextStyle.bodyMedium,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
  

  }
}