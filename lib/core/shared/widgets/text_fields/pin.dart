import '../../../responsive/responsive.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

// ignore: must_be_immutable
class Pin extends StatelessWidget {
  Pin(
      {super.key,
      required this.onChanged,
      required this.textEditingController,
      this.lenght = 4,
      this.enabled = true,
      required this.validator});
  Function(String)? onChanged;
  TextEditingController textEditingController;
  String? Function(String?)? validator;
  int lenght;
  bool enabled;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: PinCodeTextField(
        enabled: enabled,
        autoDisposeControllers: false,
        appContext: context,
        keyboardType: TextInputType.number,
        length: lenght,
        textStyle: customTextStyle.titleSmall.copyWith(
          fontFamily: 'BeerSerif',
          color: customColors.primaryText,
        ),
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        enableActiveFill: false,
        autoFocus: false,
        enablePinAutofill: true,
        errorTextSpace: 16,
        showCursor: true,
        cursorColor: customColors.primary,
        obscureText: false,
        hintCharacter: '-',
        pinTheme: PinTheme(
          fieldHeight: scaleWidth(50),
          fieldWidth: scaleWidth(50),
          borderWidth: 2,
          borderRadius: BorderRadius.circular(12),
          shape: PinCodeFieldShape.box,
          activeColor: customColors.primaryText,
          inactiveColor: customColors.primaryBackground,
          selectedColor: customColors.secondaryText,
          activeFillColor: customColors.primaryText,
          inactiveFillColor: customColors.primaryBackground,
          selectedFillColor: customColors.secondaryText,
        ),
        controller: textEditingController,
        onChanged: onChanged,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
      ),
    );
  }
}
