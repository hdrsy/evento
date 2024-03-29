import 'package:evento/core/shared/widgets/images/network_image.dart';

import '../../../../../core/shared/widgets/bottom_sheets/show_bottom_sheet_for_images.dart';
import '../../../create_profile/view/widgets/camera_icon.dart';
import '../../controller/edit_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditImageWidgetOrganizer extends StatelessWidget {
  EditImageWidgetOrganizer({super.key});
  final EditProfileOrganizerController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileOrganizerController>(builder: (ccontext) {
      return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                ///// cover image
                image: controller.profileModel.cover != null &&
                        !controller.isCoverSelected.value
                    ? getImageNetwork(
                            url: "/storage/${controller.profileModel.cover}",
                            width: double.infinity,
                            height: null)
                        .image
                    : controller.coverImage != null
                        ? FileImage(controller.coverImage!)
                            as ImageProvider<Object>
                        : const AssetImage('assets/images/image.jpg'),
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
              alignment: const AlignmentDirectional(-0.8, 2),
              child: GestureDetector(
                onTap: () {
                  showBottomSheetForImages(
                      context: context,
                      onPressCamera: () {
                        controller.pickImageForDashbard(
                            ImageSource.camera, true);
                      },
                      onPressGallery: () async {
                        controller.pickImageForDashbard(
                            ImageSource.gallery, true);
                      });
                },
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width * 0.3,
                      height: MediaQuery.sizeOf(context).width * 0.3,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: controller.profileModel.profile != null &&
                              !controller.isProfileSelected.value
                          ? getImageNetwork(
                              url:
                                  "/storage/${controller.profileModel.profile}",
                              width: null,
                              height: null)
                          : controller.profileImage != null
                              ? Image.file(
                                  controller.profileImage!,
                                  alignment: const Alignment(0, 0),
                                )
                              : Image.asset(
                                  'assets/images/faceBookProfile.jfif',
                                  // fit: BoxFit.,
                                  alignment: const Alignment(0, 0),
                                ),
                    ),
                    Positioned(
                      //// camera icon to change the profile image
                      right: -1,
                      bottom: -0.5,
                      child: CameraIconCard(
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              )),
        ]),
      );
    });
  }
}
