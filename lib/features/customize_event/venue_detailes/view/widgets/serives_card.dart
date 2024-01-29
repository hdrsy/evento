import '../../../../../core/shared/widgets/images/network_image.dart';
import '../../../../../core/utils/theme/text_theme.dart';
import '../../../venue/model/venue_model.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VenueServicesCard extends StatelessWidget {
  const VenueServicesCard({super.key, required this.album});
  final VenueAlbum album;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Get.toNamed('/GalleryScreen',
            arguments: {"images": album.images, "videos": album.videos});
      },
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          alignment: const AlignmentDirectional(0, 0),
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: getImageNetwork(
                    url: "/storage/${album.images[0]}",
                    width: 340,
                    height: 200)),
            Opacity(
              opacity: 0.4,
              child: Align(
                alignment: const AlignmentDirectional(0.11, 0.00),
                child: Container(
                  width: 342,
                  height: 200,
                  decoration: BoxDecoration(
                    color: customColors.secondaryBackground,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0.01, -0.04),
              child: Text(
                album.name,
                style: customTextStyle.bodyMedium.override(
                  fontFamily: 'Nunito',
                  color: customColors.primaryText,
                  fontSize: 30,
                  useGoogleFonts: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
