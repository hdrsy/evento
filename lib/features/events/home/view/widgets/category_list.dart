import '../../../../../core/server/server_config.dart';
import '../../../../../core/shared/widgets/images/network_image.dart';
import '../../../../../core/utils/animation/shimmer_animation.dart';
import '../../../../../core/utils/theme/text_theme.dart';
import '../../controller/home_controller.dart';
import '../../model/category_model.dart';
import '../../model/event_model.dart';
import 'home_loading_widget.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class CategoryList extends StatelessWidget {
  CategoryList({super.key});
  final CategoryListController categoryListController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
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
    double fontSize = 12;
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
          child: GestureDetector(
            onTap: () async {
              String targetRout = '';
              String targetKeyMap = '';
              switch (categoryModel.title) {
                case "Tonight":
                  targetRout = isGuset
                      ? ServerConstApis.getToNightListforGuest
                      : ServerConstApis.getToNightList;
                  targetKeyMap = 'toNightEvent';
                  break;
                case "This Week":
                  targetRout = isGuset
                      ? ServerConstApis.getThisWeekListforGuest
                      : ServerConstApis.getThisWeekList;
                  targetKeyMap = 'thisWeekEvent';
                  break;
                default:
                  targetRout =
                      "${ServerConstApis.getAccordingCategoryList}/${categoryModel.id}";
                  targetKeyMap = 'Events';
              }
              Get.toNamed('/seeAll', arguments: [
                1,
                <EventModel>[].obs,
                targetRout,
                targetKeyMap,
                categoryModel.title
              ]);
            },
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: customColors.primaryBackground,
                image: DecorationImage(
                  image: categoryModel.title == "Tonight" ||
                          categoryModel.title == "This Week"
                      ? Image.asset(
                          categoryModel.icon,
                          fit: BoxFit.cover,
                          width: 70,
                          height: 70,
                        ).image
                      : getImageNetwork(
                              url: categoryModel.icon, width: 70, height: 70)
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
          ).tr(),
        ),
      ],
    );
  }
}
