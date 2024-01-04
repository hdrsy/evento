import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/profile_pages/freinds/controller/freinds_cotroller.dart';
import 'package:evento/features/profile_pages/freinds/view/widgets/freinds_list.dart';
import 'package:evento/features/profile_pages/freinds/view/widgets/requests_list.dart';
import 'package:evento/features/profile_pages/freinds/view/widgets/sent_list.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FreindsScreen extends StatelessWidget {
   FreindsScreen({super.key});
final FreindsController  freindsController=Get.find();
  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      floatingActionButton: FloatingActionButton(
         backgroundColor: customColors.primary,
  elevation: 8,
  child: Icon(
    Icons.add,
    color: customColors.info,
    size: 24,
  ),
        onPressed: (){

          Get.toNamed('/AddFriendsScreen');
        }),
      backgroundColor: customColors.secondaryBackground,
      appBar: AppBar(
        backgroundColor: customColors.secondaryBackground,
        title: Text("Freinds",
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
      body:  SafeArea(
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
                            text: "Friends",
                          ),
                          Tab(
                            text: "Requests",
                          ),
                          Tab(
                            text: "Sent",
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