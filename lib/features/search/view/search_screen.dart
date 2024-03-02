import 'package:evento/core/shared/widgets/empty_data/empty_data_widget.dart';
import 'package:evento/core/shared/widgets/guest/guest_popup.dart';

import '../../../core/responsive/responsive.dart';
import '../../../core/shared/widgets/text_fields/search_filed_with_filtering.dart';
import '../../../core/utils/animation/animation_def.dart';
import '../../../core/utils/animation/animation_util.dart';
import '../../../core/utils/theme/text_theme.dart';
import '../controller/search_controller.dart';
import 'widgets/popular_widget.dart';
import 'widgets/search_event_card.dart';
import '../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  final SearchPageController searchPageController =
      Get.put(SearchPageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: MediaQuery.of(context).viewInsets.bottom != 0
          ? null
          : floatingActionButton(),
      backgroundColor: customColors.secondaryBackground,
      appBar: AppBar(
        backgroundColor: customColors.secondaryBackground,
        title: Text(tr("Search"),
            style: customTextStyle.bodyMedium
                .copyWith(color: customColors.primary, fontSize: 20)),
        centerTitle: true,
      ),
      body: Obx(
        () => searchPageController.isError.value
            ? EmptyData(
                icon: Icons.error_outline_outlined,
                message: "SomeThing Wrong!!",
              )
            : SingleChildScrollView(
                padding: padding(16, 24, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        searchPageController.isSearchActive.value = true;
                      },
                      child: SearchFieldWithFiltering(
                          controller: searchPageController.searchField,
                          onChanged: (value) {
                            // searchPageController.onPressSearch(value!);
                          },
                          onApplyFilters: (filters) {
                            searchPageController.onApplyFilters(filters);
                          }),
                    ),
                    // RecentlyWidget(),
                    searchPageController.isSearchActive.value
                        ? SearchResult()
                        : PopularWidget()
                  ],
                ),
              ),
      ),
    );
  }
}

class SearchResult extends StatelessWidget {
  SearchResult({super.key});
  final SearchPageController searchPageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>

          //  searchPageController.searchResults.isEmpty
          //     ? const EmptyData(
          //         icon: Icons.search_sharp,
          //         message:
          //             "No luck this time, but the perfect event might be just a few keywords away!",
          //       )
          Column(
        children: [
          ...List.generate(
              searchPageController.searchResults.length,
              (index) => SearchEventCard(
                    eventModel: searchPageController.searchResults[index],
                  )),
        ],
      ),
    );
  }
}

Widget floatingActionButton() {
  return FloatingActionButton.extended(
    onPressed: () async {
      if (isGuset) {
        Get.dialog(const GuestPopupWidget());
      } else {
        // context.pushNamed('Map');
        Get.toNamed('/MapScreen');
      }
    },
    // shape: ShapeBorder(),
    backgroundColor: customColors.primary,
    icon: Icon(
      Icons.location_on,
      color: customColors.info,
      size: 20,
    ),
    elevation: 8,
    // isExtended: false,
    label: Text(
      tr("VIEW MAP"),
      style: customTextStyle.titleSmall.override(
        color: customColors.info,
        fontFamily: 'Nunito',
        fontSize: 14,
        useGoogleFonts: true,
      ),
    ),
  ).animateOnPageLoad(
      animationsMap['floatingActionButtonOnPageLoadAnimation']!);
}
