import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class AdditionalNote extends StatelessWidget {
  const AdditionalNote(
      {super.key, required this.controller, required this.onChange});
  final TextEditingController controller;
  final Function(String) onChange;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 11,
        ),
        Text(
          "Additional Notes",
          style: customTextStyle.headlineMedium.override(
              fontSize: 22, fontWeight: FontWeight.w500, fontFamily: "Nunito"),
        ).tr(),
        Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: customColors.secondaryBackground,
            boxShadow: const [
              BoxShadow(
                blurRadius: 4,
                color: Color(0x33000000),
                offset: Offset(0, 2),
              )
            ],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: customColors.primaryBackground,
            ),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
            child: TextFormField(
              controller: controller,
              onChanged: onChange,
              obscureText: false,
              decoration: InputDecoration(
                labelText: tr("Label here..."),
                labelStyle: customTextStyle.labelMedium,
                hintStyle: customTextStyle.labelMedium,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              ),
              style: customTextStyle.bodyMedium,
            ),
          ),
        )
      ].divide(const SizedBox(
        height: 10,
      )),
    );
  }
}
