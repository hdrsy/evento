import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/shared/widgets/images/network_image.dart';
import 'package:evento/features/gallery/controller/gallery_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class ShowInFullScreen extends StatelessWidget {
  final GalleryItem imageUrl;
  final String tag;

  const ShowInFullScreen(
      {super.key, required this.imageUrl, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.secondaryBackground,
      body: GestureDetector(
        onTap: () => Get.back(),
        child: Center(
          child: Hero(
              tag: tag,
              child: GalleryMediaWidget(
                galleryItem: imageUrl,
              )), // Replace with your image or video widget
        ),
      ),
    );
  }
}

class GalleryMediaWidget extends StatelessWidget {
  final GalleryItem galleryItem;

  GalleryMediaWidget({Key? key, required this.galleryItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return galleryItem.isVideo
        ? VideoWidget(video: galleryItem.url)
        : getImageNetworkforCahing(
            url: "/storage/${galleryItem.url}", width: null, height: null);
  }
}

class VideoWidget extends StatefulWidget {
  final String video;

  const VideoWidget({Key? key, required this.video}) : super(key: key);

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
        Uri.parse("${ServerConstApis.baseAPI}/storage/${widget.video}"))
      ..initialize().then((_) {
        _controller.setVolume(100);
        _controller.play();

        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
        : Center(
            child: CircularProgressIndicator(
              color: customColors.info,
            ),
          ); // Placeholder while the video loads
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
