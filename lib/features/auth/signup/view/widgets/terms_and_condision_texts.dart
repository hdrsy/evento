import 'package:evento/core/shared/widgets/bottom_sheets/show_bottom_sheet.dart';
import 'package:evento/core/shared/widgets/widget/term_of_use.dart';
import 'package:evento/features/auth/signup/controller/signup_controller.dart';
import 'package:get/get.dart';

import '../../../../../core/responsive/responsive.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class TermsAndCondisionTexts extends StatelessWidget {
   TermsAndCondisionTexts({super.key});
final SignupController signupController=Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: scaleHeight(5),),
        // Generated code for this Text Widget...
        Text(
          "By joining, I agree to Evento' Terms of Use",
          style: customTextStyle.bodyMedium.copyWith(
            fontFamily: 'Merriweather',
            color: customColors.secondaryText,
            fontSize: 10,
          ),
        ).tr(),

Padding(
  padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
  child: Row(
    mainAxisSize: MainAxisSize.max,
    children: [
      GestureDetector(
        onTap: (){
          showButtonSheet(context: context, widget:TermOfUse(), height: MediaQuery.of(context).size.height * 0.9);
        },
        child: Text(
          "Terms of Use"  ,
          style: customTextStyle.bodyMedium.copyWith(
                fontFamily: 'Merriweather',
                fontSize: 12,
      
              ),
        ).tr(),
      ),
      Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
        child: Icon(
          Icons.arrow_right_alt_outlined,
          color: customColors.secondaryText,
          size: 24,
        ),
      ),
      Spacer(),
      Obx(
        ()=> Checkbox(value: signupController.isAgreedOn.value, 
        
        side: BorderSide(color: customColors.primary),
        onChanged:(value) {
      signupController.isAgreedOn.value=value!;
        },
        activeColor: customColors.primary,
        ),
      )
    ],
  ),
)
,// Generated code for this Row Widget...
// Row(
//   mainAxisSize: MainAxisSize.max,
//   crossAxisAlignment: CrossAxisAlignment.center,
//   children: [
//     Text(
//       "Data Privacy Center" ,
//       style: customTextStyle.bodyMedium.copyWith(
//             fontFamily: 'Merriweather',
//             fontSize: 12,

//           ),
//     ).tr(),
//     Padding(
//       padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
//       child: Icon(
//         Icons.arrow_right_alt_outlined,
//         color: customColors.secondaryText,
//         size: 24,
//       ),
//     ),
//   ],
// )

      ],
    );
  }
}
