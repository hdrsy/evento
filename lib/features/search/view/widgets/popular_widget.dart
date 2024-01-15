import '../../controller/search_controller.dart';
import 'search_event_card.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
class PopularWidget extends StatelessWidget {
   PopularWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return 
        GetBuilder<SearchPageController>(
          builder: (controller) {
            return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
            Align(
              alignment: const AlignmentDirectional(-1.00, 0.00),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                child: Text(
                  tr("Popular on Evanto"),
                  textAlign: TextAlign.start,
                  style: customTextStyle.labelLarge,
                ),
              ),
            ),
            ...List.generate(controller.itemList.length, (index) =>  SearchEventCard(
             eventModel: controller.itemList[index],
            )),

                
              
            
      ],
    );
          }
        );
  }
}
