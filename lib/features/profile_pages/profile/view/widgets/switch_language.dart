// ignore_for_file: avoid_print

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Language {
  final String name;
  final String languageCode;
  final String imageName;
  Language(this.name, this.languageCode, this.imageName);
}

// ignore: use_key_in_widget_constructors
class LanguageSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
    
     SizedBox(
      height: scaleHeight(100),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: 200,
            height: 50,
            decoration: BoxDecoration(
              color: customColors.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: dropDown(context),
          ),
        ],
      ),
    );
  }
}

Widget dropDown(BuildContext context) {
  String currentLanguage =
      sharedPreferences?.getString('language_code') ?? 'en';
  List<Language> languages = [
    Language('English', 'en', 'assets/images/united kindom flag.jpg'),
    Language('العربية', 'ar', 'assets/images/arab language flag.webp'),
  ];
  Language selectedLanguage =
      currentLanguage == 'ar' ? languages[1] : languages[0];
  return DropdownButtonHideUnderline(
    child: DropdownButton2<Language>(
      isExpanded: true,
      hint: Text(
        selectedLanguage.name.toString(),
        style:  TextStyle(
          color: customColors.info, // your theme color here
          fontWeight: FontWeight.normal,
          fontSize: 13,
        ),
      ),
      value: selectedLanguage,
      iconStyleData:  IconStyleData(
        iconEnabledColor: customColors.info, // your theme color here
      ),
      onChanged: (Language? newValue) {
    // Use EasyLocalization context here
    context.locale   = newValue!.languageCode == 'en' 
        ? Locale('en') 
        : Locale('ar');
Get.back();
    // Get.offAllNamed('/home');
  },
      items: languages.map<DropdownMenuItem<Language>>((Language language) {
        return DropdownMenuItem<Language>(
          value: language,
          child: Container(
            color: customColors.primary,
            constraints: const BoxConstraints(),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          width: 30,
                          height: 25,
                          child: Image.asset(language.imageName)),
                    ),
                    Text(
                      language.name,
                      style:  TextStyle(
                        color: customColors.info, // your theme color here
                        fontWeight: FontWeight.normal,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
      dropdownStyleData: DropdownStyleData(
        maxHeight: 200,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: customColors.primary,
        ),
      ),
    ),
  );
}