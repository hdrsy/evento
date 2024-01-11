import 'package:evento/features/search/controller/search_controller.dart';
import 'package:evento/features/search/view/widgets/search_event_card.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                  "Popular on Evanto",
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
