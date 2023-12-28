import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';

class OrganizerFolloersCard extends StatelessWidget {
  const OrganizerFolloersCard({super.key});

  @override
  Widget build(BuildContext context) {
    return // Generated code for this Row Widget...
        Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Image.network(
              'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=900&q=60',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
              child: Text(
                 "Randy Rudolph",
                style: customTextStyle.bodyLarge,
              ),
            ),
          ),
          ButtonWidget(
            onPressed: () {
              print('Button pressed ...');
            },
            text:  "Following",
            options: ButtonOptions(
              width: 85,
              height: 21,
              padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
              iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
              color:customColors.secondaryBackground,
              textStyle: customTextStyle.titleSmall.override(
                    fontFamily: 'Nunito',
                    color:customColors.primary,
                    fontSize: 10,
                    fontWeight: FontWeight.normal,
                    useGoogleFonts: true,
                  ),
              borderSide: BorderSide(
                color:customColors.primary,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ],
      ),
    );
  }
}
