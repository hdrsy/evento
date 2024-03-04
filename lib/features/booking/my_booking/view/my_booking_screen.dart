import '../../../../core/utils/theme/text_theme.dart';
import 'widget/canceld_list.dart';
import 'widget/completed_list.dart';
import 'widget/up_coming_list.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class MyBookingScreen extends StatelessWidget {
  const MyBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.secondaryBackground,
      appBar: AppBar(
        backgroundColor: customColors.secondaryBackground,
        title: Text("My Bookings",
                style: customTextStyle.bodyMedium
                    .copyWith(color: customColors.primary, fontSize: 20))
            .tr(),
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
      body: SafeArea(
        top: true,
        child: DefaultTabController(
          length: 3,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  children: [
                    TabBar(
                      labelColor: customColors.primary,
                      unselectedLabelColor: customColors.grayIcon,
                      labelStyle: customTextStyle.titleSmall.override(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w500,
                        useGoogleFonts: true,
                      ),
                      unselectedLabelStyle: const TextStyle(),
                      indicatorColor: customColors.primary,
                      dividerColor: customColors.secondaryBackground,
                      indicatorWeight: 4,
                      tabs: [
                        Tab(
                          text: tr("Upcoming"),
                        ),
                        Tab(
                          text: tr("Completed"),
                        ),
                        Tab(
                          text: tr("Canceled"),
                        ),
                      ],
                    ),
                    Expanded(
                        child: TabBarView(
                      children: [
                        UpComingList(),
                        CompletedList(),
                        CanceledList()
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
