import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

SizedBox featuredLoading() {
  return SizedBox(
    // height: scaleHeight(330),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 60,
          height: 15,
          color: customColors.info,
        ),
        Container(
          width: 80,
          height: 10,
          color: customColors.info,
        ),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...List.generate(
                  3,
                  (index) => Container(
                    width: 355,
                    height: 300,
                    // height: 330 ,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: customColors.info,
                        ),
                        color: customColors.info),
                  ),
                ),
              ].divide(SizedBox(
                width: scaleWidth(5),
              )),
            )),
      ].divide(const SizedBox(
        height: 5,
      )),
    ),
  );
}

SizedBox forYouLoading() {
  return SizedBox(
    // height: scaleHeight(330),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 60,
          height: 15,
          color: customColors.info,
        ),
        Container(
          width: 80,
          height: 10,
          color: customColors.info,
        ),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...List.generate(
                  3,
                  (index) => Container(
                    width: 200,
                    height: 210,
                    // height: 330 ,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: customColors.info,
                        ),
                        color: customColors.info),
                  ),
                ),
              ].divide(SizedBox(
                width: scaleWidth(5),
              )),
            )),
      ].divide(const SizedBox(
        height: 5,
      )),
    ),
  );
}

SizedBox inYourCityLoading() {
  return SizedBox(
    // height: scaleHeight(330),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 60,
          height: 15,
          color: customColors.info,
        ),
        Container(
          width: 80,
          height: 10,
          color: customColors.info,
        ),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...List.generate(
                  3,
                  (index) => Container(
                   width: 150,
    height: 215,
                    // height: 330 ,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: customColors.info,
                        ),
                        color: customColors.info),
                  ),
                ),
              ].divide(SizedBox(
                width: scaleWidth(5),
              )),
            )),
      ].divide(const SizedBox(
        height: 5,
      )),
    ),
  );
}

SizedBox categoryloading() {
  return SizedBox(
    child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ...List.generate(
              10,
              (index) => Container(
                width: scaleWidth(65),
                height: scaleWidth(65),
                decoration: BoxDecoration(
                  color: customColors.info,
                  borderRadius: BorderRadius.circular(15),
                ),
                alignment: const AlignmentDirectional(0.00, 0.00),
              ),
            )
          ].divide(const SizedBox(
            width: 5,
          )),
        )),
  );
}

class GridViewBuilderExample extends StatelessWidget {
  const GridViewBuilderExample({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: customColors.info, // Container color
              borderRadius: BorderRadius.circular(10), // Border radius
            ),
          ),
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: customColors.info, // Container color
              borderRadius: BorderRadius.circular(10), // Border radius
            ),
          ),
        ].divide(const SizedBox(
          width: 10,
        )),
      ),
    );
  }
}
