import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/text_fields/search_filed.dart';
import 'package:evento/core/shared/widgets/text_fields/search_filed_with_filtering.dart';
import 'package:evento/core/utils/animation/animation_def.dart';
import 'package:evento/core/utils/animation/animation_util.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/search/controller/search_controller.dart';
import 'package:evento/features/search/view/widgets/popular_widget.dart';
import 'package:evento/features/search/view/widgets/recently_widget.dart';
import 'package:evento/features/search/view/widgets/search_event_card.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({super.key});
final SearchPageController searchPageController=Get.put(SearchPageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton(),
      backgroundColor: customColors.secondaryBackground,
      appBar: AppBar(
        backgroundColor: customColors.secondaryBackground,
        title: Text("Search",
            style: customTextStyle.bodyMedium
                .copyWith(color: customColors.primary, fontSize: 20)),
        centerTitle: true,
      ),
      body: Obx(
()=>SingleChildScrollView(
          padding: padding(16, 24, 16, 24),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              searchTextField(
                controller: searchPageController.searchField,
                onChanged: (value){
      searchPageController.onPressSearch(value!);
                }
              ),
              // RecentlyWidget(),
            searchPageController.isSearchActive.value?SearchResult() : PopularWidget()
            ],
          ),
        ),
      ),
    );
  }
}
class SearchResult extends StatelessWidget {
   SearchResult({super.key});
final SearchPageController searchPageController=Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
()=> Column(children: [
         ...List.generate(searchPageController.searchResultSearch.length, (index) =>  SearchEventCard(
               eventModel: searchPageController.searchResultSearch[index],
              )),
      ],),
    );
  }
}
Widget floatingActionButton() {
  return FloatingActionButton.extended(
    onPressed: () async {
      // context.pushNamed('Map');
      Get.toNamed('/MapScreen');
    },
    backgroundColor: customColors.primary,
    icon: Icon(
      Icons.location_on,
      color: customColors.info,
      size: 20,
    ),
    elevation: 8,
    label: Text(
      "VIEW MAP",
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
