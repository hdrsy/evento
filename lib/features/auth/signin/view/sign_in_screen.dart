import '../../../../core/responsive/responsive.dart';
import '../../../../core/shared/functions/validation/password_validation.dart';
import '../../../../core/shared/functions/validation/phone_validation.dart';
import '../../../../core/shared/widgets/buttons/general_button.dart';
import '../../../../core/shared/widgets/error_messages/error_messages.dart';
import '../../../../core/shared/widgets/text_fields/text_field.dart';
import '../../../../core/utils/helper/flutter_flow_util.dart';
import '../controller/signin_controller.dart';
import 'widgets/forget_password_widget.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

// ignore: must_be_immutable
class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  // Add any necessary class-level variables, like controllers, here.
  SigninController signinController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      // Setting the width and height to fill the screen.
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      // Decorate with color and rounded corners.
      decoration: BoxDecoration(
        color: customColors.secondaryBackground,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40), topRight: Radius.circular(40)),
      ),
      // Padding for the inner content.
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: 20, vertical: scaleHeight(40)),
        // SingleChildScrollView allows the content to be scrollable.
        child: SingleChildScrollView(
          child: Form(
            key: signinController.formstate,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Close button at the top right corner.
                Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.cancel_outlined,
                      color: customColors.secondaryText,
                      size: 24,
                    ),
                  ),
                ),
                // 'Sign in' text.
                Text(
                  'Sign in', // Replace with localization if needed.
                  style: customTextStyle.bodyMedium.copyWith(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ).tr(),
                // Description text below 'Sign in'.
                Text(
                  'Welcome back! Log in to continue.', // Replace with localization if needed.
                  style: customTextStyle.bodyMedium,
                ).tr(),
                SizedBox(
                  height: scaleHeight(5),
                ),
                // Input field for mobile phone.
                customTextField(
                  context: context,
                  label: tr("+963    mobile Phone"),
                  onChanged: (value) {
                    if (value != null &&
                        !value.startsWith('0') &&
                        value.isNotEmpty) {
                      // Prepend '0' if it's not already there and the value is not empty
                      signinController.phone.text = '0$value';
                    } else {
                      signinController.phone.text = value!;
                    }
                  },
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    return phoneValidation(value);
                  },
                ),
                // Input field for password.
                customTextField(
                  isPassWordVisible: true,
                  context: context,
                  label: tr("Password"),
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (value) {
                    signinController.password.text = value!;
                  },
                  validator: (value) {
                    return passwordValidation(value);
                  },
                ),
                // Additional UI elements like 'Forgot Password' and 'Terms of Use'.
                _buildAdditionalUI(context),
                SizedBox(
                  height: scaleHeight(5),
                ),
                // Sign In button.
                Obx(
                  () => Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ButtonWidget(
                          showLoadingIndicator:
                              signinController.isLoading.value,
                          onPressed: () {
                            signinController.onClickSignIn();
                          },
                          text: tr(
                              'Sign In'), // Replace with localization if needed.
                          options: ButtonOptions(
                            width: 400,
                            height: 45,
                            color: customColors.primary,
                            textStyle: customTextStyle.titleSmall.copyWith(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                      ...List.generate(
                          signinController.errorMessage.length,
                          (index) => ErrorMessages(
                                message: signinController.errorMessage[index],
                              )),
                    ],
                  ),
                ),
              ].divide(const SizedBox(
                height: 16,
              )),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAdditionalUI(BuildContext context) {
    // Helper method to create additional UI elements like 'Forgot Password'.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FogetPasswordWidget(),
// const TermsAndCondisionTexts()
      ].divide(SizedBox(
        height: scaleHeight(10),
      )),
    );
  }
}
