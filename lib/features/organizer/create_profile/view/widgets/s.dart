// import 'package:flutter/material.dart';

// class MyWidget extends StatelessWidget {
//   const MyWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return // Generated code for this Container Widget...
// Container(
//   decoration: BoxDecoration(),
//   child: Padding(
//     padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
//     child: Container(
//       height: 200,
//       child: Stack(
//         children: [
//           Align(
//             alignment: AlignmentDirectional(0, -1),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(0),
//               child: Image.network(
//                 'https://picsum.photos/seed/902/600',
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Align(
//             alignment: AlignmentDirectional(1, 1),
//             child: Padding(
//               padding: EdgeInsets.all(10),
//               child: Container(
//                 width: 25,
//                 height: 25,
//                 decoration: BoxDecoration(
//                   color: FlutterFlowTheme.of(context).primaryBackground,
//                   shape: BoxShape.circle,
//                   border: Border.all(
//                     color: FlutterFlowTheme.of(context).secondaryBackground,
//                   ),
//                 ),
//                 child: Icon(
//                   Icons.camera_alt,
//                   color: FlutterFlowTheme.of(context).primaryText,
//                   size: 15,
//                 ),
//               ),
//             ),
//           ),
//           InkWell(
//             splashColor: Colors.transparent,
//             focusColor: Colors.transparent,
//             hoverColor: Colors.transparent,
//             highlightColor: Colors.transparent,
//             onTap: () async {
//               final selectedMedia = await selectMediaWithSourceBottomSheet(
//                 context: context,
//                 allowPhoto: true,
//               );
//               if (selectedMedia != null &&
//                   selectedMedia.every(
//                       (m) => validateFileFormat(m.storagePath, context))) {
//                 setState(() => _model.isDataUploading1 = true);
//                 var selectedUploadedFiles = <FFUploadedFile>[];
//                 var downloadUrls = <String>[];
//                 try {
//                   selectedUploadedFiles = selectedMedia
//                       .map((m) => FFUploadedFile(
//                             name: m.storagePath.split('/').last,
//                             bytes: m.bytes,
//                             height: m.dimensions?.height,
//                             width: m.dimensions?.width,
//                             blurHash: m.blurHash,
//                           ))
//                       .toList();
//                   downloadUrls = (await Future.wait(
//                     selectedMedia.map(
//                       (m) async => await uploadData(m.storagePath, m.bytes),
//                     ),
//                   ))
//                       .where((u) => u != null)
//                       .map((u) => u!)
//                       .toList();
//                 } finally {
//                   _model.isDataUploading1 = false;
//                 }
//                 if (selectedUploadedFiles.length == selectedMedia.length &&
//                     downloadUrls.length == selectedMedia.length) {
//                   setState(() {
//                     _model.uploadedLocalFile1 = selectedUploadedFiles.first;
//                     _model.uploadedFileUrl1 = downloadUrls.first;
//                   });
//                 } else {
//                   setState(() {});
//                   return;
//                 }
//               }
//             },
//             child: Stack(
//               children: [
//                 Align(
//                   alignment: AlignmentDirectional(-0.87, 1.69),
//                   child: Container(
//                     width: 120,
//                     height: 120,
//                     decoration: BoxDecoration(
//                       color: FlutterFlowTheme.of(context).primaryBackground,
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                         color:
//                             FlutterFlowTheme.of(context).secondaryBackground,
//                         width: 2,
//                       ),
//                     ),
//                     child: Container(
//                       width: MediaQuery.sizeOf(context).width * 0.8,
//                       height: MediaQuery.sizeOf(context).width * 0.8,
//                       clipBehavior: Clip.antiAlias,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                       ),
//                       child: Image.asset(
//                         'assets/images/beautiful-shot-colorful-fireworks-night-sky-during-holidays_181624-17156.jpg',
//                         fit: BoxFit.cover,
//                         alignment: Alignment(0, 0),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Align(
//                   alignment: AlignmentDirectional(-0.45, 1.25),
//                   child: InkWell(
//                     splashColor: Colors.transparent,
//                     focusColor: Colors.transparent,
//                     hoverColor: Colors.transparent,
//                     highlightColor: Colors.transparent,
//                     onTap: () async {
//                       final selectedMedia =
//                           await selectMediaWithSourceBottomSheet(
//                         context: context,
//                         allowPhoto: true,
//                       );
//                       if (selectedMedia != null &&
//                           selectedMedia.every((m) =>
//                               validateFileFormat(m.storagePath, context))) {
//                         setState(() => _model.isDataUploading2 = true);
//                         var selectedUploadedFiles = <FFUploadedFile>[];
//                         var downloadUrls = <String>[];
//                         try {
//                           selectedUploadedFiles = selectedMedia
//                               .map((m) => FFUploadedFile(
//                                     name: m.storagePath.split('/').last,
//                                     bytes: m.bytes,
//                                     height: m.dimensions?.height,
//                                     width: m.dimensions?.width,
//                                     blurHash: m.blurHash,
//                                   ))
//                               .toList();
//                           downloadUrls = (await Future.wait(
//                             selectedMedia.map(
//                               (m) async =>
//                                   await uploadData(m.storagePath, m.bytes),
//                             ),
//                           ))
//                               .where((u) => u != null)
//                               .map((u) => u!)
//                               .toList();
//                         } finally {
//                           _model.isDataUploading2 = false;
//                         }
//                         if (selectedUploadedFiles.length ==
//                                 selectedMedia.length &&
//                             downloadUrls.length == selectedMedia.length) {
//                           setState(() {
//                             _model.uploadedLocalFile2 =
//                                 selectedUploadedFiles.first;
//                             _model.uploadedFileUrl2 = downloadUrls.first;
//                           });
//                         } else {
//                           setState(() {});
//                           return;
//                         }
//                       }
//                     },
//                     child: Container(
//                       width: 25,
//                       height: 25,
//                       decoration: BoxDecoration(
//                         color: FlutterFlowTheme.of(context).primaryBackground,
//                         shape: BoxShape.circle,
//                         border: Border.all(
//                           color: FlutterFlowTheme.of(context)
//                               .secondaryBackground,
//                         ),
//                       ),
//                       child: Icon(
//                         Icons.camera_alt,
//                         color: FlutterFlowTheme.of(context).primaryText,
//                         size: 15,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//   ),
// )

//   }
// }