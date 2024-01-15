
import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/profile_pages/my_booking/controller/cancel_booking_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
class SuccefulCancelBookingWidget extends StatelessWidget {
  const SuccefulCancelBookingWidget({
    Key? key,
    
  }) : super(key: key);

  

  @override
  Widget build(BuildContext context) {


    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(50, 50, 50, 50),
      child: Container(
        width: 350,
        height: 400,
        decoration: BoxDecoration(
          color: customColors.secondaryBackground,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                color: customColors.primaryBackground,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle_outline,
                color: customColors.primary,
                size: 100,
              ),
            ),
            Text(
              "Successful!",
              style:customTextStyle.bodyMedium.override(
                    fontFamily: 'Nunito',
                    color: customColors.primary,
                    fontSize: 25,
                    useGoogleFonts: false,
                  ),
            ).tr(),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
              child: Text(
                "You have successfully canceled the event 80% of the funds will be returned to your account.",
                style: customTextStyle.bodyMedium,
              ).tr(),
            ),
            ButtonWidget(
              onPressed: () async {
                // context.pushNamed('My-bookings');
               await Get.offAndToNamed('/MyBookingScreen') ;
                 Get.delete<CancelBookingController>();
                            
              },
              text:tr( "Ok"),
              options: ButtonOptions(
                height: 40,
                padding: const EdgeInsetsDirectional.fromSTEB(50, 0, 50, 0),
                iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                color: customColors.primary,
                textStyle: customTextStyle.titleSmall.override(
                      fontFamily: 'Nunito',
                      color: Colors.white,
                      useGoogleFonts: true,
                    ),
                elevation: 3,
                borderSide: const BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
