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
          children: [
           Shimmer.fromColors(
        baseColor: customColors.secondary,
        highlightColor: customColors.gray600,
        child:  Container(
              width: 64.0,
              height: 64.0,
              decoration: BoxDecoration(
              color: Colors.white,
                
                shape: BoxShape.circle),
            )),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Shimmer.fromColors(
        baseColor: customColors.secondary,
        highlightColor: customColors.gray600,
        child: Container(
                    width: 300,
                    height: 8.0,
                    color: Colors.white,
                    
                  )),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.0),
                  ),
                
                  Container(
                    width: 40.0,
                    height: 8.0,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
