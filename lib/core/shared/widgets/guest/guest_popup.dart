import 'package:easy_localization/easy_localization.dart';
import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/bottom_sheets/show_bottom_sheet.dart';
import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/auth/signin/controller/signin_controller.dart';
import 'package:evento/features/auth/signin/view/sign_in_screen.dart';
import 'package:evento/features/auth/signup/controller/signup_controller.dart';
import 'package:evento/features/auth/signup/view/signup_screen.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuestPopupWidget extends StatelessWidget {
  const GuestPopupWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const AlignmentDirectional(0, 0),
      child: Container(
        width: 350,
        height: 300,
        decoration: BoxDecoration(
          color: customColors.secondaryBackground,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Material(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/Artboard_1.png',
                    width: 300,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: const AlignmentDirectional(-1, -1),
                      child: Text(
                        "To access this feature, you need to be a part of our community!",
                        textAlign: TextAlign.start,
                        style: customTextStyle.headlineSmall.override(
                          fontFamily: 'Nunito',
                          fontSize: 16,
                          useGoogleFonts: false,
                        ),
                        overflow: TextOverflow.visible,
                      ).tr(),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 3),
                        child: ButtonWidget(
                          onPressed: () async {
                                                         Get.lazyPut(()=>SignupController());
                               await showButtonSheet(context: context, widget:  SignupScreen(), height: screenHeight*0.8).then((value) => 
                               Get.delete<SignupController>()
                               );
                          },
                          text: tr("Join"),
                          options: ButtonOptions(
                            width: MediaQuery.sizeOf(context).width * 0.35,
                            height: 50,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                24, 0, 24, 0),
                            iconPadding:
                                const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            color: customColors.primaryBackground,
                            textStyle: customTextStyle.titleSmall.override(
                              fontFamily: 'Nunito',
                              color: customColors.primaryText,
                              useGoogleFonts: false,
                            ),
                            elevation: 3,
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 3),
                        child: ButtonWidget(
                          onPressed: () async {
                              Get.lazyPut(()=>SigninController());
                            
                            await showButtonSheet(context: context, widget: SignInScreen(), height: screenHeight*0.8).then((value) => Get.delete<SigninController>());
                          
                          },
                          text: tr("Sign in"),
                          options: ButtonOptions(
                            width: MediaQuery.sizeOf(context).width * 0.35,
                            height: 50,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                24, 0, 24, 0),
                            iconPadding:
                                const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            color: customColors.secondaryBackground,
                            textStyle: customTextStyle.titleSmall.override(
                              fontFamily: 'Nunito',
                              color: customColors.primaryText,
                              useGoogleFonts: false,
                            ),
                            elevation: 3,
                            borderSide: BorderSide(
                              color: customColors.primaryBackground,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                  child: Text(
                    "We're excited to have you onboard!",
                    textAlign: TextAlign.start,
                    style: customTextStyle.bodyMedium.override(
                      fontFamily: 'Nunito',
                      color: customColors.primary,
                      useGoogleFonts: false,
                    ),
                  ).tr(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
