import 'dart:convert';
import 'dart:typed_data';
import 'package:evento/features/reels/model/reels_model.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CacheReels {
  static final CacheManager _cacheManager = CacheManager(
    Config(
      'reelsCache', // Cache key
      stalePeriod: const Duration(days: 7), // Adjust as needed
      maxNrOfCacheObjects: 100,
    ),
  );

//   Future<void> cacheRRObjects(List<ReelModel> rrObjects) async {
//     for (var rr in rrObjects) {
//       await _cacheManager.putFile(
//   'RR-${rr.id}', // Unique key for each RR object
//   Uint8List.fromList(utf8.encode(jsonEncode(rr.toJson()))), // Convert RR object to JSON, then to bytes, and then to Uint8List
//   eTag: rr.id.toString(), // Use the RR's id as eTag for simplicity
// );


    //   // Cache videos for each RR object
    //   for (var videoDetail in rr.videos) {
    //     await cacheVideo(videoDetail.url);
    //   }
    // }
  // }

  Future<void> cacheVideo(String videoUrl) async {
    FileInfo? fileInfo = await _cacheManager.getFileFromCache(videoUrl);
    if (fileInfo == null) {
      await _cacheManager.downloadFile(videoUrl);
    }
  }

  // Future<RR?> getRRObject(int id) async {
  //   FileInfo? fileInfo = await _cacheManager.getFileFromCache('RR-$id');
  //   if (fileInfo != null) {
  //     String rrJson = utf8.decode(await fileInfo.file.readAsBytes());
  //     return RR.fromJson(jsonDecode(rrJson)); // Deserialize JSON to RR object
  //   }
  //   return null;
  // }
}
