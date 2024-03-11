import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/images/network_image.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/events/customize_event/type_to_set_event/controller/type_to_set_event_controller.dart';
import 'package:evento/features/events/home/model/category_model.dart';
import 'package:evento/main.dart';
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
            height: screenHeight * 0.56,
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
              child: GridView.count(
                crossAxisCount: 3, // Number of items per row
                crossAxisSpacing:
                    scaleWidth(45), // Horizontal spacing between items
                mainAxisSpacing:
                    scaleHeight(16), // Vertical spacing between items
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
class IconContainerWidget extends StatefulWidget {
  final CategoryModel categoryModel;

  IconContainerWidget({Key? key, required this.categoryModel})
      : super(key: key);

  @override
  _IconContainerWidgetState createState() => _IconContainerWidgetState();
}

class _IconContainerWidgetState extends State<IconContainerWidget> {
  bool showRipple = false;
  final TypetoSetEventController typetoSetEventController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          showRipple = !showRipple;
        });
        if (typetoSetEventController.selectedCategory.value ==
            widget.categoryModel.id) {
          typetoSetEventController.selectedCategory.value = 0;
        } else {
          typetoSetEventController.selectedCategory.value =
              widget.categoryModel.id;
        }
      },
      child: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // Ripple effect
                AnimatedContainer(
                  onEnd: () {
                    setState(() {
                      showRipple = false;
                    });
                  },
                  width: showRipple ? 65 : 0,
                  height: showRipple ? 65 : 0,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeOutQuart,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    boxShadow: showRipple
                        ? [
                            for (var i = 0; i < 2; i += 1)
                              BoxShadow(
                                  spreadRadius: i * 5.0,
                                  color: customColors.primary
                                      .withAlpha(255 ~/ (i + 2)))
                          ]
                        : [],
                  ),
                ),
                // Icon Container
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 2,
                          color:
                              typetoSetEventController.selectedCategory.value ==
                                      widget.categoryModel.id
                                  ? customColors.primary
                                  : customColors.primaryBackground),
                      color: customColors.secondaryBackground,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: getImageNetworkImageProvider(
                              url: widget.categoryModel.icon,
                              width: null,
                              height: null))),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(
                widget.categoryModel.title,
                style: customTextStyle.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
