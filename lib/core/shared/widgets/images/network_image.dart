import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';

import '../../../server/server_config.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

getImageNetwork(
    {required String url,
    required double? width,
    required double? height,
    ValueKey? key,
    Color? imgColor,
    AlignmentGeometry? alignmentGeometry}) {
  String cleanUrl = url.contains("storage") ? url : "/storage/$url";
  return Image.network(
    key: key,
    ServerConstApis.baseAPIImage + cleanUrl,
    width: width,
    alignment: alignmentGeometry ?? Alignment.center,
    height: height,
    fit: BoxFit.cover,
    color: imgColor,
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
          height: height ?? 200,
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

getImageNetworkforCahing({
  required String url,
  required double? width,
  required double? height,
  Color? imgColor,
  Alignment? alignmentGeometry,
}) {
  String cleanUrl = url.contains("storage") ? url : "/storage/$url";
  final fullUrl = ServerConstApis.baseAPIImage + cleanUrl;

  return CachedNetworkImage(
    imageUrl: fullUrl,
    width: width,
    height: height,
    fit: BoxFit.cover,
    alignment: alignmentGeometry ?? Alignment.center,
    color: imgColor,
    placeholder: (context, url) => Shimmer.fromColors(
      // baseColor: Color(0xff666666), // Replace with your base color
      baseColor: Colors.grey[500]!, // Replace with your base color
      highlightColor: Colors.grey[400]!, // Replace with your highlight color
      // highlightColor: Color(0xff95a1ac), // Replace with your highlight color
      child: Container(
        width: width,
        height: height,
        color: Colors.white,
      ),
    ),
    errorWidget: (context, url, error) {
      return SizedBox(
        width: width,
        height: height,
        child: Center(
          child: Icon(
            Icons.error, // or any other icon or widget
          ),
        ),
      );
    },
  );
}

getImageNetworkImageProvider({
  required String url,
  required int? width,
  required int? height,
  Color? imgColor,
  Alignment? alignmentGeometry,
}) {
  String cleanUrl = url.contains("storage") ? url : "/storage/$url";
  final fullUrl = ServerConstApis.baseAPIImage + cleanUrl;

  return CachedNetworkImageProvider(
    fullUrl,
    maxWidth: width,
    maxHeight: height,
    errorListener: (context) => SizedBox(
      width: width as double,
      height: height as double,
      child: Center(
        child: Icon(
          Icons.error, // or any other icon or widget
        ),
      ),
    ),
  );
}
