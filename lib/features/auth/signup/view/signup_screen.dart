import '../../../../core/responsive/responsive.dart';
import '../../../../core/shared/functions/validation/name_validation.dart';
import '../../../../core/shared/functions/validation/phone_validation.dart';
import '../../../../core/shared/widgets/buttons/general_button.dart';
import '../../../../core/shared/widgets/error_messages/error_messages.dart';
import '../../../../core/shared/widgets/text_fields/text_field.dart';
import '../../../../core/utils/helper/flutter_flow_util.dart';
import '../controller/signup_controller.dart';
import 'widgets/terms_and_condision_texts.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

// ignore: must_be_immutable
class SignupScreen extends StatelessWidget {
   SignupScreen({super.key});
   
SignupController signupController=Get.find();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // Setting the width and height to fill the screen.
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        // Decorate with color and rounded corners.
        decoration: BoxDecoration(
          color: customColors.secondaryBackground,
          borderRadius:const BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
        ),
        // Padding for the inner content.
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 20, vertical: scaleHeight(40)),
          // SingleChildScrollView allows the content to be scrollable.
          child: SingleChildScrollView(
            child: Form(
              key: signupController.formstate,
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
                    'Join', // Replace with localization if needed.
                    style: customTextStyle.bodyMedium.copyWith(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ).tr(),
                  // Description text below 'Sign in'.
                  Text(
                    'Join our community and unlock exclusive features.', // Replace with localization if needed.
                    style: customTextStyle.bodyMedium,
                  ).tr(),
                  SizedBox(
                    height: scaleHeight(5),
                  ),
                  // Input field for mobile phone.
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: customTextField(
                            context: context,
                            label:tr( "First Name"),
                            onChanged: (value) {
                              signupController.firstName.text=value!;
                            },
                            validator: (value) {
                             return  nameValidation(value);
                            // return null;
                            },
                          ),
                        ),
                        SizedBox(width: scaleWidth(10),),
                        Expanded(
                          child: customTextField(
                            context: context,
                            label:tr( "Last Name"),
                            onChanged: (value) {
                              signupController.lastName.text=value!;
                            },
                            validator: (value) {
                             
                             return  nameValidation(value);
                            // return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  customTextField(
                    context: context,
                    label:tr( "+963    mobile Phone"),
                    onChanged: (value) {
                      signupController.phone.text=value!;
                    },
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      return phoneValidation(value);
                      // return null;
                    },
                  ),
                 
                  // Additional UI elements like 'Forgot Password' and 'Terms of Use'.
                  _buildAdditionalUI(context),
                  SizedBox(
                    height: scaleHeight(5),
                  ),
                  // Sign In button.
                  Obx(
                    ()=> Column(
                      children: [
                         
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          
                            ButtonWidget(
                              showLoadingIndicator: signupController.isLoading.value,
                              onPressed: () {
                              //  Get.toNamed('/steps');
                              signupController.onPressSignUp();
                               },
                              text:tr( 'Join'), // Replace with localization if needed.
                              options: ButtonOptions(
                                width: 350,
                                height: 45,
                                color: customColors.primary,
                                textStyle: customTextStyle.titleSmall.copyWith(
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: scaleHeight(5),),
                         ...List.generate(signupController.errorMessage.length,(index)=>
                            
                            ErrorMessages(message:signupController.errorMessage[index] ,)
                          ),
                      ],
                    ),
                  ),
                ].divide(const SizedBox(
                  height: 20,
                )),
              ),
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
      children: [const TermsAndCondisionTexts()].divide(SizedBox(
        height: scaleHeight(10),
      )),
    );
  }
}
