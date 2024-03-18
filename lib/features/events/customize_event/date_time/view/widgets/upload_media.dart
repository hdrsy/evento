import 'package:evento/core/shared/widgets/bottom_sheets/show_bottom_sheet_for_images.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';
import 'package:image_picker/image_picker.dart';

import '../../controller/date_time_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class UploadMedia extends StatelessWidget {
  UploadMedia({super.key});
  final DateTimeController dateTimeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
      child: Container(
        width: 360,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: customColors.primaryBackground,
          ),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Upload Media",
                      textAlign: TextAlign.center,
                      style: customTextStyle.labelLarge.override(
                        fontFamily: 'Nunito',
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        useGoogleFonts: true,
                      ),
                    ).tr(),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                      child: GestureDetector(
                        onTap: () async {
                          showBottomSheetForImages(
                            context: context,
                            onPressCamera: () {
                              Get.back();
                              dateTimeController
                                  .pickNewMedia(ImageSource.camera);
                            },
                            onPressGallery: () async {
                              Get.back();
                              dateTimeController
                                  .pickNewMedia(ImageSource.gallery);
                            },
                          );
                        },
                        child: Icon(
                          Icons.add_a_photo_rounded,
                          color: customColors.secondaryText,
                          size: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    runSpacing: 20,
                    spacing: 20,
                    //  alignment: WrapAlignment.start,
                    //  crossAxisAlignment: WrapCrossAlignment.start,
                    runAlignment: WrapAlignment.start,
                    children: [
                      ...List.generate(
                        dateTimeController.media.length,
                        (index) => ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            dateTimeController.media[index],
                            width: 95,
                            height: 95,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
