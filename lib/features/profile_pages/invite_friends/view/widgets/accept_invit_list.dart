import '../../../../../core/utils/theme/text_theme.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
class AcceptInvitList extends StatelessWidget {
  const AcceptInvitList({super.key});

  @override
  Widget build(BuildContext context) {
    return 
Column(
  mainAxisSize: MainAxisSize.max,
  children: [
    // Generated code for this Text Widget...
Align(
  alignment: const AlignmentDirectional(-1.00, -1.00),
  child: Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
    child: Text(
       "Accepted Invites",
      style: customTextStyle.bodyMedium.override(
            fontFamily: 'Roboto',
            color:customColors.primaryText,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
    ).tr(),
  ),
),

    acceptInviteCard(context),
    acceptInviteCard(context),
     ],
)
;
  }

  Padding acceptInviteCard(BuildContext context) {
    return Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
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
            ).tr(),
          ),
        ),
      ],
    ),
  );
  }
}