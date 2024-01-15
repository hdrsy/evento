import '../../../../../core/responsive/responsive.dart';
import '../../../../../core/shared/widgets/images/network_image.dart';
import '../../../../../core/utils/theme/text_theme.dart';
import '../../controller/type_to_set_event_controller.dart';
import '../../../../events/home/model/category_model.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
class EventTypesWidget extends StatelessWidget {
  EventTypesWidget({super.key});
  final TypetoSetEventController typetoSetEventController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
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
              ).tr(),
            ),
          ),
          SizedBox(
            height: screenHeight*0.6,
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
              child:GridView.count(
                crossAxisCount: 3, // Number of items per row
                crossAxisSpacing: scaleWidth(50), // Horizontal spacing between items
                mainAxisSpacing: scaleHeight(16), // Vertical spacing between items
                childAspectRatio: 1, // Aspect ratio of each child
                children: List.generate(
                typetoSetEventController.categoryList.length,
                (index) => IconContainerWidget(
                  categoryModel: typetoSetEventController.categoryList[index],
                ),
                ),
              ),
              
            ),
          ),
        ],
      ),
    );
  }
}
//  SingleChildScrollView(
//             child: Obx(
//               ()=> Wrap(
//                 spacing: scaleWidth(50),
//                 runSpacing: scaleHeight(16),
//                 alignment: WrapAlignment.start,
//                 crossAxisAlignment: WrapCrossAlignment.start,
//                 children: [
//                   ...List.generate(
//                     typetoSetEventController.categoryList.length,
//                     (index) => IconContainerWidget(
//                       categoryModel: typetoSetEventController.categoryList[index],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
class IconContainerWidget extends StatelessWidget {
  final CategoryModel categoryModel;

   IconContainerWidget({super.key, required this.categoryModel});
 final TypetoSetEventController typetoSetEventController = Get.find();
 
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        typetoSetEventController.selectedCategory.value=categoryModel.id;
      },
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                color: typetoSetEventController.selectedCategory.value==categoryModel.id? customColors.primary:customColors.primaryBackground,
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
