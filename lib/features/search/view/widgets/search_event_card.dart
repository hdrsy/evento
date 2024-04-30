import 'package:evento/features/search/controller/search_controller.dart';
import 'package:evento/features/search/model/search_model.dart';

import '../../../../core/shared/widgets/images/network_image.dart';
import '../../../../core/utils/helper/date_formatter.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchEventCard extends StatelessWidget {
  const SearchEventCard({
    super.key,
    required this.eventModel,
  });
  final SearchModel eventModel;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final SearchPageController searchPageController = Get.find();
        searchPageController.addNewEventToCache(eventModel);

        Get.toNamed('/eventDetailes', parameters: {
          'id': eventModel.id.toString(),
        });
      },
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: getImageNetwork(
                url: "/storage/${eventModel.images[0]}",
                width: 45,
                height: 45,
              ),
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
      ),
    );
  }
}
