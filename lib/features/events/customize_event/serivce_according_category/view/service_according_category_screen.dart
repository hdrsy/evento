import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/empty_data/empty_data_widget.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';

import '../controller/service_according_category_controller.dart';
import 'widgets/service_according_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceAccordingCategoryScreen extends StatelessWidget {
  ServiceAccordingCategoryScreen({super.key});
  final ServiceAccordingCategoryController serviceAccordingCategoryController =
      Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: customColors.secondaryBackground,
        appBar: AppBar(
          surfaceTintColor: customColors.secondaryBackground,
          backgroundColor: customColors.secondaryBackground,
          leading: GestureDetector(
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
          child: Obx(
            () => serviceAccordingCategoryController.isLoading.value
                ? Center(
                    child: CircularProgressIndicator(
                      color: customColors.primary,
                    ),
                  )
                : serviceAccordingCategoryController.isError.value
                    ? EmptyData(
                        icon: Icons.error_outline_outlined,
                        message: "SomeThing Wrong!!",
                      )
                    : serviceAccordingCategoryController
                            .serviceProviderList.isEmpty
                        ? EmptyData(
                            icon: Icons.miscellaneous_services,
                            message:
                                "No service providers available. Services will appear here as they become available.")
                        : SingleChildScrollView(
                            padding: padding(16, 20, 16, 20),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    serviceAccordingCategoryController
                                        .serviceCategoryType,
                                    style: customTextStyle.bodyMedium.override(
                                      fontFamily: 'Nunito',
                                      color: customColors.primaryText,
                                      fontSize: 25,
                                      useGoogleFonts: true,
                                    ),
                                  ),
                                  ...List.generate(
                                      serviceAccordingCategoryController
                                          .serviceProviderList.length,
                                      (index) => ServiceAccordingCard(
                                            serviceProvider:
                                                serviceAccordingCategoryController
                                                    .serviceProviderList[index],
                                            serviceCategoryIndex:
                                                serviceAccordingCategoryController
                                                    .serviceCategoryIndex,
                                          ))
                                ])),
          ),
        ));
  }
}
