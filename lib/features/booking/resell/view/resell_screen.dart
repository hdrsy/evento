import 'package:easy_localization/easy_localization.dart';
import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/bottom_sheets/show_bottom_sheet.dart';
import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/shared/widgets/empty_data/empty_data_widget.dart';
import 'package:evento/core/shared/widgets/images/network_image.dart';
import 'package:evento/core/shared/widgets/text_fields/search_filed.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/booking/resell/controller/resell_controller.dart';
import 'package:evento/features/booking/resell/model/users_model.dart';
import 'package:evento/features/booking/resell/view/widget/confirm_resell_widget.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReSellTicketPage extends StatelessWidget {
  ReSellTicketPage({super.key});
  final ReSellController reSellController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: customColors.secondaryBackground,
        appBar: AppBar(
          backgroundColor: customColors.secondaryBackground,
          title: Text(tr("ReSell"),
              style: customTextStyle.bodyMedium
                  .copyWith(color: customColors.primary, fontSize: 20)),
          centerTitle: true,
          leading: InkWell(
            onTap: () => Get.back(),
            child: Icon(
              Icons.arrow_back_rounded,
              color: customColors.primaryText,
              size: 30,
            ),
          ),
        ),
        body: Obx(
          () => (reSellController.isLoading.value &&
                  reSellController.itemList.isEmpty)
              ?
              // Show loading indicator while initial data is loading
              const Center(child: CircularProgressIndicator())
              : reSellController.isError.value
                  ? EmptyData(
                      icon: Icons.error_outline_outlined,
                      message: "SomeThing Wrong!!",
                    )
                  : SingleChildScrollView(
                      controller: reSellController.scrollController,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Column(
                        children: [
                          searchTextField(
                            controller: reSellController.friendsSearch,
                            onChanged: (value) {
                              // Search logic is handled by the controller
                            },
                          ),
                          const SizedBox(height: 15),
                          ...List.generate(
                            reSellController.itemList.length +
                                (reSellController.hasMoreData.value ? 1 : 0),
                            (index) {
                              if (index >= reSellController.itemList.length) {
                                // If hasMoreData is false, don't show the ShimmerFriendCard
                                return reSellController.hasMoreData.value
                                    ? Container()
                                    : Container();
                              } else {
                                // Return the actual friend card for this index
                                return UsersCard(
                                  addFriendsModel:
                                      reSellController.itemList[index],
                                  modelId: index,
                                );
                              }
                            },
                          ).toList(),
                          if (reSellController.isLoadingMoreData.value)
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Center(child: CircularProgressIndicator()),
                            ),
                        ],
                      ),
                    ),
        ));
  }
}

class UsersCard extends StatelessWidget {
  const UsersCard(
      {super.key, required this.addFriendsModel, required this.modelId});
  final UsersModel addFriendsModel;
  final int modelId;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReSellController>(builder: (ccontext) {
      return SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 1),
          child: Container(
            width: screenHeight * 0.15,
            decoration: BoxDecoration(
              color: customColors.secondaryBackground,
            ),
            child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: addFriendsModel.image.length > 6
                            ? getImageNetwork(
                                url: "/storage/${addFriendsModel.image}",
                                width: 90,
                                height: 90)
                            : Image.asset(
                                'assets/images/${addFriendsModel.image}.png',
                                width: 90,
                                height: 90,
                              )),
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${addFriendsModel.firstName} ${addFriendsModel.lastName}",
                              style: customTextStyle.bodyLarge,
                            ),
                            ButtonWidget(
                              onPressed: () {
                                Get.back();
                                showButtonSheet(
                                        context: context,
                                        widget: ConfirmReSellWidget(
                                            modelId: modelId,
                                            userId: addFriendsModel.id),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.3)
                                    .then((value) =>
                                        Get.delete<ReSellController>());
                              },
                              text: tr("ReSell"),
                              options: ButtonOptions(
                                width: 120,
                                height: 21,
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    10, 0, 10, 0),
                                iconPadding:
                                    const EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 0),
                                color: customColors.primary,
                                textStyle: customTextStyle.titleSmall.override(
                                  fontFamily: 'Nunito',
                                  color: customColors.info,
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  useGoogleFonts: true,
                                ),
                                borderSide: BorderSide(
                                  color: customColors.primary,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            )
                          ].divide(const SizedBox(height: 10)),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      );
    });
  }
}
