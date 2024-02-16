import 'package:evento/core/const/states.dart';
import 'package:evento/core/utils/helper/flutter_flow_drop_down.dart';
import 'package:evento/core/utils/helper/form_field_controller.dart';
import 'package:evento/core/utils/helper/multy_selected_dropdown.dart';
import 'package:evento/features/profile_pages/account_type_inner_screens/becom_an_organizer/choice_oganizer_category/view/widget/confirm_switch_to_organizer_account_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/responsive/responsive.dart';
import '../../../../core/shared/widgets/bottom_sheets/show_bottom_sheet.dart';
import '../../../../core/shared/widgets/bottom_sheets/show_bottom_sheet_for_images.dart';
import '../../../../core/shared/widgets/buttons/general_button.dart';
import '../../../../core/shared/widgets/text_fields/edit_profile_field.dart';
import '../../../../core/utils/helper/flutter_flow_util.dart';
import '../../../../core/utils/theme/text_theme.dart';
import '../controller/oganizer_create_profile_controller.dart';
import 'widgets/camera_icon.dart';
import 'widgets/create_folder.dart';
import 'widgets/folder_card.dart';
import 'widgets/profile_image.dart';
import 'widgets/selected_list.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:easy_localization/easy_localization.dart';

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
        leading: GestureDetector(
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
      body: GetBuilder<OrganizerCreateProfileController>(builder: (controller) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        ///// cover image
                        image: controller.coverImage != null
                            ? FileImage(controller.coverImage!)
                            : const AssetImage('assets/images/image.jpg')
                                as ImageProvider<Object>,
                        fit: BoxFit.cover)),
                child: Stack(children: [
                  Align(
                    //// camera icon to change the cover image
                    alignment: const AlignmentDirectional(1, 1),
                    child: CameraIconCard(
                      onTap: () {
                        showBottomSheetForImages(
                            context: context,
                            onPressCamera: () {
                              controller.pickImageForDashbard(
                                  ImageSource.camera, false);
                            },
                            onPressGallery: () async {
                              controller.pickImageForDashbard(
                                  ImageSource.gallery, false);
                            });
                      },
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                child: Column(
                  children: [
                    EditProfileField(
                      controller: controller.organizerName,
                      hintText: tr("Spark"),
                      labelText: tr("Organization/Name"),
                      onChanged: (value) {},
                      validator: (value) {
                        return null;
                      },
                      suffixIcon: Icons.reduce_capacity_outlined,
                    ),
                    EditProfileField(
                      controller: controller.bio,
                      hintText: tr(
                          """Event organizer specialist in decoration ,lighting and flowers .
Wdding, Birthday ,anniversary......"""),
                      labelText: "Bio",
                      onChanged: (value) {},
                      validator: (value) {
                        return null;
                      },
                      suffixIcon: Icons.description_outlined,
                    ),
                    SelectStates(
                        organizerCreateProfileController:
                            organizerCreateProfileController),
                    OrganizerMediaCard(),
                    const SizedBox(
                      height: 50,
                    ),
                    Obx(
                      () => Column(
                        children: [
                          LinearProgressIndicator(
                            value: controller.uploadProgress.value,
                            backgroundColor: customColors.secondaryBackground,
                            color: customColors.primary,
                          ),
                          Text(controller.currentUploadingFile.value),
                        ],
                      ),
                    ),
                    ButtonWidget(
                      showLoadingIndicator: false,
                      onPressed: () {
                        showButtonSheet(
                            context: context,
                            widget: SwitchToOrganizerAccounWidget(),
                            height: MediaQuery.of(context).size.height * 0.6);
                      },
                      text: tr("Done"),
                      options: ButtonOptions(
                        width: screenWidth * 0.3,
                        height: 40,
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(32, 0, 32, 0),
                        iconPadding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        color: customColors.primary,
                        textStyle: customTextStyle.titleSmall.override(
                          fontFamily: 'Nunito',
                          color: Colors.white,
                          useGoogleFonts: true,
                        ),
                        elevation: 3,
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      }),
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
                  ).tr(),
                ),
                GestureDetector(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...List.generate(
                    //// for just show 3 item or less
                    organizerCreateProfileController.foldersModel.length > 3
                        ? 3
                        : organizerCreateProfileController.foldersModel.length,
                    (index) {
                  return (index == 2 &&
                          organizerCreateProfileController.foldersModel.length >
                              3)
                      ? SeeAllFoldersCard()
                      : FolderCard(
                          folder: organizerCreateProfileController
                              .foldersModel[index],
                          folderIndex: index,
                        );
                })
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
// class SelectStates extends StatelessWidget {
//   const SelectStates({
//     super.key,
//     required this.organizerCreateProfileController,
//   });

//   final OrganizerCreateProfileController organizerCreateProfileController;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () async {
//         await showButtonSheet(
//             context: context, widget: SelectState(), height: 300);
//       },
//       child: GetBuilder<OrganizerCreateProfileController>(builder: (ccontext) {
//         return Container(
//           width: double.infinity,
//           height: scaleHeight(50),
//           padding: padding(0, 10, 0, 10),
//           decoration: BoxDecoration(
//             border: Border.all(color: customColors.primaryBackground, width: 2),
//             borderRadius: const BorderRadius.all(Radius.circular(30)),
//             // color: customColors.primaryBackground
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text(
//                 organizerCreateProfileController.selectedState ??
//                     "Covering Areas",
//                 style: customTextStyle.bodyMedium.override(
//                   fontFamily: 'Nunito',
//                   color: customColors.primary,
//                   useGoogleFonts: true,
//                 ),
//               ).tr(),
//               Icon(
//                 Icons.keyboard_arrow_down_rounded,
//                 color: customColors.secondaryText,
//                 size: 15,
//               )
//             ],
//           ),
//         );
//       }),
//     );
//   }
// }

class SelectStates extends StatefulWidget {
  const SelectStates(
      {super.key, required this.organizerCreateProfileController});
  final OrganizerCreateProfileController organizerCreateProfileController;

  @override
  State<SelectStates> createState() => _SelectStates();
}

class _SelectStates extends State<SelectStates> {
  late FormFieldController<String>? dropDownValueController;
  @override
  initState() {
    super.initState();
    dropDownValueController = FormFieldController(null);
  }

  List<String> selectedOptions = [];

  @override
  Widget build(BuildContext context) {
    return MultiSelectDropDown(
      options: states,
      selectedValues: selectedOptions,
      onSelectionChanged: (newSelection) {
        setState(() {
          selectedOptions = newSelection;
        });
      },
    );
  }
}
