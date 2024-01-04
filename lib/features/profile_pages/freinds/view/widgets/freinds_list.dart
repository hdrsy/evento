import 'package:evento/core/shared/widgets/widget/users_shimmer_card.dart';
import 'package:evento/core/utils/animation/shimmer_animation.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/profile_pages/freinds/controller/freinds_cotroller.dart';
import 'package:evento/features/profile_pages/freinds/model/freinds_model.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FreindsList extends StatelessWidget {
   FreindsList({super.key});
final FreindsController  freindsController=Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FreindsController>(
      builder: (ccontext) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 0,horizontal: 5 ),
          child:  freindsController.isMyFriendsLoading.value? ShimmerFriendCard():
        
          
          
          Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      textScaleFactor: MediaQuery.of(context).textScaleFactor,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: freindsController.myFreinds.length.toString(),
                            style: customTextStyle.bodyMedium.override(
                              fontFamily: 'Nunito',
                              color: customColors.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              useGoogleFonts: true,
                            ),
                          ),
                          TextSpan(
                            text: " Friends",
                            style: TextStyle(
                              color: customColors.primaryText,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          )
                        ],
                        style: customTextStyle.bodyMedium,
                      ),
                    ),
                    // Text(
                    //   "Manage",
                    //   style: customTextStyle.bodyMedium.override(
                    //     fontFamily: 'Nunito',
                    //     color: customColors.primary,
                    //     fontSize: 12,
                    //     useGoogleFonts: false,
                    //   ),
                    // ),
                  ],
                ),
              ),

              ...List.generate(freindsController.myFreinds.length, (index) =>  FreindsCard(freindsModel:freindsController.myFreinds[index] ,))
            ].divide(const SizedBox(
              height: 10,
            )),
          ),
        );
      }
    );
  }
}

class FreindsCard extends StatelessWidget {
  const FreindsCard({super.key,required this.freindsModel});
final FreindsModel freindsModel;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 1),
        child: Container(
          width: 100,
          decoration: BoxDecoration(
            color: customColors.secondaryBackground,
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=900&q=60',
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                    child: Text(
                      "Randy Rudolph",
                      style: customTextStyle.bodyLarge,
                    ),
                  ),
                ),
                Icon(
                  Icons.keyboard_control_sharp,
                  color: customColors.secondaryText,
                  size: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
