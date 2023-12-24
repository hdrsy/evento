import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/shared/widgets/images/network_image.dart';
import 'package:evento/core/utils/animation/shimmer_animation.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/events/home/controller/home_controller.dart';
import 'package:evento/features/events/home/model/category_model.dart';
import 'package:evento/features/events/home/model/event_model.dart';
import 'package:evento/features/events/home/view/widgets/home_loading_widget.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CategoryList extends StatelessWidget {
  CategoryList({super.key});
  final CategoryListController categoryListController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenSize == ScreenSize.small
          ? 100
          : (screenSize == ScreenSize.medium ? 100 : 120),
      child: Obx(
        () => categoryListController.isLoading.value
            ? ShimmerLoadingWidget(
                loadingShimmerWidget: categoryloading(),
              )
            : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoryListController.categoryList.length,
                itemBuilder: (context, index) {
                  return CategoryWidget(
                    categoryModel: categoryListController.categoryList[index],
                  );
                }),
      ),
    );
  }
}

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key, required this.categoryModel});
  final CategoryModel categoryModel;
  @override
  Widget build(BuildContext context) {
    double imageSize = screenSize == ScreenSize.small
        ? 60
        : (screenSize == ScreenSize.medium ? 70 : 75);
    double fontSize = screenSize == ScreenSize.small
        ? 10
        : (screenSize == ScreenSize.medium ? 12 : 14);

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(5, 5, 5, 0),
          child: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              String targetRout = '';
              String targetKeyMap = '';
              switch (categoryModel.title) {
                case "Tonight":
                  targetRout = ServerConstApis.getToNightList;
                  targetKeyMap = 'toNightEvent';
                  break;
                case "This Week":
                  targetRout = ServerConstApis.getThisWeekList;
                  targetKeyMap = 'thisWeekEvent';
                  break;
                default:
                  targetRout =
                      "${ServerConstApis.getAccordingCategoryList}/${categoryModel.id}";
                  targetKeyMap = 'Events';
              }
              Get.toNamed('/seeAll',
                  arguments: [1, <EventModel>[].obs, targetRout, targetKeyMap]);
            },
            child: Container(
              width: imageSize,
              height: imageSize,
              decoration: BoxDecoration(
                color: customColors.primaryBackground,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: categoryModel.title == "Tonight" ||
                          categoryModel.title == "This Week"
                      ? Image.asset(categoryModel.icon).image
                      : getImageNetwork(
                              url: categoryModel.icon,
                              width: imageSize,
                              height: imageSize)
                          .image,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              alignment: const AlignmentDirectional(0.00, 0.00),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
          child: Text(
            categoryModel.title,
            textAlign: TextAlign.center,
            style: customTextStyle.bodyMedium.override(
              fontFamily: 'Bree Serif',
              color: customColors.secondaryText,
              fontSize: fontSize,
              fontWeight: FontWeight.normal,
              useGoogleFonts: true,
            ),
          ),
        ),
      ],
    );
  }
}
