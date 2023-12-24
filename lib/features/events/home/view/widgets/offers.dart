import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/functions/lists/carouse_options_functions.dart';
import 'package:evento/core/shared/widgets/lists/carousel_slider.dart';
import 'package:evento/features/events/home/view/widgets/column_text.dart';
import 'package:flutter/material.dart';

class Offers extends StatelessWidget {
  const Offers({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         ColumnText(
          title: "Offers",
          subTitle: " Local Celebrations & Urban Vibes",
          onTap: (){},
        ),
       SizedBox(height: scaleHeight(10),),
        SizedBox(
          // height: scaleHeight(350),
          child: buildOffersList()
        )
      ],
    )
    
    ;
  }
}

buildOffersList(){
  return 
Container(
  padding: padding(0,15,0,15),
  width: double.infinity,
  alignment: Alignment.center,
  child:   buildListShow(
    body: List.generate(3, (index) => offerImage()),
    carouselOptions:  CaroucelOptionFunctions.newOpiningOptions
  )
);

}

ClipRRect offerImage() {
  return ClipRRect(

  borderRadius: BorderRadius.circular(20),

  child: Image.asset(

    'assets/images/Yran-4start.webp',

    width: scaleWidth(320),

    // height:scaleHeight(100),

    fit: BoxFit.cover,

  ),

);
}