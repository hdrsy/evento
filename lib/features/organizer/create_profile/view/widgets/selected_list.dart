import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/organizer/create_profile/controller/oganizer_create_profile_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SelectState extends StatelessWidget {
   SelectState({super.key});
OrganizerCreateProfileController organizerCreateProfileController=Get.find();
String selectedState='';
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Container(
        // height: scaleHeight(200), // Height of the picker
        padding: padding(0,40,0,40),
          decoration: BoxDecoration(
        color: customColors.secondaryBackground,
        borderRadius:const BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),  
        child: Column(
           mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
            width: 50,
            child: Divider(
              thickness: 3,
              color: customColors.secondary,
            ),
          ),
            Expanded(
              child: CupertinoPicker(
                
                itemExtent: 32.0, // Height of each item
                backgroundColor: customColors.secondaryBackground,
                onSelectedItemChanged: (index) {
                 selectedState= organizerCreateProfileController.states[ index];
                },
                children: List<Widget>.generate(organizerCreateProfileController.states.length, (index) {
                  return Center(child: Text(organizerCreateProfileController.states[index],style: customTextStyle.titleSmall.override(
                                  fontFamily: 'BeerSerif',
                                  color: customColors.primaryText,
                                  fontSize: 16,
                                  useGoogleFonts: false,
                                ),),);
                }),
              ),
            ),
            Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ButtonWidget(
                      onPressed: () async {
                        Get.back();
                      },
                      text: "Cancel",
                      options: ButtonOptions(
                        width: 120,
                        height: 45,
                        padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                        iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        color: customColors.secondaryBackground,
                        textStyle: customTextStyle
                            .titleSmall
                            .override(
                              fontFamily: 'BeerSerif',
                              color: customColors.primaryText,
                              fontSize: 14,
                              useGoogleFonts: false,
                            ),
                        elevation: 0,
                        borderSide: BorderSide(
                          color: customColors.primary,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      showLoadingIndicator: false,
                    ),
                    ButtonWidget(
                      onPressed: () async {
                    organizerCreateProfileController.selectedState=selectedState;
                    organizerCreateProfileController.update();
                    Get.back();
                      },
                      text:  "Done" ,
                      options: ButtonOptions(
                        width: 120,
                        height: 45,
                        padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                        iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        color: customColors.primary,
                        textStyle:
                            customTextStyle.titleSmall.override(
                                  fontFamily: 'BeerSerif',
                                  color: customColors.info,
                                  fontSize: 14,
                                  useGoogleFonts: false,
                                ),
                        elevation: 0,
                        borderSide: BorderSide(
                          color: customColors.primary,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      showLoadingIndicator: false,
                    ),
                  ],
                ),
              ),
          ].divide(SizedBox(height: scaleHeight(8),)),
        ),
      ),
    );
  }
}