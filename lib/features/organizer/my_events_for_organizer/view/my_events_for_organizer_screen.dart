import 'package:evento/core/shared/widgets/empty_data/empty_data_widget.dart';

import '../../../../core/responsive/responsive.dart';
import '../../../../core/shared/widgets/text_fields/search_filed.dart';
import '../../../../core/utils/helper/flutter_flow_util.dart';
import '../controller/my_events_for_organizer_controller.dart';
import 'widget/my_events_for_organizer_card.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class MyEventsForOrganizerScreen extends StatelessWidget {
  MyEventsForOrganizerScreen({super.key});
  final MyEventsForOrganizerController myRequestController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.secondaryBackground,
      appBar: AppBar(
        backgroundColor: customColors.secondaryBackground,
        title: Text(tr("My Events"),
            style: customTextStyle.bodyMedium
                .copyWith(color: customColors.primary, fontSize: 20)),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_rounded,
            color: customColors.primaryText,
            size: 30,
          ),
        ),
      ),
      body: Obx(() => myRequestController.isLoading.value
          ? Center(
              child: CircularProgressIndicator(
                color: customColors.primary,
              ),
            )
          : myRequestController.isError.value
              ? EmptyData(
                  icon: Icons.error_outline_outlined,
                  message: "SomeThing Wrong!!",
                )
              : myRequestController.itemList.isEmpty
                  ? const EmptyData(
                      icon: Icons.email_rounded,
                      message:
                          "You haven't made any requests. Start by searching for events you're interested in!",
                    )
                  : SingleChildScrollView(
                      controller: myRequestController.scrollController,
                      padding: padding(16, 20, 10, 20),
                      child: Column(
                        children: [
                          searchTextField(
                              controller: myRequestController.searchField,
                              onChanged: (value) {
                                myRequestController.onPressSearch(value!);
                              }),
                          // Generated code for this Row Widget...
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16, 12, 0, 0),
                                child: Text(
                                  (myRequestController.isSearchActive.value
                                          ? myRequestController
                                              .searchResultSearch.length
                                          : myRequestController.itemList.length)
                                      .toString(),
                                  style: customTextStyle.labelMedium,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    4, 12, 16, 0),
                                child: Text(
                                  tr("Event"),
                                  style: customTextStyle.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                          ...List.generate(
                            myRequestController.isSearchActive.value
                                ? myRequestController.searchResultSearch.length
                                : myRequestController.itemList.length,
                            (index) => MyEventsForOrganizerCard(
                                myRequestModel:
                                    myRequestController.isSearchActive.value
                                        ? myRequestController
                                            .searchResultSearch[index]
                                        : myRequestController.itemList[index]),
                          )
                        ].divide(const SizedBox(
                          height: 10,
                        )),
                      ),
                    )),
    );
  }
}
