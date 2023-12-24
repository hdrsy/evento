import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/customize_event/serivce_according_category/view/widgets/service_according_card.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceAccordingCategoryScreen extends StatelessWidget {
  const ServiceAccordingCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: customColors.secondaryBackground,
        appBar: AppBar(
          backgroundColor: customColors.secondaryBackground,
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
        body: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
              padding: padding(16, 20, 16, 20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Venue",
                      style: customTextStyle.bodyMedium.override(
                        fontFamily: 'Nunito',
                        color: customColors.primaryText,
                        fontSize: 25,
                        useGoogleFonts: true,
                      ),
                    ),
                    const ServiceAccordingCard(),
                    const ServiceAccordingCard(),
                    const ServiceAccordingCard(),
                  ])),
        ));
  }
}
