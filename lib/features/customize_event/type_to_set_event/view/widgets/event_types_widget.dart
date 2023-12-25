import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/images/network_image.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/customize_event/type_to_set_event/controller/type_to_set_event_controller.dart';
import 'package:evento/features/events/home/model/category_model.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventTypesWidget extends StatelessWidget {
  EventTypesWidget({super.key});
  final TypetoSetEventController typetoSetEventController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 8),
          child: Align(
            alignment: const AlignmentDirectional(-1.00, -1.00),
            child: Text(
              "Choose type to set your event",
              style: customTextStyle.bodyMedium.override(
                fontFamily: 'Nunito',
                color: customColors.secondaryText,
                fontSize: 14,
                useGoogleFonts: false,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
          child: SingleChildScrollView(
            child: Obx(
              ()=> Wrap(
                spacing: scaleWidth(50),
                runSpacing: scaleHeight(16),
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                children: [
                  ...List.generate(
                    typetoSetEventController.categoryList.length,
                    (index) => IconContainerWidget(
                      categoryModel: typetoSetEventController.categoryList[index],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class IconContainerWidget extends StatelessWidget {
  final CategoryModel categoryModel;

   IconContainerWidget({super.key, required this.categoryModel});
 final TypetoSetEventController typetoSetEventController = Get.find();
 
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        typetoSetEventController.choiceCategoryItem(categoryModel);
      },
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                color: typetoSetEventController.isSelected(categoryModel)? customColors.primary:customColors.primaryBackground,
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: getImageNetwork(
                            url: categoryModel.icon, width: null, height: null)
                        .image)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Text(
              categoryModel.title,
              style: customTextStyle.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
