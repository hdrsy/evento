import 'package:evento/core/shared/widgets/empty_data/empty_data_widget.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/features/organizer/organizer_followers/controller/organizer_followers_controller.dart';
import 'package:evento/features/organizer/organizer_followers/view/widget/organizer_followers_card.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrganizerFollowersScreen extends StatelessWidget {
  OrganizerFollowersScreen({super.key});
  final OrganizerFollowersController organizerFollowersController =
      Get.put(OrganizerFollowersController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.secondaryBackground,
      appBar: AppBar(
        backgroundColor: customColors.secondaryBackground,
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
      body: GetBuilder<OrganizerFollowersController>(builder: (ccontext) {
        return organizerFollowersController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(
                  color: customColors.primary,
                ),
              )
            : organizerFollowersController.isError.value
                ? EmptyData(
                    icon: Icons.error_outline_outlined,
                    message: "SomeThing Wrong!!",
                  )
                : organizerFollowersController.rganizerFollowers.isEmpty
                    ? EmptyData(
                        onTap: () {},
                        icon: Icons.person_add,
                        message: "Nothing to show",
                      )
                    : SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 5),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            ...List.generate(
                                organizerFollowersController
                                    .rganizerFollowers.length,
                                (index) => OrganizerFollowersCard(
                                      modelId: index,
                                      organizerFollowersModel:
                                          organizerFollowersController
                                              .rganizerFollowers[index],
                                    ))
                          ].divide(const SizedBox(
                            height: 10,
                          )),
                        ),
                      );
      }),
    );
  }
}
