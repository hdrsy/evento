

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';


Widget buildListShow(
    {required List<Widget> body,
   required CarouselOptions carouselOptions
   }) {
  return CarouselSlider.builder(
    
      itemCount: body.length,
      itemBuilder: (context, index, realIdx) {
        return body[index];
      },
      options: carouselOptions);
}
