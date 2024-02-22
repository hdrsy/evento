import '../../../../../core/utils/helper/flutter_flow_util.dart';
import '../../../../../core/utils/theme/text_theme.dart';
import '../../../../../main.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class FAQPage extends StatefulWidget {
  @override
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  String selectedCategory = 'General'; // Default category

  void updateQuestions(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> currentQuestions = allQuestions[selectedCategory]!;

    return Column(
      children: [
        Wrap(
          children: allQuestions.keys
              .map((category) => ChoiceChip(
                    showCheckmark: false,
                    selectedColor: customColors.primary,
                    labelStyle: customTextStyle.bodyMedium.copyWith(
                        color: selectedCategory == category
                            ? customColors.info
                            : customColors.secondaryText),
                    label: Text(category).tr(),
                    selected: selectedCategory == category,
                    onSelected: (_) => updateQuestions(category),
                  ))
              .toList()
              .divide(const SizedBox(
                width: 5,
              )),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
            children: currentQuestions.entries
                .map((entry) {
                  print(entry.key);
                  return question(context, entry.key, entry.value);
                })
                .toList()
                .divide(const SizedBox(
                  height: 20,
                )),
          ),
        ),
      ],
    );
  }
}

Row question(BuildContext context, String question, String answer) {
  return Row(
    mainAxisSize: MainAxisSize.max,
    children: [
      Expanded(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: customColors.primaryBackground,
            ),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
            child: Container(
              width: double.infinity,
              color: const Color(0x00000000),
              child: ExpandableNotifier(
                controller: ExpandableController(initialExpanded: false),
                child: ExpandablePanel(
                  header: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: const AlignmentDirectional(-1.00, -1.00),
                        child: Text(
                          question,
                          style: customTextStyle.displaySmall.override(
                            fontFamily: 'Nunito',
                            color: customColors.primaryText,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            useGoogleFonts: true,
                          ),
                        ).tr(),
                      ),
                    ],
                  ),
                  collapsed: Container(
                    width: MediaQuery.sizeOf(context).width * 0,
                    height: 0,
                    decoration: const BoxDecoration(),
                  ),
                  expanded: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Divider(
                        thickness: 1,
                        color: customColors.secondary,
                      ),
                      Text(
                        answer,
                        style: customTextStyle.bodyMedium.override(
                          fontFamily: 'Nunito',
                          color: customColors.secondaryText,
                          useGoogleFonts: true,
                        ),
                      ).tr(),
                    ],
                  ),
                  theme: ExpandableThemeData(
                    tapHeaderToExpand: true,
                    tapBodyToExpand: false,
                    tapBodyToCollapse: false,
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    hasIcon: true,
                    iconColor: customColors.secondaryText,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

Map<String, Map<String, String>> allQuestions = {
  "General": generalQ,
  "Account": accountQ,
  "Service": servicesQ,
  "Payment": paymenQ
};

Map<String, String> paymenQ = {
  "What payment methods are supported?":
      "Evento supports various electronic payment methods with high-level transaction security.",
  "How secure is the payment process?":
      "Transactions are secured using digital security technologies and encryption.",
  "How does Evento protect my data?":
      "Evento applies the latest encryption and security technologies to protect personal and financial information.",
};
Map<String, String> generalQ = {
  "What is Evento?":
      "Evento is an app specialized in booking and customizing events that allows you to find and organize the perfect events to attend, such as parties, workshops, conferences, or even weddings, all easily through your mobile device.",
  "What are the main functions of Evento?":
      "Its main functions include discovering events, booking tickets, direct communication with event organizers and service providers, using cloud computing infrastructure, and ensuring data security.",
};
Map<String, String> accountQ = {
  "How do I register and login to Evento?":
      "Users can register and login using a Syrian mobile phone number for verification, with an option to login as a guest.",
  "Can I manage my bookings?":
      "Yes, users can manage their bookings, track available spots and pricing.",
  "Can I access or delete my data on Evento?":
      "Users are provided options to access, correct, or delete their data."
};
Map<String, String> servicesQ = {
  "How can I search for events in Evento?":
      "The app has an advanced search system that filters events by location, date, price, and other criteria.",
  "What is the process for booking tickets?":
      "Evento offers a seamless and secure booking process with instant confirmations via text messages.",
  "Is there a support system for users?":
      "Yes, a dedicated team is available for inquiries and assistance through multiple channels.",
};
