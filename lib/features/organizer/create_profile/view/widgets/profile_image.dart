import 'package:evento/features/organizer/create_profile/view/widgets/camera_icon.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
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
            child: Image.asset(
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
    );
  }
}
