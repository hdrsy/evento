import 'package:evento/core/utils/extenstions/color_extenstions.dart';
import 'package:evento/core/utils/extenstions/text_extenstions.dart';
import 'package:evento/features/auth/welcome/view/widgets/build_logo_buttons.dart';
import 'package:evento/features/auth/welcome/view/widgets/build_page_indecator.dart';
import 'package:evento/features/auth/welcome/view/widgets/build_page_view.dart';
import 'package:evento/main.dart';
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
      body: _buildWelcomScreenBody(),
    );
  }

  Widget _buildWelcomScreenBody() {
    return Stack(
      alignment: const AlignmentDirectional(0, 1),
      children: [
        BuildPageView(controller: controller,),
        BuildPageIndecator(pageController: controller,),
       
      const BuildLogoButtons()
      ],
    );
  }
}
