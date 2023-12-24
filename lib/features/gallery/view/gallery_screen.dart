import 'package:evento/core/shared/widgets/images/network_image.dart';
import 'package:evento/features/gallery/controller/gallery_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class GalleryScreen extends StatelessWidget {
   GalleryScreen({super.key});
  final GalleryController galleryController=Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: customColors.secondaryBackground,
        appBar: AppBar(
          backgroundColor: customColors.secondaryBackground,
          title: Text("Gallery",
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
                  itemCount: galleryController.images.length,
                  itemBuilder: (context, index) {
                    return getImageNetwork(url: "/storage/${galleryController.images[index]}", width: null, height: null);
                    
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


