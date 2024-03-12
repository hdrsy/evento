import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/shared/widgets/bottom_sheets/show_bottom_sheet.dart';
import 'package:evento/core/shared/widgets/widget/rate_event_widget.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';

import '../../controller/service_according_detailes_controller.dart';
import '../../../serivce_according_category/model/service_according_category_model.dart';
import '../../../service_category/controller/service_category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class NameCheckBox extends StatelessWidget {
  NameCheckBox(
      {super.key,
      required this.serviceProvider,
      required this.serviceCategoryIndex});
  final ServiceProvider serviceProvider;
  final int serviceCategoryIndex;
  final ServiceAccordingDetailesController serviceAccordingDetailesController =
      Get.find();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${serviceProvider.name} ",
          style: customTextStyle.headlineSmall,
        ).tr(),
        Container(
          decoration: BoxDecoration(
            color: customColors.secondaryBackground,
          ),
          child: serviceAccordingDetailesController.isInCustomuzEvent
              ? Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Add To Event",
                      style: customTextStyle.bodyMedium.override(
                        fontFamily: 'Nunito',
                        color: customColors.primary,
                        fontSize: 12,
                        useGoogleFonts: true,
                      ),
                    ).tr(),
                    GetBuilder<ServiceCategoryController>(
                        builder: (serviceCategoryController) {
                      return Theme(
                        data: ThemeData(
                          checkboxTheme: CheckboxThemeData(
                            visualDensity: VisualDensity.compact,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          unselectedWidgetColor: customColors.secondaryText,
                        ),
                        child: Checkbox(
                          value: serviceCategoryController
                              .isSelectedServiceProvider(
                                  serviceProvider.id, serviceCategoryIndex),
                          onChanged: (newValue) async {
                            serviceCategoryController
                                .changeSelectedServiceProviderInEachCategory(
                                    serviceProvider.id,
                                    serviceCategoryIndex,
                                    serviceProvider.user.firstName +
                                        serviceProvider.user.lastName);
                          },
                          activeColor: customColors.success,
                          checkColor: customColors.info,
                        ),
                      );
                    }),
                  ],
                )
              : GestureDetector(
                  onTap: () async {
                    await showButtonSheet(
                        context: context,
                        widget: ReviewEventWidget(
                          ratingTarget: tr("Service Provider"),
                          id: serviceProvider.id,
                          idKey: "service_provider_id",
                          url: ServerConstApis.reviewServiceProvider,
                        ),
                        height: 450);
                  },
                  child: Text(
                    "Review Service Provider",
                    style: customTextStyle.bodyMedium.override(
                      fontFamily: 'Nunito',
                      color: customColors.primary,
                      fontSize: 12,
                      useGoogleFonts: true,
                    ),
                  ).tr(),
                ),
        ),
      ],
    );
  }
}
