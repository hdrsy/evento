import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/bottom_sheets/show_bottom_sheet.dart';
import 'package:evento/core/shared/widgets/text_fields/edit_profile_field.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/organizer/create_profile/controller/oganizer_create_profile_controller.dart';
import 'package:evento/features/organizer/create_profile/view/widgets/camera_icon.dart';
import 'package:evento/features/organizer/create_profile/view/widgets/create_folder.dart';
import 'package:evento/features/organizer/create_profile/view/widgets/folder_card.dart';
import 'package:evento/features/organizer/create_profile/view/widgets/profile_image.dart';
import 'package:evento/features/organizer/create_profile/view/widgets/selected_list.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Defining the OrganizerCreateProfileScreen as a StatelessWidget.
class OrganizerCreateProfileScreen extends StatelessWidget {
  OrganizerCreateProfileScreen({super.key});
  final OrganizerCreateProfileController organizerCreateProfileController =
      Get.put(OrganizerCreateProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.secondaryBackground,
      appBar: AppBar(
        backgroundColor: customColors.secondaryBackground,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      ///// cover image
                      image: AssetImage('assets/images/image.jpg'),
                      fit: BoxFit.cover)),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.2,
              child: Stack(children: [
                Align(
                  //// camera icon to change the cover image
                  alignment: const AlignmentDirectional(1, 1),
                  child: CameraIconCard(
                    onTap: () {},
                  ),
                ),
                const Align(
                    alignment: AlignmentDirectional(-0.8, 2),
                    child: ProfileImage())
              ]),
            ),
            SizedBox(
              height: screenHeight * 0.07,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
              child: Column(
                children: [
                  EditProfileField(
                    controller: TextEditingController(),
                    hintText: "Spark",
                    labelText: "Organization/Name",
                    onChanged: (value) {},
                    validator: (value) {
                      return null;
                    },
                    suffixIcon: Icons.reduce_capacity_outlined,
                  ),
                  EditProfileField(
                    controller: TextEditingController(),
                    hintText:
                        """Event organizer specialist in decoration ,lighting and flowers .
Wdding, Birthday ,anniversary......""",
                    labelText: "Bio",
                    onChanged: (value) {},
                    validator: (value) {
                      return null;
                    },
                    suffixIcon: Icons.description_outlined,
                  ),
                  EditProfileField(
                    controller: TextEditingController(),
                    hintText: """Decoration""",
                    labelText: "Services",
                    onChanged: (value) {},
                    validator: (value) {
                      return null;
                    },
                    suffixIcon: Icons.miscellaneous_services_outlined,
                  ),
                  SelectStates(
                      organizerCreateProfileController:
                          organizerCreateProfileController),
                  OrganizerMediaCard()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OrganizerMediaCard extends StatelessWidget {
  OrganizerMediaCard({
    super.key,
  });
  final OrganizerCreateProfileController organizerCreateProfileController =
      Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: const EdgeInsets.only(top: 12),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: customColors.primaryBackground, width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: const AlignmentDirectional(-1, -1),
                  child: Text(
                    "Create Profile",
                    style: customTextStyle.bodyMedium.override(
                      fontFamily: 'Nunito',
                      color: customColors.primary,
                      useGoogleFonts: true,
                    ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    showButtonSheet(
                        context: context, widget: CreateFolder(), height: 500);
                  },
                  child: const Icon(
                    Icons.add_circle_outline,
                    color: Color(0xFF757575),
                    size: 24,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                ...List.generate(//// for just show 3 item or less
                    organizerCreateProfileController.foldersModel.length > 3
                        ? 3
                        : organizerCreateProfileController.foldersModel.length,
                    (index) { 
                      
                      return 
                      (index==2 && organizerCreateProfileController.foldersModel.length>3)?  SeeAllFoldersCard()
                     : FolderCard(
                          folderName: organizerCreateProfileController
                              .foldersModel[index].folderName,
                        );})
              ].divide(const SizedBox(
                width: 10,
              )),
            )
          ].divide(
            const SizedBox(
              height: 10,
            ),
          ),
        ),
      ),
    );
  }
}

//// for select the state of organizer
class SelectStates extends StatelessWidget {
  const SelectStates({
    super.key,
    required this.organizerCreateProfileController,
  });

  final OrganizerCreateProfileController organizerCreateProfileController;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await showButtonSheet(
            context: context, widget: SelectState(), height: 300);
      },
      child: GetBuilder<OrganizerCreateProfileController>(builder: (ccontext) {
        return Container(
          width: double.infinity,
          height: scaleHeight(50),
          padding: padding(0, 10, 0, 10),
          decoration: BoxDecoration(
            border: Border.all(color: customColors.primaryBackground, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            // color: customColors.primaryBackground
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                organizerCreateProfileController.selectedState ??
                    " Covering Areas",
                style: customTextStyle.bodyMedium.override(
                  fontFamily: 'Nunito',
                  color: customColors.primary,
                  useGoogleFonts: true,
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: customColors.secondaryText,
                size: 15,
              )
            ],
          ),
        );
      }),
    );
  }
}
