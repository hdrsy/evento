import 'package:evento/core/utils/helper/flutter_flow_button_tabbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/theme/text_theme.dart';
import 'people_date_time_bottom_sheet.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

// class SelectPeopleDateTime extends StatelessWidget {
//   const SelectPeopleDateTime({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         showButtonSheet(
//             context: context,
//             widget: PeopleDateTimeBottomSheet(),
//             height: screenHeight * 0.6);
//       },
//       child: Container(
//           width: 360,
//           height: 40,
//           decoration: BoxDecoration(
//             color: customColors.primaryBackground,
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(
//               color: customColors.tertiary,
//             ),
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Container(
//                 decoration: const BoxDecoration(),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
//                       child: Icon(
//                         Icons.people_outlined,
//                         color: customColors.secondaryText,
//                         size: 18,
//                       ),
//                     ),
//                     Text(
//                       "People",
//                       style: customTextStyle.bodyMedium.override(
//                         fontFamily: 'Nunito',
//                         fontWeight: FontWeight.w500,
//                         useGoogleFonts: true,
//                       ),
//                     ).tr(),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 100,
//                 child: VerticalDivider(
//                   thickness: 2,
//                   color: customColors.secondaryBackground,
//                 ),
//               ),
//               Container(
//                 decoration: const BoxDecoration(),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
//                       child: Icon(
//                         Icons.date_range_outlined,
//                         color: customColors.secondaryText,
//                         size: 18,
//                       ),
//                     ),
//                     Text(
//                       "Date",
//                       style: customTextStyle.bodyMedium.override(
//                         fontFamily: 'Nunito',
//                         fontWeight: FontWeight.w500,
//                         useGoogleFonts: true,
//                       ),
//                     ).tr(),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 100,
//                 child: VerticalDivider(
//                   thickness: 2,
//                   color: customColors.secondaryBackground,
//                 ),
//               ),
//               Container(
//                 decoration: const BoxDecoration(),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
//                       child: Icon(
//                         Icons.access_time,
//                         color: customColors.secondaryText,
//                         size: 18,
//                       ),
//                     ),
//                     Text(
//                       "Time",
//                       style: customTextStyle.bodyMedium.override(
//                         fontFamily: 'Nunito',
//                         fontWeight: FontWeight.w500,
//                         useGoogleFonts: true,
//                       ),
//                     ).tr(),
//                   ],
//                 ),
//               ),
//             ],
//           )),
//     );
//   }
// }
class SelectPeopleDateTime extends StatefulWidget {
  const SelectPeopleDateTime({super.key});

  @override
  State<SelectPeopleDateTime> createState() => _SelectPeopleDateTimeState();
}

class _SelectPeopleDateTimeState extends State<SelectPeopleDateTime>
    with TickerProviderStateMixin {
  late TabController tabBarController;
  @override
  initState() {
    tabBarController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Select Options Below",
                style: customTextStyle.bodyMedium.override(
                  fontFamily: 'Roboto',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ).tr(),
            ],
          ),
        ),
        Container(
            width: double.infinity,
            height: 350,
            decoration: BoxDecoration(
              color: customColors.secondaryBackground,
            ),
            child: Column(children: [
              Align(
                alignment: const Alignment(0, 0),
                child: FlutterFlowButtonTabBar(
                  useToggleButtonStyle: true,
                  labelStyle: customTextStyle.titleMedium.override(
                    fontFamily: 'Nunito',
                    fontSize: 14,
                    useGoogleFonts: false,
                  ),
                  unselectedLabelStyle: const TextStyle(),
                  labelColor: customColors.info,
                  unselectedLabelColor: customColors.secondaryText,
                  backgroundColor: customColors.primary,
                  unselectedBackgroundColor: customColors.secondaryBackground,
                  borderColor: customColors.primaryBackground,
                  unselectedBorderColor: customColors.primaryBackground,
                  borderWidth: 2,
                  borderRadius: 10,
                  elevation: 0,
                  buttonMargin:
                      const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                  tabs: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                          child: Icon(
                            Icons.calendar_month_rounded,
                          ),
                        ),
                        Tab(
                          text: tr("Date"),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                          child: Icon(
                            Icons.access_time,
                          ),
                        ),
                        Tab(text: tr("Time")),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                          child: Icon(
                            Icons.people_outline,
                          ),
                        ),
                        Tab(
                          text: tr("guest"),
                        ),
                      ],
                    ),
                  ],
                  controller: tabBarController,
                  onTap: (i) async {
                    [() async {}, () async {}, () async {}][i]();
                  },
                ),
              ),
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(top: 10.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15.sp)),
                  color: customColors.primaryBackground,
                ),
                child: TabBarView(controller: tabBarController, children: [
                  MyCalendarWidget(),
                  pickTime(context),
                  selectPeople()
                ]),
              ))
            ])),
      ],
    );
  }
}
