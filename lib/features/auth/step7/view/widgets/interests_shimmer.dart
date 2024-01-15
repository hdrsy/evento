import '../../../../../core/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget interestShimmerGridView(){
   return Shimmer.fromColors(
    baseColor: Colors.grey[300]!, // Replace with your base color
    highlightColor: Colors.grey[100]!, // Replace with your highlight color
    child:Padding(
      padding: const EdgeInsets.only(top: 30),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          childAspectRatio: 1,
        ),
        itemCount: 9,
        itemBuilder: (context, index) {
        return  const InterestShimmerWidget();
        },
      ),
    )
   );
}

class InterestShimmerWidget extends StatelessWidget {
  const InterestShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
          width: scaleHeight(100),
          height: scaleHeight(100),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            shape: BoxShape.rectangle,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 84,
                height: 74,
                decoration: BoxDecoration(
                  // color: isSelected.value
                  //     ? customColors.primary
                  //     : customColors.primaryBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Padding(
                  padding:  EdgeInsets.all(20),
                  child: SizedBox(
                    
                    width: 100,
                    height: 100,
                    
                  ),
                ),
              ),
              
            ],
          ),
        );
  }
}