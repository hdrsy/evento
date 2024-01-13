import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/functions/lists/carouse_options_functions.dart';
import 'package:evento/core/shared/widgets/images/network_image.dart';
import 'package:evento/core/shared/widgets/lists/carousel_slider.dart';
import 'package:evento/features/events/home/controller/home_controller.dart';
import 'package:evento/features/events/home/view/widgets/column_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Offers extends StatelessWidget {
   Offers({super.key});
final  OffersController offersController=Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> offersController.itemList.isEmpty? SizedBox.shrink():
      
       Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           ColumnText(
            title: "Offers",
            subTitle: " Local Celebrations & Urban Vibes",
            onTap: (){
              Get.toNamed('/SeeAllOffersScreen',arguments: [
                offersController.pageId,
                offersController.itemList,
              ]);
            },
          ),
         SizedBox(height: scaleHeight(10),),
          SizedBox(
            // height: scaleHeight(350),
            child: buildOffersList()
          )
        ],
      ),
    )
    
    ;
  }
}

buildOffersList(){
  final  OffersController offersController=Get.find();

  return 
Container(
  padding: padding(0,15,0,15),
  width: double.infinity,
  alignment: Alignment.center,
  // color: Colors.red,
  height: 200,
  child:   buildListShow(
    body: List.generate(offersController.itemList.length, (index) => offerImage("/storage/${offersController.itemList[index].images[0]}",offersController.itemList[index].offer.eventId,offersController.itemList[index].offer.percent)),
    carouselOptions:  CaroucelOptionFunctions.newOpiningOptions
  )
);

}

Widget offerImage(String imgUrl,int eventId,int percent) {
  return InkWell(
    onTap: (){
           Get.toNamed('/eventDetailes', arguments: [eventId,true,percent]);
               
    },
    child: ClipRRect(
  
    borderRadius: BorderRadius.circular(20),
  
    child: getImageNetwork(url: imgUrl, width: screenWidth*0.8, height: 600)
    
    
  ),
  );
}