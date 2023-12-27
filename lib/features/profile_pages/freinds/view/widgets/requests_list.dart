import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';

class RequestsList extends StatelessWidget {
  const RequestsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  text: TextSpan(
                    children: [
                      
                      TextSpan(
                        text: "Friend requests",
                        style: TextStyle(
                          color: customColors.primaryText,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text: "200",
                        style: customTextStyle.bodyMedium.override(
                          fontFamily: 'Nunito',
                          color: customColors.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          useGoogleFonts: true,
                        ),
                      ),
                    ],
                    style: customTextStyle.bodyMedium,
                  ),
                ),
                Text(
                  "see all",
                  style: customTextStyle.bodyMedium.override(
                    fontFamily: 'Nunito',
                    color: customColors.primary,
                    fontSize: 12,
                    useGoogleFonts: false,
                  ),
                ),
              ],
            ),
          ),
          ...List.generate(6, (index) => const RequestsCard())
        ].divide(const SizedBox(
          height: 10,
        )),
      ),
    );
  }
}

class RequestsCard extends StatelessWidget {
  const RequestsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 1),
        child: Container(
          width: 100,
          decoration: BoxDecoration(
            color: customColors.secondaryBackground,
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
            child: // Generated code for this Row Widget...
Row(
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
    Expanded(
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Randy Rudolph",
              style: customTextStyle.bodyLarge,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonWidget(
                  onPressed: () {
                    
                  },
                  text:  "Confirm",
                  options: ButtonOptions(
                    width: 120,
                    height: 21,
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                    iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    color:customColors.primary,
                    textStyle:
                        customTextStyle.titleSmall.override(
                              fontFamily: 'Nunito',
                              color:customColors.info,
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
                ButtonWidget(
                  onPressed: () {

                  },
                  text: "Delete",
                  options: ButtonOptions(
                    width: 120,
                    height: 21,
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                    iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    color:customColors.secondaryBackground,
                    textStyle:
                        customTextStyle.titleSmall.override(
                              fontFamily: 'Nunito',
                              color:customColors.primary,
                              fontSize: 10,
                              fontWeight: FontWeight.normal,
                              useGoogleFonts: false,
                            ),
                    borderSide: BorderSide(
                      color:customColors.primary,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ],
            ),
          ].divide(const SizedBox(height: 10)),
        ),
      ),
    ),
  ],
)

          ),
        ),
      ),
    );
  }
}
