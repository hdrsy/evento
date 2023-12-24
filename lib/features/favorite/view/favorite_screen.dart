import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/text_fields/search_filed_with_filtering.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/features/favorite/view/widgets/favorite_card.dart';
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
      body: SingleChildScrollView(
        padding: padding(10,16,0,16),
        child: Column(children: [
          const SearchFieldWithFiltering(),
          const FavoriteCard(),
          const FavoriteCard(),
          const FavoriteCard(),
          const FavoriteCard(),
        ].divide(const SizedBox(height: 15,))
        ,),
      ),
    );
  }
}
