// Importing necessary packages and widgets.
import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/account_type_inner_screens/switch_to_service_provider/controller/switch_to_service_provider_controller.dart';
import 'package:evento/features/account_type_inner_screens/switch_to_service_provider/view/widgets/page_view_builder.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Defining the SwithcToServiceProviderScreen as a StatelessWidget.
class SwithcToServiceProviderScreen extends StatelessWidget {
  // Constructor with optional key parameter.
  SwithcToServiceProviderScreen({super.key});

  // Creating an instance of SwithcToServiceProviderController and registering it with GetX.
  final SwithcToServiceProviderController swithcToServiceProviderController = Get.put(SwithcToServiceProviderController());

  @override
  // Building the widget.
  Widget build(BuildContext context) {
    return Scaffold(
      // Setting the background color of the screen.
      backgroundColor: customColors.secondaryBackground,

      // Configuring the app bar with a cancel button.
      appBar: AppBar(
        backgroundColor: customColors.secondaryBackground,
        leading: InkWell(
          onTap: () {
            Get.back(); // Navigating back on tap.
          },
          child: Icon(
            Icons.cancel_outlined,
            color: customColors.primaryText,
            size: 30,
          ),
        ),
      ),

      // Setting the body of the Scaffold.
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          // Expanded widget to use available space.
          Expanded(
            child: SizedBox(
              width: double.infinity,
              height: 500,
              child: Stack(
                children: [
                  // Padding for the page view builder.
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 40),
                    child: pageViewBuilder(context),
                  ),
                  // Function call to get bottom indicator widget.
                  bottomIndicator(context),
                ],
              ),
            ),
          ),
          // ButtonWidget to navigate to the next screen.
          ButtonWidget(
            onPressed: () async {
              Get.toNamed('/ChoiceTypeScreen');
            },
            text: " Continue",
            options: buttonOptions(context), // Using the buttonOptions function.
          ),
          // Spacing after the button.
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

// Function to define ButtonOptions.
ButtonOptions buttonOptions(BuildContext context) {
  return ButtonOptions(
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
    borderSide: const BorderSide(color: Colors.transparent, width: 1),
    borderRadius: BorderRadius.circular(8),
  );
}
