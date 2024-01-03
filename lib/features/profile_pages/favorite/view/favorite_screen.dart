import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/text_fields/search_filed_with_filtering.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/features/profile_pages/favorite/controller/favorite_controller.dart';
import 'package:evento/features/profile_pages/favorite/view/widgets/favorite_card.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.secondaryBackground,
      appBar: AppBar(
        backgroundColor: customColors.secondaryBackground,
        title: Text("Favorite",
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
      body: GetBuilder<FavoriteController>(
        builder: (controller) {
          return SingleChildScrollView(
            padding: padding(10,16,0,16),
            child: Column(children: [
              const SearchFieldWithFiltering(),
              ...List.generate(controller.favoriteEvents.length, (index) =>  FavoriteCard(eventWrapper: controller.favoriteEvents[index],modelId:  index))
              ,
              
            ].divide(const SizedBox(height: 15,))
            ,),
          );
        }
      ),
    );
  }
}
