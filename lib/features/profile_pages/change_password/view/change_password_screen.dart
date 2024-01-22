import '../../../../core/responsive/responsive.dart';
import '../../../../core/shared/widgets/buttons/general_button.dart';
import '../../../../core/shared/widgets/error_messages/error_messages.dart';
import '../../../../core/shared/widgets/text_fields/edit_profile_field.dart';
import '../../../../core/utils/theme/app_fonts_from_google.dart';
import '../../../../core/utils/theme/text_theme.dart';
import '../controller/change_password_controller.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});
  final ChangePasswordController changePasswordController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.secondaryBackground,
      appBar: AppBar(
        backgroundColor: customColors.secondaryBackground,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_rounded,
            color: customColors.primaryText,
            size: 30,
          ),
        ),
      ),
      body: Obx(
        ()=> Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          width: screenWidth,
          height: screenHeight,
          child: Form(
            key: changePasswordController.formstate,
            child: Column(
              children: [
                Align(
                  alignment: const AlignmentDirectional(-1, -1),
                  child: Text(
                    "Change password",
                    style: customTextStyle.bodyMedium.override(
                      fontFamily: primaryFontFamily,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      useGoogleFonts: true,
                    ),
                  ).tr(),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                  child: Text(
                    "Your password must be at least 6 characters and should include a combination of numbers, letters and special characters (!\$@%)",
                    style: customTextStyle.bodyMedium.override(
                        fontSize: 14,
                        color: customColors.secondaryText,
                        fontFamily: primaryFontFamily,
                        useGoogleFonts: true),
                  ).tr(),
                ),
                const SizedBox(
                  height: 15,
                ),
                EditProfileField(
                  isPasswordSecure: true,
                    controller: changePasswordController.oldPassword,
                    hintText: "",
                    labelText:tr( "Current pssword"),
                    onChanged: (value) {
                      // editProfileController.gender.text=value;
                    },
                    validator: (value) {
                      return null;
                    }),
                EditProfileField(
                                    isPasswordSecure: true,
                    controller: changePasswordController.newPassword,
                    hintText: "",
                    labelText:tr( "New pssword"),
                    onChanged: (value) {
                      // editProfileController.gender.text=value;
                    },
                    validator: (value) {
                      return null;
                    }),
                EditProfileField(
                                    isPasswordSecure: true,
                    controller: changePasswordController.retypePassword,
                    hintText: "",
                    labelText:tr( "Re-type new password"),
                    onChanged: (value) {
                      // editProfileController.gender.text=value;
                    },
                    validator: (value) {
                      if (changePasswordController.newPassword.text !=
                          changePasswordController.retypePassword.text) {
                        return tr("Not Matching the new password");
                      }
                      return null;
                    }),
      
                const Spacer(),
                // Generated code for this Button Widget...
                ButtonWidget(
                  showLoadingIndicator: changePasswordController.isLoading.value,
                  onPressed: () async {
                    changePasswordController.onPressDone();
                  },
                  text:tr( "Save"),
                  options: ButtonOptions(
                    width: 200,
                    height: 40,
                    padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
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
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                
                ...List.generate(
                    changePasswordController.errorMessage.length,
                    (index) => ErrorMessages(
                          message: changePasswordController.errorMessage[index],
                        )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
