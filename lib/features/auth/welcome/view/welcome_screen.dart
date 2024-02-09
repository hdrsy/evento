import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/bottom_sheets/show_bottom_sheet.dart';
import 'package:evento/features/profile_pages/profile/view/widgets/switch_language.dart';

import '../../../../core/utils/extenstions/color_extenstions.dart';
import '../../../../core/utils/extenstions/text_extenstions.dart';
import 'widgets/build_logo_buttons.dart';
import 'widgets/build_page_indecator.dart';
import 'widgets/build_page_view.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});
  PageController controller =
      PageController(viewportFraction: 1, keepPage: true);

  @override
  Widget build(BuildContext context) {
    customColors = Theme.of(context).extension<AppColorsExtension>()!;
    customTextStyle = Theme.of(context).extension<TextExtension>()!;

    return Scaffold(
      backgroundColor: Colors.black,
      body: _buildWelcomScreenBody(context),
    );
  }

  Widget _buildWelcomScreenBody(BuildContext context) {
    return Stack(
      alignment: const AlignmentDirectional(0, 1),
      children: [
        BuildPageView(
          controller: controller,
        ),
        BuildPageIndecator(
          pageController: controller,
        ),
        Positioned(
            top: 20,
            left: 20,
            child: GestureDetector(
                onTap: () {
                  showButtonSheet(
                      context: context,
                      widget: LanguageSelector(),
                      height: screenHeight * 0.2);
                },
                child: Icon(
                  Icons.language_outlined,
                  color: customColors.info,
                  size: 25,
                ))),
        const BuildLogoButtons()
      ],
    );
  }
}
