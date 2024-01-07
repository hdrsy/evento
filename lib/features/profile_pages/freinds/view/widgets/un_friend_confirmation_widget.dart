import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/profile_pages/freinds/controller/freinds_cotroller.dart';
import 'package:evento/features/profile_pages/freinds/model/freinds_model.dart';
import 'package:evento/main.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnfriendConfirmationWidget extends StatelessWidget {
  const UnfriendConfirmationWidget({Key? key,required this.freindsModel, required this.modelId}) : super(key: key);
final FreindsModel freindsModel;
  final int modelId;
  @override
  Widget build(BuildContext context) {
   
    return Align(
      alignment: const AlignmentDirectional(0, 0),
      child: Container(
        width: 350,
        height: 250,
        decoration: BoxDecoration(
          color: customColors.secondaryBackground,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "Are you sure you want to unfriend ${freindsModel. firstName}?",
                    textAlign: TextAlign.center,
                    style: customTextStyle.headlineSmall,
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                    child: Text(
                      "Please remember that unfriending someone will remove them from your friend list, and you won't be able to see their private posts or interact as friends on this platform.",
                      textAlign: TextAlign.start,
                      style:customTextStyle.bodyMedium,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ButtonWidget(
                      onPressed: () async {
                        Get.offAndToNamed('/FreindsScreen');
                        
                      },
                      text: " Cancel",
                      options: ButtonOptions(
                        width: 150,
                        height: 45,
                        padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                        iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        color: customColors.secondaryBackground,
                        textStyle: customTextStyle
                            .titleSmall
                            .override(
                              fontFamily: 'Nunito',
                              color: customColors.primaryText,
                              fontSize: 14,
                              useGoogleFonts: true,
                            ),
                        elevation: 0,
                        borderSide: BorderSide(
                          color: customColors.primaryBackground,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      showLoadingIndicator: false,
                    ),
                    ButtonWidget(
                      onPressed: () async {
                      final  FreindsController freindsController=Get.find();
                      freindsController.unFreindRequest(freindsModel.id, modelId);
                        
                      },
                      text:  "Unfriend",
                      options: ButtonOptions(
                        width: 150,
                        height: 45,
                        padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                        iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        color: customColors.rejected,
                        textStyle:
                            customTextStyle.titleSmall.override(
                                  fontFamily: 'Nunito',
                                  color: customColors.info,
                                  fontSize: 14,
                                  useGoogleFonts: true,
                                ),
                        elevation: 0,
                        borderSide: BorderSide(
                          color: customColors.rejected,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      showLoadingIndicator: false,
                    ),
                  ],
                ),
              ),
            ].divide(const SizedBox(height: 8)),
          ),
        ),
      ),
    );
  }
}
