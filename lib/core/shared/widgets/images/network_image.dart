import 'dart:developer';

import '../../../server/server_config.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

 getImageNetwork(
    {required String url, required double? width, required double? height,AlignmentGeometry? alignmentGeometry}) {
      
  return Image.network(
    ServerConstApis.baseAPI + url,
    width: width,
    alignment: alignmentGeometry??Alignment.center,
    height: height,
    fit: BoxFit.cover,
    loadingBuilder:
        (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
      if (loadingProgress == null) {
        return child; // Image has finished loading
      }
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!, // Replace with your base color
        highlightColor: Colors.grey[100]!, // Replace with your highlight color
        child: Container(
          width: width,
          height: height,
          color: Colors.white,
        ),
      );
    },
    errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
      log(stackTrace.toString());
      log(error.toString());
      return SizedBox(
        width: width,
        height: height,
        child: const Center(
          child: Icon(
            Icons.error, // or any other icon or widget
            // size: 1,
          ),
        ),
      );
    },
  );
}
