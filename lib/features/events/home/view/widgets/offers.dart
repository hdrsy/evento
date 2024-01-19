import '../../../../../core/responsive/responsive.dart';
import '../../../../../core/shared/functions/lists/carouse_options_functions.dart';
import '../../../../../core/shared/widgets/images/network_image.dart';
import '../../../../../core/shared/widgets/lists/carousel_slider.dart';
import '../../controller/home_controller.dart';
import 'column_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
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
            title:tr( "Offers"),
            subTitle: tr("Local Celebrations & Urban Vibes"),
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