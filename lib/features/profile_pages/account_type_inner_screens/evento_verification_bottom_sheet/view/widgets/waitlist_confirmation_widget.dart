import '../../../../../../core/shared/widgets/buttons/general_button.dart';
import '../../../../../../core/utils/theme/text_theme.dart';
import '../../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
class WaitlistConfirmationWidget extends StatelessWidget {
  const WaitlistConfirmationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0, 0),
      child: Container(
        width: 350,
        height: 200,
        decoration: BoxDecoration(
          color: customColors.secondaryBackground,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "You're on the waitlist",
                    textAlign: TextAlign.center,
                    style: customTextStyle.headlineSmall,
                  ).tr(),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                    child: Text(
                     "Thank you for your interest. We'll send you a notification when Meta Verified is available to you. Notifications may be sent via email or appear in your Facebook or Instagram app. Learn more",
                      textAlign: TextAlign.start,
                      style: customTextStyle.bodyMedium,
                    ).tr(),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ButtonWidget(
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      text:tr(  "Ok"),
                      options: ButtonOptions(
                        width: 250,
                        height: 45,
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                        iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        color: customColors.primary,
                        textStyle:
                            customTextStyle.titleSmall.override(
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
    );
  }
}