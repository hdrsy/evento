import 'package:evento/core/server/server_config.dart';
import 'package:evento/features/gallery/view/show_on_fullscreen.dart';
import 'package:video_player/video_player.dart';

import '../../../core/shared/widgets/images/network_image.dart';
import '../controller/gallery_controller.dart';
import '../../../main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class GalleryScreen extends StatelessWidget {
  GalleryScreen({super.key});
  final GalleryController galleryController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: customColors.secondaryBackground,
        appBar: AppBar(
          backgroundColor: customColors.secondaryBackground,
          title: Text(tr("Gallery"),
              style: customTextStyle.bodyMedium
                  .copyWith(color: customColors.primary, fontSize: 20)),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_rounded,
              color: customColors.primaryText,
              size: 30,
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: MasonryGridView.builder(
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  itemCount: galleryController.images.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          Get.to(ShowInFullScreen(
                              imageUrl:
                                  galleryController.mixedGalleryItems[index],
                              tag: index.toString()));
                        },
                        child: Hero(
                            tag: index.toString(),
                            child: GalleryMediaWidget(
                              galleryItem:
                                  galleryController.mixedGalleryItems[index],
                            )));

                    // Image.asset(
                    //   images[index],
                    //   fit: BoxFit.contain,
                    // );
                  },
                ),
              )
            ],
          ),
        ));
  }
}

class GalleryMediaWidget extends StatelessWidget {
  final GalleryItem galleryItem;

  const GalleryMediaWidget({Key? key, required this.galleryItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return galleryItem.isVideo
        ? VideoWidget(video: galleryItem.url)
        : getImageNetwork(
            url: "/storage/${galleryItem.url}", width: null, height: null);
  }
}

class VideoWidget extends StatefulWidget {
  final String video;

  const VideoWidget({Key? key, required this.video}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
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
        _controller.pause();

        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? Stack(
            alignment: Alignment.center,
            children: [
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
              Center(
                child: Icon(
                  Icons.play_circle_fill_outlined,
                  size: 50,
                  color: customColors.info,
                ),
              ),
            ],
          )
        : Container(); // Placeholder while the video loads
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
