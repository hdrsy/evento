// import 'package:video_compress/video_compress.dart';
import 'dart:io';

import 'package:video_compress_plus/video_compress_plus.dart';


Future<File?> compressVideo(File videoFile) async {
  try {
    // Get the original file size
    int originalSize = await videoFile.length();
    print("Original Size: $originalSize bytes");

    // Compress the video
    MediaInfo? mediaInfo = await VideoCompress.compressVideo(
      videoFile.path,
      quality: VideoQuality.DefaultQuality, // Adjust quality as needed
      deleteOrigin: false,
    );

    // Get the compressed file size
    if (mediaInfo != null) {
      int compressedSize = await mediaInfo.file!.length();
      print("Compressed Size: $compressedSize bytes");
      return mediaInfo.file; // Return the compressed file
    }
    return null;
  } catch (e) {
    print("Error compressing video: $e");
    return null;
  }
}


Future<File> generateThumbnail(File videoFile) async {
  final thumbnail = await VideoCompress.getFileThumbnail(videoFile.path);
return thumbnail;
 }


// Future<Duration> getVideoDuration(File file){

// } 
Future<Duration?> getVideoDuration(File videoFile) async {
  final info = await VideoCompress.getMediaInfo(videoFile.path);
  return info.duration != null ? Duration(seconds: info.duration!.round()) : null;
}