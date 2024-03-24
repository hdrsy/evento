import 'package:easy_localization/easy_localization.dart';
import 'package:evento/core/colors/app_colors.dart';
import 'package:evento/core/shared/functions/open_link.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/utils/helper/flutter_flow_util.dart';
import '../../../../../core/utils/theme/text_theme.dart';
import '../../../../../main.dart';
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
          contactWidget(context, "Customer Service",
              Icons.miscellaneous_services_sharp, "0996366666"),
          contactWidget(context, "WhatsApp", 'assets/images/WhatsApp.png',
              "https://www.hdragency.com/"),
          contactWidget(context, "Website", Icons.language_sharp,
              "https://www.hdragency.com/"),
          contactWidget(context, "Facebook", Icons.facebook,
              "https://www.hdragency.com/"),
          contactWidget(context, "Twitter", 'assets/images/Twitter_Circled.png',
              "https://www.hdragency.com/"),
          contactWidget(context, "Instagram", 'assets/images/Instagram.png',
              "https://www.hdragency.com/"),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  tr("powered by "),
                  style: customTextStyle.bodyMedium
                      .copyWith(fontSize: 16, color: customColors.primaryText),
                ),
                GestureDetector(
                    onTap: () {
                      _launchURL();
                    },
                    child: Text(
                      'HDR',
                      style: customTextStyle.bodyMedium
                          .copyWith(fontSize: 16, color: customColors.primary),
                    ))
              ],
            ),
          )
        ].divide(const SizedBox(height: 20)),
      ),
    );
  }

  void _launchURL() async {
    final Uri _url = Uri.parse('https://www.hdragency.com/');

    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  Widget contactWidget(
      BuildContext context, String title, var icon, String link) {
    return GestureDetector(
      onTap: () async {
        title == "Customer Service"
            ? await launchDialer(link)
            : await openLink(link);
      },
      child: Row(
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
                            color: AppColors.lightPrimary,
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
                    SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      // width: double. ,
                      child: Text(
                        title,
                        style: customTextStyle.displaySmall.override(
                          fontFamily: 'Nunito',
                          color: customColors.primaryText,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          useGoogleFonts: true,
                        ),
                      ).tr(),
                    ),
                  ].divide(const SizedBox(width: 5)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> launchDialer(String phoneNumber) async {
  final Uri dialUri = Uri(scheme: 'tel', path: phoneNumber);
  if (await canLaunchUrl(dialUri)) {
    await launchUrl(dialUri);
  } else {
    throw 'Could not launch $dialUri';
  }
}
