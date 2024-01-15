import '../../../../../core/responsive/responsive.dart';
import '../../../../../core/shared/widgets/bottom_sheets/show_bottom_sheet.dart';
import '../../../../../core/shared/widgets/buttons/general_button.dart';
import '../../../../../core/utils/animation/animation_def.dart';
import '../../../../../core/utils/animation/animation_util.dart';
import '../../../signin/controller/signin_controller.dart';
import '../../../signin/view/sign_in_screen.dart';
import '../../../signup/controller/signup_controller.dart';
import '../../../signup/view/signup_screen.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';


class BuildLogoButtons extends StatelessWidget {
  const BuildLogoButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return // Generated code for this Column Widget...
        Align(
      alignment: const AlignmentDirectional(0.00, 0.00),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 37, 0, 0),
            child: Image.asset(
              'assets/images/Artboard_1.png',
              width: 300,
              height: 100,
              fit: BoxFit.cover,
            ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation']!),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 3),
                      child: ButtonWidget(
                        showLoadingIndicator: false,
                        onPressed: () async {
                          Get.lazyPut(()=>SignupController());
                             await showButtonSheet(context: context, widget:  SignupScreen(), height: screenHeight*0.8).then((value) => 
                             Get.delete<SignupController>()
                             );
                       
                        },
                        text:tr( "Join"),
                        options: ButtonOptions(
                          width: MediaQuery.sizeOf(context).width * 0.4,
                          height: 50,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              24, 0, 24, 0),
                          iconPadding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: customColors.primaryBackground,
                          textStyle: customTextStyle.titleSmall.copyWith(
                            fontFamily: 'Merriweather',
                            color: customColors.primaryText,
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
                        showLoadingIndicator: false,
                        onPressed: () async {
                          Get.lazyPut(()=>SigninController());
                          
                          await showButtonSheet(context: context, widget: SignInScreen(), height: screenHeight*0.8).then((value) => Get.delete<SigninController>());
                         
                        },
                        text:tr( "Sign in"),
                        options: ButtonOptions(
                          width: MediaQuery.sizeOf(context).width * 0.4,
                          height: 50,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              24, 0, 24, 0),
                          iconPadding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: const Color(0x001A1A1A),
                          textStyle: customTextStyle.titleSmall.copyWith(
                            fontFamily: 'Merriweather',
                            color: Colors.white,
                          ),
                          elevation: 3,
                          borderSide: BorderSide(
                            color: customColors.secondaryBackground,
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
                padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    isGuset=true;
                    Get.toNamed('/home');
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Continue as guest",
                        style: customTextStyle.bodyMedium.copyWith(
                          fontFamily: 'Merriweather',
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ).tr(),
                      const Icon(
                        Icons.arrow_right_alt,
                        color: Colors.white,
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
