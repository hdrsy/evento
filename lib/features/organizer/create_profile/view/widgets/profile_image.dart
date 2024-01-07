import 'package:evento/core/shared/widgets/bottom_sheets/show_bottom_sheet_for_images.dart';
import 'package:evento/features/organizer/create_profile/controller/oganizer_create_profile_controller.dart';
import 'package:evento/features/organizer/create_profile/view/widgets/camera_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrganizerCreateProfileController>(
      builder: (controller) {
        return SizedBox(
          width:  MediaQuery.sizeOf(context).width * 0.25,
          child: Stack(
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width * 0.2,
                height: MediaQuery.sizeOf(context).width * 0.2,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: controller.profileImage!=null?Image.file(controller.profileImage!,alignment: const Alignment(0, 0) ,):
                Image.asset(
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
                  onTap: () {
                    print("object");
                     showBottomSheetForImages(
                  context: context,
                  onPressCamera: () {
                    controller.pickImageForDashbard(ImageSource.camera,true);
                  },
                  onPressGallery: () async {
                    controller.pickImageForDashbard(ImageSource.gallery,true);
                  });
                  },
                ),  
              ),
            ],
          ),
        );
      }
    );
  }
}
