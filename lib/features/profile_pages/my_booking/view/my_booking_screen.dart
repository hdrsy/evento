import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/profile_pages/my_booking/view/widget/canceld_list.dart';
import 'package:evento/features/profile_pages/my_booking/view/widget/completed_list.dart';
import 'package:evento/features/profile_pages/my_booking/view/widget/up_coming_list.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyBookingScreen extends StatelessWidget {
  const MyBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.secondaryBackground,
      appBar: AppBar(
        backgroundColor: customColors.secondaryBackground,
        title: Text("My Booking",
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
                        tabs: const [
                          Tab(
                            text: "Upcoming",
                          ),
                          Tab(
                            text: "Completed",
                          ),
                          Tab(
                            text: "Canceled",
                          ),
                        ],
                      ),
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
