import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class EditFolderNameFolder extends StatelessWidget {
  const EditFolderNameFolder(
      {super.key, this.onPressDone, required this.folderName});
  final Function(String newFolderName)? onPressDone;
  final TextEditingController folderName;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const AlignmentDirectional(0, 0),
      child: Container(
        width: 300,
        // height: 250,
        decoration: BoxDecoration(
          color: customColors.secondaryBackground,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: const AlignmentDirectional(-1, -1),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                    child: Text(
                      "Edit Folder Name",
                      style: customTextStyle.headlineMedium.override(
                        fontFamily: 'Nunito',
                        color: customColors.primaryText,
                        useGoogleFonts: true,
                      ),
                    ).tr(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: TextFormField(
                      controller: folderName,
                      // focusNode: _model.textFieldFocusNode,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelStyle: customTextStyle.labelMedium,
                        hintText: tr(" Folder name"),
                        hintStyle: customTextStyle.labelMedium.override(
                          fontFamily: 'Nunito',
                          color: customColors.secondaryText,
                          useGoogleFonts: true,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: customColors.primaryBackground,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: customColors.primary,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: customColors.error,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: customColors.error,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      style: customTextStyle.bodyMedium,
                      validator: (value) {
                        if (value!.length < 2) {
                          return tr("The folder name should at least 2 char");
                        }
                        return null;
                      }),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ButtonWidget(
                        onPressed: () async {
                          Get.back();
                        },
                        text: tr("Cancel"),
                        options: ButtonOptions(
                          width: 100,
                          height: 45,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20, 0, 20, 0),
                          iconPadding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: customColors.secondaryBackground,
                          textStyle: customTextStyle.titleSmall.override(
                            fontFamily: 'Nunito',
                            color: customColors.primaryText,
                            fontSize: 14,
                            useGoogleFonts: false,
                          ),
                          elevation: 0,
                          borderSide: BorderSide(
                            color: customColors.primary,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        showLoadingIndicator: false,
                      ),
                      ButtonWidget(
                        onPressed: () {
                          onPressDone!(folderName.text);
                          Get.back();
                        },
                        text: tr("Done"),
                        options: ButtonOptions(
                          width: 100,
                          height: 45,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20, 0, 20, 0),
                          iconPadding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: customColors.primary,
                          textStyle: customTextStyle.titleSmall.override(
                            fontFamily: 'Nunito',
                            color: customColors.info,
                            fontSize: 14,
                            useGoogleFonts: true,
                          ),
                          elevation: 0,
                          borderSide: BorderSide(
                            color: customColors.primary,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        showLoadingIndicator: false,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
