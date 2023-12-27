
import 'package:evento/features/reels/controller/reels_controller.dart';
import 'package:evento/features/reels/view/widgets/reel_widget.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReelsScreen extends StatelessWidget {
  ReelsScreen({super.key});
  final ReelsController reelsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          body: GetBuilder<ReelsController>(builder: (ccontext) {
            return PageView.builder(
                scrollDirection: Axis.vertical,
                onPageChanged: (index) {
                  if (index > reelsController.currentUserIndex) {
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
                  );
                });
          })),
    );
  }
}
