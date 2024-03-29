import 'package:evento/core/shared/widgets/empty_data/empty_data_widget.dart';

import '../../../../core/responsive/responsive.dart';
import '../../../../core/shared/widgets/text_fields/search_filed.dart';
import '../../../../core/utils/helper/flutter_flow_util.dart';
import '../controller/my_request_controller.dart';
import 'widget/request_card.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class MyrequestScreen extends StatelessWidget {
  MyrequestScreen({super.key});
  final MyRequestController myRequestController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.secondaryBackground,
      appBar: AppBar(
        surfaceTintColor: customColors.secondaryBackground,
        backgroundColor: customColors.secondaryBackground,
        title: Text(tr("My Requests"),
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
      body: GetBuilder<MyRequestController>(builder: (context) {
        return myRequestController.isLoading.value
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
                : myRequestController.myRequestsList.isEmpty
                    ? EmptyData(
                        onTap: () {
                          Get.toNamed('/TypeToSetEventScreen');
                        },
                        icon: Icons.add_circle,
                        message:
                            "You haven't made any requests. Start by searching for events you're interested in!",
                      )
                    : SingleChildScrollView(
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
                                            : myRequestController
                                                .myRequestsList.length)
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
                                  ? myRequestController
                                      .searchResultSearch.length
                                  : myRequestController.myRequestsList.length,
                              (index) => RequestCard(
                                  myRequestModel:
                                      myRequestController.isSearchActive.value
                                          ? myRequestController
                                              .searchResultSearch[index]
                                          : myRequestController
                                              .myRequestsList[index]),
                            )
                          ].divide(const SizedBox(
                            height: 10,
                          )),
                        ),
                      );
      }),
    );
  }
}
