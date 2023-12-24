import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return // Generated code for this Column Widget...
        Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(12, 20, 12, 12),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          contactWidget(
              context, "Customer Service", Icons.miscellaneous_services_sharp),
          contactWidget(context, "WhatsApp", 'assets/images/WhatsApp.png'),
          contactWidget(context, "Website", Icons.language_sharp),
          contactWidget(context, "Facebook", Icons.facebook),
          contactWidget(context, "Twitter", 'assets/images/Twitter_Circled.png'),
          contactWidget(context, "Instagram", 'assets/images/Instagram.png'),
        ].divide(const SizedBox(height: 20)),
      ),
    );
  }

  Row contactWidget(BuildContext context, String title, var icon) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: customColors.primaryBackground,
              ),
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  icon is IconData
                      ? Icon(
                          icon,
                          color: customColors.primary,
                          size: 20,
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            icon,
                            width: 20,
                            height: 20,
                            fit: BoxFit.cover,
                          ),
                        ),
                  Text(
                    title,
                    style: customTextStyle.displaySmall.override(
                      fontFamily: 'Nunito',
                      color: customColors.primaryText,
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      useGoogleFonts: true,
                    ),
                  ),
                ].divide(const SizedBox(width: 5)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
