import 'package:evento/features/organizer/event_request_status_for_organizer/controller/event_request_status_for_organizer_controller.dart';
import 'package:evento/features/organizer/my_events_for_organizer/model/my_events_for_organizer_model.dart';

import '../../../../core/utils/helper/date_formatter.dart';
import '../../../../core/utils/helper/flutter_flow_util.dart';
import '../../../../core/utils/theme/text_theme.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class EventRequestStatusForOrganizerScreen extends StatelessWidget {
  EventRequestStatusForOrganizerScreen({super.key});
  final EventRequestStatusForOrganizerController requestStatusController =
      Get.put(EventRequestStatusForOrganizerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: customColors.secondaryBackground,
        appBar: AppBar(
          backgroundColor: customColors.secondaryBackground,
          title: Text("Status",
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
        body: _buildBody());
  }

  _buildBody() {
    final EventRequestStatusForOrganizerController requestStatusController =
        Get.find();
    final MyEventsForOrganizerModel myRequestModel =
        requestStatusController.myRequestModel;
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              statusElement(myRequestModel.status),
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
                            tr("Full Name"),
                            "${myRequestModel.firstName} ${myRequestModel.lastName}",
                            Icons.person_outline),
                        singleRowInfo(tr("Phone Number"),
                            myRequestModel.phoneNumber, Icons.phone_outlined),
                        singleRowInfo(
                            tr("Number of Adults"),
                            myRequestModel.adults.toString(),
                            Icons.people_outlined),
                        singleRowInfo(
                            tr("Number of Children"),
                            myRequestModel.child.toString(),
                            Icons.people_outlined),
                        singleRowInfo(tr("Event Title "), myRequestModel.title,
                            Icons.celebration_outlined),
                        singleRowInfo(tr("Start Time "),
                            myRequestModel.startTime, Icons.timer_sharp),
                        singleRowInfo(tr("End Time"), myRequestModel.endTime,
                            Icons.timer_off_outlined),
                        singleRowInfo(
                            tr("Date"),
                            DateFormatter.formatDate(myRequestModel.date),
                            Icons.date_range),
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
                        singleRowInfo(tr("Venue Name"),
                            myRequestModel.venue.name, Icons.place_outlined),
                        ...List.generate(
                            myRequestModel.serviceProviders.length,
                            (index) => singleRowInfo(
                                myRequestModel
                                    .serviceProviders[index].categoryTitle,
                                "${myRequestModel.serviceProviders[index].firstName} ${myRequestModel.serviceProviders[index].lastName}",
                                Icons.dry_cleaning_outlined))
                      ].divide(const SizedBox(height: 10)),
                    ),
                    Divider(
                      thickness: 1,
                      color: customColors.secondary,
                    ),
                    myRequestModel.description != null
                        ? notesAndDescription(
                            icon: Icons.description_outlined,
                            title: "Description",
                            subTitle: myRequestModel.description!)
                        : const SizedBox(),
                    myRequestModel.additionalNotes != null
                        ? notesAndDescription(
                            icon: Icons.speaker_notes_outlined,
                            title: "Notes",
                            subTitle: myRequestModel.additionalNotes!)
                        : const SizedBox(),
                  ].divide(const SizedBox(height: 20)),
                ),
              ),
            ].divide(const SizedBox(height: 50)),
          ),
        ),
      ),
    );
  }

  Widget notesAndDescription(
      {required IconData icon,
      required String title,
      required String subTitle}) {
    return Column(
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
          "- $subTitle",
          style: customTextStyle.bodyMedium.override(
            fontFamily: 'Nunito',
            fontSize: 16,
            color: customColors.primary,
            useGoogleFonts: true,
          ),
        )
      ],
    );
  }

  Container statusElement(String status) {
    return Container(
      width: 370,
      decoration: const BoxDecoration(),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          singleStatusWidget(
              isinThisStatus: status == "Pending",
              title: tr("Pending"),
              icon: Icons.pending),
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
              isinThisStatus: status == "In Progress",
              title: tr("In Review"),
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
              isinThisStatus: status == "Approved",
              title: tr("Contacted"),
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
