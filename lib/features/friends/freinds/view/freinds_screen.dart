import '../../../../core/utils/theme/text_theme.dart';
import '../controller/freinds_cotroller.dart';
import 'widgets/freinds_list.dart';
import 'widgets/requests_list.dart';
import 'widgets/sent_list.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class FreindsScreen extends StatelessWidget {
  FreindsScreen({super.key});
  final FreindsController freindsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: customColors.primary,
          elevation: 8,
          child: Icon(
            Icons.add,
            color: customColors.info,
            size: 24,
          ),
          onPressed: () {
            Get.toNamed('/AddFriendsScreen');
          }),
      backgroundColor: customColors.secondaryBackground,
      appBar: AppBar(
        surfaceTintColor: customColors.secondaryBackground,
        backgroundColor: customColors.secondaryBackground,
        title: Text(tr("Freinds"),
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
          initialIndex: freindsController.initTabIndex,
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
                        dividerColor: customColors.secondaryBackground,
                        unselectedLabelStyle: const TextStyle(),
                        indicatorColor: customColors.primary,
                        indicatorWeight: 4,
                        tabs: [
                          Tab(
                            text: tr("Friends"),
                          ),
                          Tab(
                            text: tr("Requests"),
                          ),
                          Tab(
                            text: tr("Sent"),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: TabBarView(
                      children: [
                        FreindsList(),
                        RequestsList(),
                        SentList(),
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
