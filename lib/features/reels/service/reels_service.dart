import 'dart:developer';
import '../../../core/cache_config/cache_config.dart';
import '../model/reels_model.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ReelService {
// Here, I use some stock videos as an example.
// But you need to make this list empty when you will call api for your reels

  // Future getVideosFromApI() async {
  //   // call your api here

  //   for (var rr in getFakeData()) {
  //     // Cache videos for each RR object
  //     // then add all links to _reels variable
  //     for (var i = 0; i < rr.videos.length; i++) {
  //       cacheVideos(rr.videos[i].url, i);
  //       // you can add multiple logic for to cache videos. Right now I'm caching all videos
  //     }
  //   }
  // }

  cacheVideos(String url, int i) async {
    FileInfo? fileInfo = await kCacheManager.getFileFromCache(url);
    if (fileInfo == null) {
      log('downloading file ##------->$url##');
      await kCacheManager.downloadFile(url);
      log('downloaded file ##------->$url##');
    }
  }
}
