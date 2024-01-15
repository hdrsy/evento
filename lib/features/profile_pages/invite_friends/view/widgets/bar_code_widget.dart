import 'package:barcode_widget/barcode_widget.dart';
import '../../../../../core/shared/widgets/buttons/general_button.dart';
import '../../../../../core/utils/helper/flutter_flow_util.dart';
import '../../../../../core/utils/theme/text_theme.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
class BarCodeWidget extends StatelessWidget {
  const BarCodeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
    
        Align(
          alignment: const AlignmentDirectional(-1.00, -1.00),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
            child: Text(
              "Invite friends and get discount code",
              style: customTextStyle.bodyMedium.override(
                fontFamily: 'Roboto',
                color: customColors.primaryText,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ).tr(),
          ),
        ),
    
        BarcodeWidget(
          data: 'Barcode',
          barcode: Barcode.qrCode(),
          width: 500,
          height: 200,
          color: customColors.primaryText,
          backgroundColor: Colors.transparent,
          errorBuilder: (context, error) =>const SizedBox(
            width: 300,
            height: 90,
          ),
          drawText: false,
        ),
        
    Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
    child: RichText(
    textScaleFactor: MediaQuery.of(context).textScaleFactor,
    text: TextSpan(
      children: [
        TextSpan(
          text:tr(  "Special invitation code"),
          style: customTextStyle.bodyMedium.override(
                fontFamily: 'Nunito',
                color:customColors.primaryText,
                fontWeight: FontWeight.bold,
                useGoogleFonts: true,
              ),
        ),
        TextSpan(
          text:tr(   "DNdeeYR"),
          style: TextStyle(
            color:customColors.primary,
          ),
        )
      ],
      style: customTextStyle.bodyMedium,
    ),
    ),
    ),
    
    buttons()
    
    
      ].divide(const SizedBox(height: 30,)),
    );
  }

  Padding buttons() {
    return Padding(
padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 40),
child: Row(
  mainAxisSize: MainAxisSize.max,
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    ButtonWidget(
      onPressed: () {
        
      },
      text:tr(  "Copy code"),
      icon: const Icon(
        Icons.content_copy,
        size: 15,
      ),
      options: ButtonOptions(
        height: 40,
        padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 32, 0),
        iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        color:customColors.primary,
        textStyle: customTextStyle.titleSmall.override(
              fontFamily: 'Nunito',
              color: Colors.white,
              useGoogleFonts: false,
            ),
        elevation: 3,
        borderSide: const BorderSide(
          color: Colors.transparent,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    ButtonWidget(
      onPressed: () {
       },
      text: '',
      icon: Icon(
        Icons.share_rounded,
        color:customColors.primary,
        size: 15,
      ),
      options: ButtonOptions(
        height: 40,
        padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
        iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        color:customColors.secondaryBackground,
        textStyle: customTextStyle.titleSmall.override(
              fontFamily: 'Nunito',
              color: Colors.white,
              useGoogleFonts: true,
            ),
        elevation: 3,
        borderSide: BorderSide(
          color:customColors.primary,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ].divide(const SizedBox(width: 20)),
),
);
  }
}
