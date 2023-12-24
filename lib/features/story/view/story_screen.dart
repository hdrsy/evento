// import 'package:evento/core/responsive/responsive.dart';
// import 'package:evento/core/utils/helper/flutter_flow_util.dart';
// import 'package:evento/features/reels/controller/reels_controller.dart';
// import 'package:evento/features/reels/view/widgets/massenger_story_widget.dart';
// import 'package:evento/features/reels/view/widgets/users_story.dart';
// import 'package:evento/main.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class StoryScreen extends StatelessWidget {
//   StoryScreen({super.key});
//   final ReelsController reelsController = Get.find();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: customColors.secondaryBackground,
//       appBar: AppBar(
//         backgroundColor: customColors.secondaryBackground,
//         title: Text("Stories",
//             style: customTextStyle.bodyMedium
//                 .copyWith(color: customColors.primary, fontSize: 20)),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: padding(10, 5, 0, 5),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const UserStories(),
//             // ...List.generate(3, (index) =>ReelWidget())
//              Container(
//               // padding: padding(0,0,0,5),
//               alignment: Alignment.center,
//               width: double.infinity,
//                child: Wrap(
//                 runSpacing: 15,
//                 spacing: 15,
//                 alignment: WrapAlignment.start,
//                 runAlignment: WrapAlignment.start,
//                 children: [
//                   ...List.generate(reelsController.videoList.length,(index)=>MassengarStoryWidget(heroTag: index,))
//                   ,
//                   // MassengarStoryWidget(),
//                   // MassengarStoryWidget(),
//                   // MassengarStoryWidget(),
//                 ],
//                          ),
//              )
//           ].divide(SizedBox(
//             height: scaleHeight(5),
//           )),
//         ),
//       ),
//     );
//   }
// }
