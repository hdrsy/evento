import 'package:carousel_slider/carousel_options.dart';
import 'package:evento/core/responsive/responsive.dart';
import 'package:flutter/material.dart';

 class CaroucelOptionFunctions{
static CarouselOptions featuredOptions= CarouselOptions(
      initialPage: 2,
      viewportFraction: 0.7,
      disableCenter: true,
      enlargeCenterPage: true,
      enlargeFactor: 0.3,
      enableInfiniteScroll: true,
      scrollDirection: Axis.horizontal,
      autoPlay: false,
      onPageChanged: (index, _) {},
    );
 static   CarouselOptions offersOptions= CarouselOptions(
        initialPage: 0,
        viewportFraction: 0.8,
        disableCenter: true,
        enlargeCenterPage: true,
        enlargeFactor: 0.25,
        enableInfiniteScroll: true,
        scrollDirection: Axis.vertical,
        autoPlay: true,
        autoPlayAnimationDuration:const Duration(milliseconds: 800),
        autoPlayInterval: const Duration(milliseconds: (800 + 4000)),
        autoPlayCurve: Curves.linear,
        pauseAutoPlayInFiniteScroll: true,
        onPageChanged: (index, _) {},
      );
  static  CarouselOptions basedOnYourTastOptions=CarouselOptions(
      initialPage: 1,
      viewportFraction: 0.8,
      disableCenter: true,
      enlargeCenterPage: true,
      enlargeFactor: 0.25,
      enableInfiniteScroll: true,
      scrollDirection: Axis.horizontal,
      autoPlay: false,
      onPageChanged: (index, _) {},
    );
  static  CarouselOptions forYouOptions= CarouselOptions(
    
      initialPage: 1,
      viewportFraction: 0.85,
      disableCenter: true,
      enlargeCenterPage: true,
      enlargeFactor: 0.2,
      enableInfiniteScroll: true,
      scrollDirection: Axis.horizontal,
      autoPlay: false,
      onPageChanged: (index, _) {},
    );
  static  CarouselOptions seeMoreEvents= CarouselOptions(


      initialPage: 1,
      viewportFraction: 0.8,
      disableCenter: true,
      enlargeCenterPage: true,
      enlargeFactor: 0.01,
      enableInfiniteScroll: true,
      scrollDirection: Axis.horizontal,
      autoPlay: false,
      onPageChanged: (index, _){},
    
    );
 static   CarouselOptions newOpiningOptions=CarouselOptions(
  height: scaleHeight(140),
                initialPage: 0,
                viewportFraction: 1,
                disableCenter: true,
                enlargeCenterPage: true,
                enlargeFactor: 0.25,
                enableInfiniteScroll: true,
                scrollDirection: Axis.vertical,
                autoPlay: true,
                autoPlayAnimationDuration:const Duration(milliseconds: 800),
                autoPlayInterval:const Duration(milliseconds: (800 + 4000)),
                autoPlayCurve: Curves.linear,
                pauseAutoPlayInFiniteScroll: true,
                onPageChanged: (index, _) {}
              );
}