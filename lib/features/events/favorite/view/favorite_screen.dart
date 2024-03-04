import 'package:evento/core/shared/widgets/empty_data/empty_data_widget.dart';

import '../../../../core/responsive/responsive.dart';
import '../../../../core/shared/widgets/text_fields/search_filed_with_filtering.dart';
import '../../../../core/utils/helper/flutter_flow_util.dart';
import '../controller/favorite_controller.dart';
import 'widgets/favorite_card.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({super.key});
  final FavoriteController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.secondaryBackground,
      appBar: AppBar(
        backgroundColor: customColors.secondaryBackground,
        title: Text(tr("Favorite"),
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
      body: Obx(() => controller.isLoading.value
          ? Center(
              child: CircularProgressIndicator(
                color: customColors.primary,
              ),
            )
          : controller.isError.value
              ? EmptyData(
                  icon: Icons.error_outline_outlined,
                  message: "SomeThing Wrong!!",
                )
              : controller.favoriteEvents.isEmpty
                  ? const EmptyData(
                      icon: Icons.add_circle,
                      message:
                          "No favorites saved. Add your most loved events here.",
                    )
                  : SingleChildScrollView(
                      padding: padding(10, 16, 0, 16),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.isSearchActive.value = true;
                            },
                            child: SearchFieldWithFiltering(
                                controller: controller.searchField,
                                onChanged: (value) {
                                  controller.onPressSearch(value);
                                },
                                onApplyFilters: (fiter) {
                                  controller.onApplyFilters(fiter);
                                }),
                          ),
                          ...List.generate(
                              controller.isSearchActive.value
                                  ? controller.searchResultSearch.length
                                  : controller.favoriteEvents.length,
                              (index) => FavoriteCard(
                                  eventWrapper: controller.isSearchActive.value
                                      ? controller.searchResultSearch[index]
                                      : controller.favoriteEvents[index],
                                  modelId: index)),
                        ].divide(const SizedBox(
                          height: 15,
                        )),
                      ),
                    )),
    );
  }
}
