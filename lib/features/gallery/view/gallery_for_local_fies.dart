import 'dart:io';

import '../../../core/shared/models/media.dart';
import '../../../main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:easy_localization/easy_localization.dart';
class GalleryForLocalScreen extends StatelessWidget {
   GalleryForLocalScreen({super.key, required this.files});
  // final GalleryController galleryController=Get.find();
  final List<MediaModel> files;
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
          leading: InkWell(
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
                  gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  itemCount: files.length,
                  itemBuilder: (context, index) {
                  return  MediaWidget(mediaItem: files[index],);
                  
                    

                  },
                ),
              )
            ],
          ),
        ));
  }

}

class MediaWidget extends StatelessWidget {
  final MediaModel mediaItem;

  MediaWidget({Key? key, required this.mediaItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (mediaItem.mediaType) {
      case "image":
        return Image.file(mediaItem.media);
      case "video":
        return VideoWidget(video: mediaItem.media);
      default:
        return const SizedBox.shrink();
    }
  }
}

class VideoWidget extends StatefulWidget {
  final File video;

  const VideoWidget({Key? key, required this.video}) : super(key: key);

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.video)
      ..initialize().then((_) {
        _controller.setVolume(0);
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
        : Container(); // Placeholder while the video loads
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}



