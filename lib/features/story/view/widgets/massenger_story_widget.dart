// import 'package:evento/core/responsive/responsive.dart';
// import 'package:evento/core/utils/theme/text_theme.dart';
// import 'package:evento/features/reels/controller/reels_controller.dart';
// import 'package:evento/features/reels/controller/video_controller.dart';
// import 'package:evento/main.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// String videoUrl='https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';
// class MassengarStoryWidget extends StatelessWidget {
//   final ReelsController reelsController = Get.find();
  
//    MassengarStoryWidget({super.key,required this.heroTag});
//   final heroTag;
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: (){
      
//         Get.toNamed('/vedioReels',arguments: [heroTag,reelsController.videoList[heroTag].videosUrl[0]]);
//       },
//       child: Hero(
//         transitionOnUserGestures: true,
//         tag: heroTag,
//         child: Container(
//           width: scaleWidth(150),
//           height: scaleHeight(200),
//           decoration: const BoxDecoration(
            
//             borderRadius: BorderRadius.all(Radius.circular(20)),
//           ),
//           child: Stack(
//             children: [
//               ClipRRect(
                
//                   borderRadius: const BorderRadius.all(Radius.circular(20)),
//                   child: Image.asset(
//                     "assets/images/Encore_EventType_TheatreConcertandSpecialEvents_4.jpg",
//                     fit: BoxFit.fill,
//                     height: scaleHeight(300),
//                     width: scaleWidth(150),
//                   )),
//               Container(
                
//                 padding: padding(10, 10, 10, 10),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     userPhoto(),
//                     Text(
                      
//                       "Maysam Sweid ",
//                       style: customTextStyle.bodyMedium.override(
//                         fontSize: 16,
//                         fontFamily: 'Nunito',
//                         color: Colors.white,
//                         useGoogleFonts: true,
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Align userPhoto() {
//     return Align(
//         alignment: const AlignmentDirectional(-1, -1),
//         child: Container(
//           width: 45,
//           height: 45,
//           // padding: padding(3,3,3,3),
//           clipBehavior: Clip.antiAlias,
//           decoration:  BoxDecoration(
//             border: Border.all(color: customColors.primary,width: 2),
//             shape: BoxShape.circle,
//             image: const DecorationImage(image: NetworkImage(
//             'https://picsum.photos/seed/913/600',
            
//           ),)
//           ),
          
//         ));
//   }
// }
