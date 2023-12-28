import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/shared/widgets/text_fields/search_filed.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/app_fonts_from_google.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InviteFreindsToEventScreen extends StatelessWidget {
  const InviteFreindsToEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.secondaryBackground,
      appBar: AppBar(
        backgroundColor: customColors.secondaryBackground,
        title: Text("Invite",
            style: customTextStyle.bodyMedium
                .copyWith(color: customColors.primary, fontSize: 20)),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_rounded,
            color: customColors.primaryText,
            size: 30,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          children: [
            searchTextField(onChanged: (c) {}),
            ...List.generate(4, (index) =>InviteFreindsCard())
          ].divide(SizedBox(height: 10,)),
        ),
      ),
    );
  }
}

class InviteFreindsCard extends StatelessWidget {
  const InviteFreindsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 1),
        child: Container(
          width: screenHeight * 0.15,
          decoration: BoxDecoration(
            color: customColors.secondaryBackground,
          ),
          child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=900&q=60',
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 12,),
                  Text(
                    "Maysam ",
                    style: customTextStyle.bodyLarge.override(
                      fontSize: 16,
                      fontFamily: secondaryFontFamily,
                      useGoogleFonts: true
                    ),
                  ),
                  Spacer(),
                  ButtonWidget(
                    onPressed: () {},
                    text: "Invite",
                    options: ButtonOptions(
                      width: 100,
                      height: 21,
                      iconPadding:
                          const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      color: customColors.primary,
                      textStyle: customTextStyle.titleSmall.override(
                        fontFamily: 'Nunito',
                        color: customColors.info,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        useGoogleFonts: true,
                      ),
                      borderSide: BorderSide(
                        color: customColors.primary,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
