// import 'package:video_compress/video_compress.dart';
import 'dart:io';

import 'package:video_compress_plus/video_compress_plus.dart';

// Future<MediaInfo?> compressVideo(String videoPath) async {
//   final compressedVideo = await VideoCompress.compressVideo(
//     videoPath,
//     quality: VideoQuality.MediumQuality, // Adjust the quality as needed
//     deleteOrigin: false, // Set to true if you want to delete the original file
//   );

//   return compressedVideo;
// }

Future<File> generateThumbnail(File videoFile) async {
  final thumbnail = await VideoCompress.getFileThumbnail(videoFile.path);
return thumbnail;
 }
