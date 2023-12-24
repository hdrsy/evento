import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/app_fonts_from_google.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';

class LinksSection extends StatelessWidget {
  const LinksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const LinkCard(
          icon: Icons.language_outlined,
          title: "http://www.linguini",
        ),
        const LinkCard(
          icon: Icons.facebook,
          title: "Spark Events",
        ),
        const LinkCard(
          icon: 'assets/images/Instagram.png',
          title: "@instagram",
        ),
        const LinkCard(
          icon: Icons.payment,
          title: "Deposit information",
          subTitle: """\$50 deposit per person is required to be 
paid in advance and will be deducted
from your check.""",
        ),
        const LinkCard(
          icon: Icons.refresh_outlined,
          title: "Refund policy",subTitle: "Refund until 1 day.",
        ),
        const LinkCard(
          icon: Icons.cancel_presentation_outlined,
          title: "Cancellation policy",subTitle: """Cancellation allowed until 4 hours.
before your booking.""",
        ),
      ].divide(const SizedBox(
        height: 16,
      )),
    );
  }
}

class LinkCard extends StatelessWidget {
  const LinkCard(
      {super.key, required this.icon, required this.title, this.subTitle});
  // ignore: prefer_typing_uninitialized_variables
  final icon;
  final String title;
  final String? subTitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            color: Color(0x0BD6D6D6),
            offset: Offset(0, 2),
          )
        ],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: customColors.secondary,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                  child: icon is String
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            icon,
                            width: 20,
                            height: 20,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Icon(
                          icon,
                          color: customColors.primary,
                          size: 20,
                        ),
                ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: customTextStyle.bodyMedium.copyWith(
                    fontSize: 14
                  ),
                ),
            subTitle!= null?    Text(
                  subTitle ?? "",
                  style: customTextStyle.bodyMedium.override(
                    fontFamily: primaryFontFamily,
                    fontSize: 12,
                    useGoogleFonts: true,
                  ),
                ):SizedBox(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
