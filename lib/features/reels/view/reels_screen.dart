import 'package:evento/core/shared/widgets/empty_data/empty_data_widget.dart';
import 'package:evento/features/reels/view/widgets/reel_component/reels_shimmer.dart';

import '../controller/reels_controller.dart';
import 'widgets/reel_widget.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReelsScreen extends StatelessWidget {
  ReelsScreen({super.key});
  final ReelsController reelsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: RefreshIndicator(
            onRefresh: () {
              return reelsController.refreshScreen();
            },
            child: SafeArea(
              child: Obx(
                () => reelsController.isLoading.value
                    ? const ReelsShimmer()
                    : reelsController.isError.value
                        ? EmptyData(
                            icon: Icons.error_outline_outlined,
                            message: "SomeThing Wrong!!",
                          )
                        : reelsController.itemList.isEmpty
                            ? EmptyData(
                                icon: Icons.miscellaneous_services,
                                message:
                                    "Your reels space is currently empty, but stay tuned for exciting content coming your way soon!",
                              )
                            : PageView.builder(
                                controller: reelsController.pageController,
                                scrollDirection: Axis.vertical,
                                onPageChanged: (index) {
                                  if (index >
                                      reelsController.currentUserIndex) {
                                    // Swipe Up - Load the next video
                                    reelsController.nextUser();
                                  } else {
                                    // Swipe Down - Go back to the previous video
                                    reelsController.previousUser();
                                  }
                                },
                                itemCount: reelsController.itemList.length,
                                itemBuilder: (context, index) {
                                  return ReelsWidget(
                                    model: reelsController.itemList[index],
                                    modelIndex: index,
                                  );
                                }),
              ),
            )));
  }
}
