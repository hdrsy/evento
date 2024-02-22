
import 'package:get/get.dart';

class GalleryItem {
  final String url;
  final bool isVideo;

  GalleryItem({required this.url, this.isVideo = false});
}

class GalleryController extends GetxController {
  late List<String> images;
  List<String> videos = [];
  late List<GalleryItem> mixedGalleryItems; // New list for mixed items

  @override
  void onInit() {
    Map<String, List<String>> args = Get.arguments ?? {};
    images = args['images'] ?? [];
    if (args.containsKey('videos') && args['videos']!.isNotEmpty) {
      videos = args['videos']!;
    }

    mixedGalleryItems = _mixImagesAndVideos(images, videos);

    super.onInit();
  }

  List<GalleryItem> _mixImagesAndVideos(
      List<String> images, List<String> videos) {
    List<GalleryItem> mixedItems = [];
    int maxLength = images.length + videos.length;

    for (int i = 0; i < maxLength; i++) {
      if (i < images.length) {
        mixedItems.add(GalleryItem(url: images[i]));
      } else {
        int videoIndex = i - images.length;

        mixedItems.add(GalleryItem(url: videos[videoIndex], isVideo: true));
      }
    }
    print("mixed lenght is :${mixedItems.length}");
    return mixedItems;
  }
}
