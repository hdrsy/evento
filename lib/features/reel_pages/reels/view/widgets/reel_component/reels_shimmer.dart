import '../../../../../../core/responsive/responsive.dart';
import '../../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ReelsShimmer extends StatelessWidget {
  const ReelsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: customColors.secondary,
      highlightColor: customColors.gray600,
      child: Container(
        padding: padding(0, 10, 0, 10),
        width: screenWidth,
        height: MediaQuery.of(context).size.height * 0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: customColors.info,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      height: 10,
                      color: customColors.info,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 50,
                      height: 10,
                      color: customColors.info,
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 200,
                  height: 10,
                  color: customColors.info,
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: 250,
                  height: 10,
                  color: customColors.info,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
