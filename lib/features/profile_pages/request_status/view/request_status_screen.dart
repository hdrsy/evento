import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestStatusScreen extends StatelessWidget {
  const RequestStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: customColors.secondaryBackground,
        appBar: AppBar(
          backgroundColor: customColors.secondaryBackground,
          title: Text("Status",
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
        body: _buildBody());
  }

  _buildBody() {
    return // Generated code for this Container Widget...
        Container(
      width: double.infinity,
      decoration: const BoxDecoration(),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              statusElement(),
              Container(
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Divider(
                      thickness: 1,
                      color: customColors.secondary,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        singleRowInfo(
                            "Full Name", "Ahmad Ahmad", Icons.person_outline),
                        singleRowInfo("Phone Number", " +963  9000000",
                            Icons.phone_outlined),
                        singleRowInfo("Total Number of Guests", "6 people",
                            Icons.people_outlined),
                        singleRowInfo(
                            "Event Title ", "Jazz", Icons.celebration_outlined),
                        singleRowInfo(
                            "Start Time ", "23:00 PM ", Icons.timer_sharp),
                        singleRowInfo(
                            "End Time", "03:00 AM", Icons.timer_off_outlined),
                        singleRowInfo("Date", "30/3/2023", Icons.date_range),
                      ].divide(const SizedBox(height: 10)),
                    ),
                    Divider(
                      thickness: 1,
                      color: customColors.secondary,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        singleRowInfo(
                            "Venue Name", "Em Sherif  ", Icons.place_outlined),
                        singleRowInfo(
                            "Dress Shop", "Mural", Icons.dry_cleaning_outlined),
                        singleRowInfo("Decoration", "Elanor", Icons.date_range),
                      ].divide(const SizedBox(height: 10)),
                    ),
                  ].divide(const SizedBox(height: 20)),
                ),
              ),
            ].divide(const SizedBox(height: 50)),
          ),
        ),
      ),
    );
  }

  Container statusElement() {
    return Container(
      width: 370,
      decoration: const BoxDecoration(),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          singleStatusWidget(
              isinThisStatus: true, title: "Pending", icon: Icons.pending),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: 70,
                child: Divider(
                  thickness: 1,
                  color: customColors.secondary,
                ),
              ),
            ],
          ),
          singleStatusWidget(
              isinThisStatus: false,
              title: "In Review",
              icon: Icons.preview_outlined),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: 70,
                child: Divider(
                  thickness: 1,
                  color: customColors.secondary,
                ),
              ),
            ],
          ),
          singleStatusWidget(
              isinThisStatus: false,
              title: "Contacted",
              icon: Icons.connect_without_contact_outlined),
        ],
      ),
    );
  }

  Container singleStatusWidget(
      {required bool isinThisStatus,
      required String title,
      required IconData icon}) {
    return Container(
      decoration: const BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Material(
            color: Colors.transparent,
            elevation: 5,
            shape: const CircleBorder(),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: customColors.secondaryBackground,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isinThisStatus
                    ? customColors.primary
                    : customColors.secondaryText,
                size: 25,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
            child: Text(
              title,
              style: customTextStyle.bodyMedium.override(
                fontFamily: 'Nunito',
                color: customColors.secondaryText,
                useGoogleFonts: true,
              ),
            ),
          ),
        ].addToStart(const SizedBox(height: 25)),
      ),
    );
  }

  Row singleRowInfo(String title, String subTitle, IconData icon) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(
              icon,
              color: customColors.secondaryText,
              size: 24,
            ),
            Text(
              title,
              style: customTextStyle.bodyMedium.override(
                fontFamily: 'Nunito',
                fontSize: 16,
                useGoogleFonts: true,
              ),
            ),
          ].divide(const SizedBox(width: 5)),
        ),
        Text(
          subTitle,
          style: customTextStyle.bodyLarge.override(
            fontFamily: 'Nunito',
            color: customColors.primary,
            fontSize: 14,
            useGoogleFonts: true,
          ),
        ),
      ],
    );
  }
}
