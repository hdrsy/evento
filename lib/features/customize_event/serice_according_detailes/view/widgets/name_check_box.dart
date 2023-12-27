import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/customize_event/serivce_according_category/model/service_according_category_model.dart';
import 'package:evento/features/customize_event/service_category/controller/service_category_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NameCheckBox extends StatelessWidget {
  const NameCheckBox(
      {super.key,
      required this.serviceProvider,
      required this.serviceCategoryIndex});
  final ServiceProvider serviceProvider;
  final int serviceCategoryIndex;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Abernathy Reynolds",
          style: customTextStyle.headlineSmall,
        ),
        InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            // context.pushNamed('Services');
          },
          child: Container(
            decoration: BoxDecoration(
              color: customColors.secondaryBackground,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  " Add To Event",
                  style: customTextStyle.bodyMedium.override(
                    fontFamily: 'Nunito',
                    color: customColors.primary,
                    fontSize: 12,
                    useGoogleFonts: true,
                  ),
                ),
                GetBuilder<ServiceCategoryController>(
                    builder: (serviceCategoryController) {
                  return Theme(
                    data: ThemeData(
                      checkboxTheme: CheckboxThemeData(
                        visualDensity: VisualDensity.compact,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      unselectedWidgetColor: customColors.secondaryText,
                    ),
                    child: Checkbox(
                      value:
                          serviceCategoryController.isSelectedServiceProvider(
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
            ),
          ),
        ),
      ],
    );
  }
}
