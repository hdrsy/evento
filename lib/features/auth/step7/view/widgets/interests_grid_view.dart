import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/features/auth/step7/controller/step7_controller.dart';
import 'package:evento/features/auth/step7/model/interst_model.dart';
import 'package:evento/features/auth/steps/controller/steps_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class MyGridView extends StatelessWidget {
  StepsController stepsController = Get.find();
  Step7Controller step7Controller = Get.find();
  MyGridView({super.key});
  @override
  Widget build(BuildContext context) {
    List<InterestItem> items = step7Controller.allInterestItem;
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          childAspectRatio: 1,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return CategoryGridItem(
            item: items[index],
            isSelected: step7Controller.selectedInterests[index],
            onTap: () {
              step7Controller.selectedInterests[index].value =
                  !step7Controller.selectedInterests[index].value;
            },
          );
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class CategoryGridItem extends StatelessWidget {
  final InterestItem item;
  RxBool isSelected;
  Function() onTap;
  CategoryGridItem(
      {Key? key,
      required this.item,
      required this.isSelected,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InkWell(
        onTap: onTap,
        child: Container(
          width: scaleHeight(100),
          height: scaleHeight(100),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            shape: BoxShape.rectangle,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 84,
                height: 74,
                decoration: BoxDecoration(
                  color: isSelected.value
                      ? customColors.primary
                      : customColors.primaryBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Image.network(
                      ServerConstApis.baseAPI + item.icon,
                      width: 100,
                      height: 100,
                      fit: BoxFit.contain,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child; // Image has finished loading
                        }
                        return Shimmer.fromColors(
                          baseColor:
                              Colors.grey[300]!, // Replace with your base color
                          highlightColor: Colors
                              .grey[100]!, // Replace with your highlight color
                          child: Container(
                            width: 100,
                            height: 100,
                            color: Colors.white,
                          ),
                        );
                      },
                      errorBuilder: (BuildContext context, Object error,
                          StackTrace? stackTrace) {
                        return const Center(
                          child:    Icon(
                            Icons.error, // or any other icon or widget
                            // size: 1,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Text(
                item.title,
                style: customTextStyle.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
