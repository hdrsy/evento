import '../../../../core/utils/theme/text_theme.dart';
import 'widgets/contact_us.dart';
import 'widgets/faq.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.secondaryBackground,
      appBar: AppBar(
        backgroundColor: customColors.secondaryBackground,
        title: Text(tr("Help Center"),
            style: customTextStyle.bodyMedium
                .copyWith(color: customColors.primary, fontSize: 20)),
        centerTitle: true,
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
    body:   SafeArea(
        top: true,
        child: DefaultTabController(
          length: 2,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Align(
                      alignment: const Alignment(0, 0),
                      child: TabBar(
                        labelColor: customColors.primary,
                        unselectedLabelColor: customColors.grayIcon,
                        labelStyle: customTextStyle.titleSmall.override(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w500,
                          useGoogleFonts: true,
                        ),
                        unselectedLabelStyle: const TextStyle(),
                        indicatorColor: customColors.primary,
                        indicatorWeight: 4,
                        tabs:  [
                          Tab(
                            text:tr( "FAQ"),
                          ),
                          Tab(
                            text:tr( "Contact Us"),
                          ),

                        ],
                      ),
                    ),
                   const Expanded(
                        child: TabBarView(
                      children: [
                       FAQ(),
                       ContactUs()
                       ],
                    ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      );
  }
}