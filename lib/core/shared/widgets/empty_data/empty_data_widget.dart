import 'package:easy_localization/easy_localization.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class EmptyData extends StatelessWidget {
  EmptyData({super.key, required this.icon, required this.message, this.onTap});
  final IconData icon;
  final String message;
  Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: onTap,
              child: Icon(
                icon,
                color: customColors.primary,
                size: 60,
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0, 0),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  tr(message),
                  textAlign: TextAlign.center,
                  style: customTextStyle.bodyMedium.override(
                    fontFamily: 'Nunito',
                    color: customColors.primary,
                    fontSize: 18,
                    useGoogleFonts: false,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
