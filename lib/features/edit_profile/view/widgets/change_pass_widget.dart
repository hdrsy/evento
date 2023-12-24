import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/shared/widgets/text_fields/edit_profile_field.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangpassWidget extends StatelessWidget {
  const ChangpassWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: padding(0, 24,0,24),
        decoration: BoxDecoration(
          color: customColors.secondaryBackground,
          boxShadow: const [
            BoxShadow(
              blurRadius: 6,
              color: Color(0x35000000),
              offset: Offset(0, -2),
            )
          ],
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              EditProfileField(
                  controller: TextEditingController(),
                  hintText: "",
                  labelText: "Current pssword",
                  onChanged: (value) {
                    // editProfileController.gender.text=value;
                  },
                  validator: (value) {
                    return null;
                  }),
              EditProfileField(
                  controller: TextEditingController(),
                  hintText: "",
                  labelText: "New pssword",
                  onChanged: (value) {
                    // editProfileController.gender.text=value;
                  },
                  validator: (value) {
                    return null;
                  }),
              EditProfileField(
                  controller: TextEditingController(),
                  hintText: "",
                  labelText: "Confirm pssword",
                  onChanged: (value) {
                    // editProfileController.gender.text=value;
                  },
                  validator: (value) {
                    return null;
                  }),
              ButtonWidget(
                onPressed: () {
                  Get.back();
                },
                text: "Save",
                options: ButtonOptions(
                  height: 40,
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                  iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
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
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ]
                .divide(const SizedBox(height: 5))
                .addToStart(const SizedBox(height: 20)),
          ),
        ),
      ),
    );
  }
}
