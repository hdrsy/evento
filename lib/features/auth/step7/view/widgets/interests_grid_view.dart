import 'package:evento/core/shared/widgets/images/network_image.dart';
import '../../controller/step7_controller.dart';
import '../../model/interst_model.dart';
import '../../../steps/controller/steps_controller.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MyGridView extends StatelessWidget {
  StepsController stepsController = Get.find();
  Step7Controller step7Controller = Get.find();
  MyGridView({super.key});
  @override
  Widget build(BuildContext context) {
    List<InterestItem> items = step7Controller.allInterestItem;
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          childAspectRatio: 1,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return CategoryGridItem(
            item: items[index],
            isSelected: step7Controller.selectedInterests[index],
            onTap: () {
              step7Controller.selectedInterests[index].value =
                  !step7Controller.selectedInterests[index].value;
            },
          );
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class CategoryGridItem extends StatefulWidget {
  CategoryGridItem(
      {super.key,
      required this.item,
      required this.isSelected,
      required this.onTap});
  final InterestItem item;
  RxBool isSelected;
  Function() onTap;

  @override
  State<CategoryGridItem> createState() => _CategoryGridItemState();
}

class _CategoryGridItemState extends State<CategoryGridItem> {
  bool showRipple = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          showRipple = !showRipple;
        });
        widget.onTap();
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
                          color: widget.isSelected.value
                              ? customColors.primary
                              : customColors.primaryBackground),
                      color: customColors.primaryBackground,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: getImageNetworkImageProvider(
                              url: widget.item.icon,
                              width: null,
                              height: null))),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(
                widget.item.title,
                style: customTextStyle.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
// class CategoryGridItem extends StatelessWidget {
//   final InterestItem item;
//   RxBool isSelected;
//   Function() onTap;
//   CategoryGridItem(
//       {Key? key,
//       required this.item,
//       required this.isSelected,
//       required this.onTap})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => GestureDetector(
//         onTap: onTap,
//         child: Container(
//           width: scaleHeight(100),
//           height: scaleHeight(100),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(0),
//             shape: BoxShape.rectangle,
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               Container(
//                 width: 84,
//                 height: 74,
//                 decoration: BoxDecoration(
//                   color: isSelected.value
//                       ? customColors.primary
//                       : customColors.primaryBackground,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: Center(
//                       child: getImageNetwork(
//                           url: item.icon, width: 100, height: 100)),
//                 ),
//               ),
//               Text(
//                 item.title,
//                 style: customTextStyle.bodyMedium,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
