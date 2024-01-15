import '../../../../../core/utils/helper/flutter_flow_util.dart';
import 'coupon_card.dart';
import 'package:flutter/material.dart';

class CouponseList extends StatelessWidget {
  const CouponseList({super.key});

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(

        children: [
          const CouponCard(expiryDate: "22/1/2024",imagePath:"assets/images/Luxury-Beach-Club-Wedding-Venue-In-Marbella-06.jpg" ,offerText: "offerText",subtitle: "subtitle",title: "title",),
          const CouponCard(expiryDate: "22/1/2024",imagePath:"assets/images/Luxury-Beach-Club-Wedding-Venue-In-Marbella-06.jpg" ,offerText: "offerText",subtitle: "subtitle",title: "title",),
          const CouponCard(expiryDate: "22/1/2024",imagePath:"assets/images/Luxury-Beach-Club-Wedding-Venue-In-Marbella-06.jpg" ,offerText: "offerText",subtitle: "subtitle",title: "title",),
          const CouponCard(expiryDate: "22/1/2024",imagePath:"assets/images/Luxury-Beach-Club-Wedding-Venue-In-Marbella-06.jpg" ,offerText: "offerText",subtitle: "subtitle",title: "title",),
        ].divide(const SizedBox(height: 10,)),
      ),
    );
  }
}