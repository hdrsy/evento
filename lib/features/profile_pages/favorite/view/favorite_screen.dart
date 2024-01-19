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
  const FavoriteScreen({super.key});

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
      body: GetBuilder<FavoriteController>(
        builder: (controller) {
          return SingleChildScrollView(
            padding: padding(10,16,0,16),
            child: Column(children: [
               SearchFieldWithFiltering(),
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
