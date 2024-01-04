import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerFriendCard extends StatelessWidget {
  const ShimmerFriendCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 100.0,
        padding: const EdgeInsets.all(16.0),
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Shimmer.fromColors(
        baseColor: customColors.secondary,
        highlightColor: customColors.gray600,
        child:  Container(
              width: 64.0,
              height: 64.0,
              decoration: const BoxDecoration(
              color: Colors.white,
                
                shape: BoxShape.circle),
            )),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const SizedBox(height: 20,),
                  Shimmer.fromColors(
        baseColor: customColors.secondary,
        highlightColor: customColors.gray600,
        child: Container(
                    width: 150,
                    height: 8.0,
                    color: Colors.white,
                    
                  )),
                
                  const SizedBox(height: 20,),
                 Shimmer.fromColors(
        baseColor: customColors.secondary,
        highlightColor: customColors.gray600,
        child:
                  Container(
                    width: 100,
                    height: 10.0,
                    decoration: BoxDecoration(
                    color: Colors.white,
                      borderRadius: BorderRadius.circular(20)
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
