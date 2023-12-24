// import 'package:evento/core/responsive/responsive.dart';
// import 'package:evento/core/shared/widgets/buttons/general_button.dart';
// import 'package:evento/core/shared/widgets/buttons/toggle_icon.dart';
// import 'package:evento/core/utils/helper/flutter_flow_util.dart';
// import 'package:evento/core/utils/theme/text_theme.dart';
// import 'package:evento/features/reels/controller/reels_controller.dart';
// import 'package:evento/features/reels/controller/video_controller.dart';
// import 'package:evento/main.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:video_player/video_player.dart';

// class ReelWidget extends StatelessWidget {
//    ReelWidget({super.key});
// final heroTag=Get.arguments[0];
// VideoController videoController=Get.put(VideoController());
//   @override
//   Widget build(BuildContext context) {
//     return 
//         Hero(
//           transitionOnUserGestures: true,
//           tag: heroTag,
//           child: GetBuilder<VideoController>(
//             builder: (ccontext) {
//               return SafeArea(
//                 child: Column(
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                 Expanded(
//                   child: Container(
//                     width: MediaQuery.sizeOf(context).width,
//                     height: MediaQuery.sizeOf(context).height ,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(
//                         color: customColors.secondaryBackground,
//                         width: 2,
//                       ),
//                     ),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.max,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Expanded(
//                           child: Stack(
//                             children: [
//                               vedio(),
//                               Column(
//                                 mainAxisSize: MainAxisSize.max,
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Align(
//                                     alignment: const AlignmentDirectional(1.00, -1.00),
//                                     child: Container(
//                                       width: double.infinity,
//                                       decoration: const BoxDecoration(),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsetsDirectional.fromSTEB(
//                                         10, 10, 10, 10),
//                                     child: Column(
//                                       mainAxisSize: MainAxisSize.max,
//                                       mainAxisAlignment: MainAxisAlignment.end,
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Padding(
//                                           padding: const EdgeInsetsDirectional.fromSTEB(
//                                               0, 0, 0, 10),
//                                           child: Row(
//                                             mainAxisSize: MainAxisSize.max,
//                                             children: [
//                                               Row(
//                                                 mainAxisSize: MainAxisSize.max,
//                                                 children: [
//                                                   userPhoto(),
//                                                   Padding(
//                                                     padding: const EdgeInsetsDirectional
//                                                         .fromSTEB(5, 0, 0, 0),
//                                                     child: userName(),
//                                                   ),
//                                                 ],
//                                               ),
//                                               followButton(),
//                                             ].divide(const SizedBox(width: 10)),
//                                           ),
//                                         ),
//                                         Align(
//                                           alignment:
//                                               const AlignmentDirectional(-1.00, 1.00),
//                                           child: Padding(
//                                             padding: const EdgeInsetsDirectional.fromSTEB(
//                                                 0, 0, 0, 5),
//                                             child: Text(
//                                               "Festival of Arts",
//                                               style: customTextStyle.bodyMedium.override(
//                                                 fontFamily: 'Nunito',
//                                                 color: Colors.white,
//                                                 fontSize: 16,
//                                                 useGoogleFonts: true,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         Row(
//                                           mainAxisSize: MainAxisSize.max,
//                                           children: [
//                                             numberOfShowing(),
//                                             reelDate(),
//                                           ].divide(const SizedBox(width: 10)),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               commentShareLike(),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                     ],
//                   ),
//               );
//             }
//           ),
//         );
//   }

//   Align commentShareLike() {
//     return Align(
//       alignment: const AlignmentDirectional(1.00, -1.00),
//       child: Column(
//         mainAxisSize: MainAxisSize.max,
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Container(
//             decoration: const BoxDecoration(),
//             child: Column(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ToggleIcon(
//                   onPressed: () async {},
//                   value: false,
//                   onIcon: Icon(
//                     Icons.favorite_rounded,
//                     color: customColors.error,
//                     size: 25,
//                   ),
//                   offIcon: const Icon(
//                     Icons.favorite_border_sharp,
//                     color: Colors.white,
//                     size: 25,
//                   ),
//                 ),
//                 Text(
//                   "2.6k",
//                   style: customTextStyle.bodyMedium.override(
//                     fontFamily: 'Nunito',
//                     color: Colors.white,
//                     useGoogleFonts: true,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             decoration: const BoxDecoration(),
//             child: Column(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Icon(
//                   Icons.insert_comment_outlined,
//                   color: Colors.white,
//                   size: 24,
//                 ),
//                 Text(
//                   "200",
//                   style: customTextStyle.bodyMedium.override(
//                     fontFamily: 'Nunito',
//                     color: Colors.white,
//                     useGoogleFonts: true,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             decoration: const BoxDecoration(),
//             child: Column(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Icon(
//                   Icons.reply_outlined,
//                   color: Colors.white,
//                   size: 24,
//                 ),
//                 Text(
//                   "12",
//                   style: customTextStyle.bodyMedium.override(
//                     fontFamily: 'Nunito',
//                     color: Colors.white,
//                     useGoogleFonts: true,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Text reelDate() {
//     return Text(
//       "30-10-2023",
//       style: customTextStyle.bodyMedium.override(
//         fontFamily: 'Nunito',
//         color: Colors.white,
//         fontSize: 12,
//         useGoogleFonts: true,
//       ),
//     );
//   }

//   Row numberOfShowing() {
//     return Row(
//       mainAxisSize: MainAxisSize.max,
//       children: [
//         const Icon(
//           Icons.headphones_sharp,
//           color: Colors.white,
//           size: 15,
//         ),
//         Align(
//           alignment: const AlignmentDirectional(-1.00, 1.00),
//           child: Text(
//             "6.6k",
//             style: customTextStyle.bodyMedium.override(
//               fontFamily: 'Nunito',
//               color: Colors.white,
//               fontSize: 14,
//               useGoogleFonts: true,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   ButtonWidget followButton() {
//     return ButtonWidget(
//       onPressed: () {
//         print('Button pressed ...');
//       },
//       text: "Follow",
//       options: ButtonOptions(
//         width: 85,
//         height: 31,
//         padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
//         iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
//         color: const Color(0x006E429A),
//         textStyle: customTextStyle.titleSmall.override(
//           fontFamily: 'Nunito',
//           color: customColors.info,
//           fontSize: 14,
//           fontWeight: FontWeight.normal,
//           useGoogleFonts: true,
//         ),
//         borderSide: BorderSide(
//           color: customColors.primaryBackground,
//         ),
//         borderRadius: BorderRadius.circular(20),
//       ),
//     );
//   }

//   Column userName() {
//     return Column(
//       mainAxisSize: MainAxisSize.max,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Sam",
//           style: customTextStyle.bodyLarge.override(
//             fontFamily: 'Nunito',
//             color: Colors.white,
//             useGoogleFonts: true,
            
//           ),
//         ),
//       ],
//     );
//   }

//   Container userPhoto() {
//     return Container(
//       width: 50,
//       height: 50,
//       clipBehavior: Clip.antiAlias,
//       decoration: const BoxDecoration(
//         shape: BoxShape.circle,
//       ),
//       child: Image.network(
//         'https://picsum.photos/seed/913/600',
//         fit: BoxFit.cover,
//       ),
//     );
//   }

//   ClipRRect reelVedio() {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(12),
//       child: Image.asset(
//         'assets/images/Encore_EventType_TheatreConcertandSpecialEvents_4.jpg',
//         width: double.infinity,
//         height: double.infinity,
//         fit: BoxFit.cover,
//       ),
//     );
//   }
//   Widget vedio(){
//     VideoController videoController=Get.find();
//     return GetBuilder<VideoController>(
//       builder:(c)=> Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//               // width: double.infinity,
//               // height: double.infinity,
//               child: videoController.playerController.value.isInitialized
//                     ? GestureDetector(
//             // onTap: (){
//             //   videoController.toggleSound();
//             // },
            
//             onTapUp: (details) {
//             double width = screenWidth;
//             if (details.globalPosition.dx > width / 2) {
//               videoController.nextVideo();
//             } else {
//               videoController.previousVideo();
//             }
//           },
//             child: AspectRatio(
//                         aspectRatio:videoController.playerController.value.aspectRatio,
//                         child: VideoPlayer(videoController.playerController)),
//                       )
//                     : Container() ,
//             ),
//         ],
//       ),
      
//     );
//   }
// }
