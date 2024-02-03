// Defining the OrganizerCreateProfileScreen as a StatelessWidget.
import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/bottom_sheets/show_bottom_sheet.dart';
import 'package:evento/core/shared/widgets/bottom_sheets/show_bottom_sheet_for_images.dart';
import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/shared/widgets/text_fields/edit_profile_field.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/profile_pages/account_type_inner_screens/switch_to_service_provider/view/anther_screens/choice_service_type/view/widget/service_provider_account_widget.dart';
import 'package:evento/features/service_provider/service_provider_create_profile/view/widgets/camera_icon.dart';
import 'package:evento/features/service_provider/service_provider_create_profile/view/widgets/create_folder.dart';
import 'package:evento/features/service_provider/service_provider_create_profile/view/widgets/folder_card.dart';
import 'package:evento/features/service_provider/service_provider_create_profile/view/widgets/profile_image.dart';
import 'package:evento/features/service_provider/service_provider_create_profile/view/widgets/selected_list.dart';
import 'package:evento/features/service_provider/set_location_on_maps/view/set_location_on_maps_screen_for_service_provider.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controller/service_provider_create_profile_controller.dart';
import 'package:easy_localization/easy_localization.dart';

class ServiceProviderCreateProfileScreen extends StatelessWidget {
  ServiceProviderCreateProfileScreen({super.key});
  final ServiceProviderCreateProfileController
      serviceProviderCreateProfileController =
      Get.put(ServiceProviderCreateProfileController());
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
      body: GetBuilder<ServiceProviderCreateProfileController>(
          builder: (controller) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        ///// cover image
                        image: controller.coverImage != null
                            ? FileImage(controller.coverImage!)
                                as ImageProvider<Object>
                            : const AssetImage('assets/images/image.jpg')
                                as ImageProvider<Object>,
                        fit: BoxFit.cover)),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.2,
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
                  Align(
                      alignment: AlignmentDirectional(-0.8, 2),
                      child: ProfileImagesServiceProvider()),
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
                      labelText: tr("ServiceProviderName"),
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
                      labelText: tr("Bio"),
                      onChanged: (value) {},
                      validator: (value) {
                        return null;
                      },
                      suffixIcon: Icons.description_outlined,
                    ),
                    EditProfileField(
                      controller: controller.description,
                      hintText: tr(
                          """Event organizer specialist in decoration ,lighting and flowers .
Wdding, Birthday ,anniversary......"""),
                      labelText: tr("Description"),
                      onChanged: (value) {},
                      validator: (value) {
                        return null;
                      },
                      suffixIcon: Icons.description_outlined,
                    ),

                    SelectStates(
                        serviceProviderCreateProfileController:
                            serviceProviderCreateProfileController),
                    GestureDetector(
                      onTap: () {
                        Get.to(LocationPickerScreen());
                      },
                      child: GetBuilder<ServiceProviderCreateProfileController>(
                          builder: (context) {
                        return Container(
                          width: double.infinity,
                          height: scaleHeight(50),
                          margin: EdgeInsets.only(top: 12),
                          padding: padding(0, 10, 0, 10),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: customColors.primaryBackground,
                                width: 2),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30)),
                            // color: customColors.primaryBackground
                          ),
                          child: Text(
                            serviceProviderCreateProfileController
                                        .locationData ==
                                    null
                                ? "Location"
                                : "${serviceProviderCreateProfileController.locationData!.latitude}, ${serviceProviderCreateProfileController.locationData!.longitude}",
                            style: customTextStyle.bodyMedium.override(
                              fontFamily: 'Nunito',
                              color: customColors.primary,
                              useGoogleFonts: true,
                            ),
                          ).tr(),
                        );
                      }),
                    ),

                    OrganizerMediaCard(),
                    const SizedBox(
                      height: 50,
                    ),
                    // Generated code for this Button Widget...
                    ButtonWidget(
                      showLoadingIndicator:
                          serviceProviderCreateProfileController
                              .isLoading.value,
                      onPressed: () async {
                        showButtonSheet(
                            context: context,
                            widget: ServiceProviderAccounWidget(),
                            height: MediaQuery.sizeOf(context).height * 0.6);
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
  final ServiceProviderCreateProfileController
      organizerCreateProfileController = Get.find();

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
                    tr("Create Profile"),
                    style: customTextStyle.bodyMedium.override(
                      fontFamily: 'Nunito',
                      color: customColors.primary,
                      useGoogleFonts: true,
                    ),
                  ),
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
class SelectStates extends StatelessWidget {
  const SelectStates({
    super.key,
    required this.serviceProviderCreateProfileController,
  });

  final ServiceProviderCreateProfileController
      serviceProviderCreateProfileController;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await showButtonSheet(
            context: context, widget: SelectState(), height: 300);
      },
      child: GetBuilder<ServiceProviderCreateProfileController>(
          builder: (ccontext) {
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
                serviceProviderCreateProfileController.selectedState ??
                    " Covering Areas",
                style: customTextStyle.bodyMedium.override(
                  fontFamily: 'Nunito',
                  color: customColors.primary,
                  useGoogleFonts: true,
                ),
              ).tr(),
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
