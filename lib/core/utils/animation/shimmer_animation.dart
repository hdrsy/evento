import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingWidget extends StatelessWidget {
  const ShimmerLoadingWidget({super.key, required this.loadingShimmerWidget});
final Widget loadingShimmerWidget;
  @override
  Widget build(BuildContext context) {
    return  Shimmer.fromColors(
        baseColor: customColors.secondary,
        highlightColor: customColors.gray600,
        child:  loadingShimmerWidget,
      );
  }
}