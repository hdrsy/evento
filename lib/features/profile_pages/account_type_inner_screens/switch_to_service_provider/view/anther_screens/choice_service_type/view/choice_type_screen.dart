// Importing necessary packages and widgets.
import 'package:evento/core/shared/widgets/bottom_sheets/show_bottom_sheet.dart';
import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/shared/widgets/text_fields/search_filed.dart';
import 'package:evento/core/utils/animation/animation_def.dart';
import 'package:evento/core/utils/animation/animation_util.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/profile_pages/account_type_inner_screens/switch_to_service_provider/view/anther_screens/choice_service_type/controller/choice_type_controller.dart';
import 'package:evento/features/profile_pages/account_type_inner_screens/switch_to_service_provider/view/anther_screens/choice_service_type/view/widget/choice_type_suggest_list.dart';
import 'package:evento/features/profile_pages/account_type_inner_screens/switch_to_service_provider/view/anther_screens/choice_service_type/view/widget/service_provider_account_widget.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

// Defining the ChoiceTypeScreen as a StatelessWidget.
class ChoiceTypeScreen extends StatelessWidget {
  // Constructor with optional key parameter.
  ChoiceTypeScreen({super.key});

  // Creating an instance of ChoiceTypeController and registering it with GetX.
  final ChoiceTypeController choiceTypeController =
      Get.put(ChoiceTypeController());

  @override
  // Building the widget.
  Widget build(BuildContext context) {
    return Scaffold(
      // Setting the background color of the screen.
      backgroundColor: customColors.secondaryBackground,

      // Configuring the app bar with a back button.
      appBar: AppBar(
        backgroundColor: customColors.secondaryBackground,
        leading: InkWell(
          onTap: () {
            Get.back(); // Navigating back on tap.
          },
          child: Icon(
            Icons.arrow_back_rounded,
            color: customColors.primaryText,
            size: 30,
          ),
        ),
      ),

      // Setting the body of the Scaffold.
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Aligning the title text at the center.
            Align(
              alignment: const AlignmentDirectional(0, -1),
              child: Text(
                "What best describes you?",
                style: customTextStyle.bodyMedium.override(
                  fontFamily: 'Nunito',
                  color: customColors.primaryText,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  useGoogleFonts: true,
                ),
              ).tr(),
            ),
            // Aligning the description text at the center and applying animation.
            Align(
              alignment: const AlignmentDirectional(0, 0),
              child: Text(
                "With a service provider account, you get access to tools like insights about your followers and account performance, new contact options and more.",
                textAlign: TextAlign.center,
                style: customTextStyle.bodySmall.override(
                  fontFamily: 'Nunito',
                  color: customColors.primaryText,
                  useGoogleFonts: true,
                ),
              )
                  .tr()
                  .animateOnPageLoad(animationsMap['textOnPageLoadAnimation']!),
            ),
            // Search text field.
            searchTextField(onChanged: (value) {}),
            // Custom widget that suggests service types.
            ChoiceTypeSuggestList(),
            // Spacer to create space between widgets.
            const Spacer(),
            // Padding for the 'Done' button.
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
              child: ButtonWidget(
                onPressed: () async {
                  // Showing a bottom sheet on button press.
                  // Get.dialog(ServiceProviderAccounWidget());

                  showButtonSheet(
                      context: context,
                      widget: const ServiceProviderAccounWidget(),
                      height: MediaQuery.sizeOf(context).height * 0.6);
                },
                text: tr("Done"),
                options: ButtonOptions(
                  width: 200,
                  height: 40,
                  padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
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
            )
          ].divide(const SizedBox(
            height: 10,
          )), // Dividing widgets with spacing.
        ),
      ),
    );
  }
}
