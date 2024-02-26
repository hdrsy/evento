import 'package:easy_localization/easy_localization.dart';
import 'package:evento/core/shared/functions/validation/phone_validation.dart';
import 'package:evento/core/shared/functions/validation/pin.dart';
import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/shared/widgets/error_messages/error_messages.dart';
import 'package:evento/core/shared/widgets/text_fields/pin.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/payment/controller/payment_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PaymentScreenInBooking extends StatelessWidget {
  PaymentScreenInBooking({super.key});
  final PaymentController paymentController = Get.put(PaymentController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.secondaryBackground,
      appBar: AppBar(
        backgroundColor: customColors.secondaryBackground,
        title: Text(tr("Payment"),
            style: customTextStyle.bodyMedium
                .copyWith(color: customColors.primary, fontSize: 20)),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_rounded,
            color: customColors.primaryText,
            size: 30,
          ),
        ),
      ),
      body: Obx(
        () => SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              // const TabBarSection(),
              const PaymentDetailes(),
              PhonePayment(),
              paymentController.isIvoiceCreated.value
                  ? InvoiceSection()
                  : SizedBox.shrink(),
              // const FullName(),
              paymentController.isIvoiceCreated.value
                  ? OtpSection()
                  : SizedBox.shrink()
            ].divide(SizedBox(
              height: 16.h,
            )),
          ),
        ),
      ),
    );
  }
}

class OtpSection extends StatelessWidget {
  OtpSection({super.key});
  final PaymentController paymentController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Enter Otp",
          style: customTextStyle.bodyMedium.override(
            fontFamily: 'Nunito',
            color: customColors.primaryText,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            useGoogleFonts: false,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Pin(
          lenght: 6,
          onChanged: (value) {
            paymentController.otp.text = value;
            paymentController.isSentOtpActive.value = value.length == 6;
          },
          textEditingController: paymentController.otp,
          validator: (value) {
            return otpPaymentValidation(value);
          },
        ),
        Obx(
          () => Align(
            alignment: const AlignmentDirectional(0, -1),
            child: Text(
              '${paymentController.minutes.toString().padLeft(2, '0')}:${paymentController.seconds.toString().padLeft(2, '0')}',
              style: customTextStyle.bodyMedium.override(
                fontFamily: 'Nunito',
                fontSize: 12,
                useGoogleFonts: false,
              ),
            ),
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(0, -1),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
            child: GestureDetector(
              onTap: () {
                paymentController.getInvoice();
              },
              child: Text(
                "Send code again",
                style: customTextStyle.bodyMedium.override(
                  fontFamily: 'Nunito',
                  color: customColors.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  useGoogleFonts: false,
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(0, -1),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Obx(
              () => ButtonWidget(
                showLoadingIndicator: paymentController.isLoadingotp.value,
                onPressed: () async {
                  paymentController.isSentOtpActive.value
                      ? paymentController.sentOtp()
                      : null;
                },
                text: "Confirm",
                options: ButtonOptions(
                  width: 200,
                  height: 40,
                  padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                  iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  color: paymentController.isSentOtpActive.value
                      ? customColors.primary
                      : customColors.secondary,
                  textStyle: customTextStyle.titleSmall.override(
                    fontFamily: 'Nunito',
                    color: Colors.white,
                    useGoogleFonts: false,
                  ),
                  elevation: 3,
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class TabBarSection extends StatelessWidget {
  const TabBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Column(children: [
          TabBar(
              onTap: (value) {
                print(value);
              },
              labelColor: customColors.primary,
              unselectedLabelColor: customColors.grayIcon,
              labelStyle: customTextStyle.titleSmall.override(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w500,
                useGoogleFonts: true,
              ),
              dividerColor: customColors.secondaryBackground,
              unselectedLabelStyle: const TextStyle(),
              indicatorColor: customColors.primary,
              indicatorWeight: 4,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(
                  text: tr("MTN"),
                ),
                Tab(
                  text: tr("Syriatel"),
                ),
              ]),
        ]));
  }
}

class PhonePayment extends StatelessWidget {
  PhonePayment({super.key});
  final PaymentController paymentController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Form(
        key: paymentController.formstate,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "MTN Payment Number",
              style: customTextStyle.bodyMedium.override(
                fontFamily: 'Nunito',
                color: customColors.primaryText,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                useGoogleFonts: false,
              ),
            ).tr(),
            SizedBox(
              height: 10.h,
            ),
            Container(
              // height: 50.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: customColors.primaryBackground,
                ),
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                child: TextFormField(
                  controller: paymentController.phone,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: "+963    Mobile Phone",
                    labelStyle: customTextStyle.bodyMedium.override(
                      fontFamily: 'Nunito',
                      color: customColors.secondaryText,
                      fontSize: 12,
                      useGoogleFonts: false,
                    ),
                    hintStyle: customTextStyle.bodyMedium.override(
                      fontFamily: 'Nunito',
                      color: customColors.primaryText,
                      useGoogleFonts: false,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: customColors.primary,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0x00000000),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0x00000000),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    focusedErrorBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0x00000000),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    filled: true,
                    fillColor: customColors.secondaryBackground,
                    contentPadding: const EdgeInsets.all(16),
                  ),
                  style: customTextStyle.bodySmall.override(
                    fontFamily: 'Nunito',
                    color: customColors.secondaryText,
                    useGoogleFonts: false,
                  ),
                  validator: (value) {
                    // return null;
                    return phoneValidation(value);
                  },
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Align(
              alignment: const AlignmentDirectional(0, -1),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Obx(
                  () => ButtonWidget(
                    showLoadingIndicator:
                        Get.find<PaymentController>().isLoadingPhone.value,
                    onPressed: () async {
                      Get.find<PaymentController>().getInvoice();
                    },
                    text: "Confirm",
                    options: ButtonOptions(
                      width: 200,
                      height: 40,
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                      iconPadding:
                          const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      color: customColors.primary,
                      textStyle: customTextStyle.titleSmall.override(
                        fontFamily: 'Nunito',
                        color: Colors.white,
                        useGoogleFonts: false,
                      ),
                      elevation: 3,
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
            paymentController.errorMessageInInvoice != ''
                ? ErrorMessages(
                    message: paymentController.errorMessageInInvoice.value,
                  )
                : SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}

class PaymentDetailes extends StatelessWidget {
  const PaymentDetailes({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Payment Summary",
          style: customTextStyle.bodyMedium.override(
            fontFamily: 'Nunito',
            color: customColors.primaryText,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            useGoogleFonts: false,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.sp)),
              border: Border.all(color: customColors.primaryBackground)),
          child: Column(
            children: [
              SingleRowInPayment(
                  title: "Amount",
                  subtitle:
                      Get.find<PaymentController>().totalAmount.toString()),
              SingleRowInPayment(
                title: "Taxes",
                subtitle: Get.find<PaymentController>().invoiceTax.toString(),
              ),
              Divider(
                thickness: 1,
                indent: 0,
                endIndent: 0,
                color: customColors.secondary,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "Total",
                        style: customTextStyle.headlineSmall.override(
                          fontFamily: 'Lexend Deca',
                          color: const Color(0xFF8B97A2),
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${(Get.find<PaymentController>().totalAmount + Get.find<PaymentController>().invoiceTax).toString()} ${tr("sp")}",
                    style: customTextStyle.displaySmall,
                  ),
                ],
              ),
            ],
          ),
        )
      ].divide(SizedBox(
        height: 5.h,
      )),
    );
  }
}

class SingleRowInPayment extends StatelessWidget {
  const SingleRowInPayment(
      {super.key, required this.title, required this.subtitle});
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: customTextStyle.bodySmall.override(
            fontFamily: 'Lexend Deca',
            color: const Color(0xFF8B97A2),
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
        ),
        Text(
          "$subtitle ${tr("sp")}",
          style: customTextStyle.bodyLarge.override(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.bold,
            useGoogleFonts: false,
          ),
        ),
      ],
    );
  }
}

class FullName extends StatelessWidget {
  const FullName({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Full Name",
            style: customTextStyle.bodyMedium.override(
              fontFamily: 'Nunito',
              color: customColors.primaryText,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              useGoogleFonts: false,
            ),
          ),
          Text(
            "What Ever",
            style: customTextStyle.bodyMedium.override(
              fontFamily: 'Nunito',
              fontSize: 14.sp,
              useGoogleFonts: false,
            ),
          ),
        ],
      ),
    );
  }
}

class InvoiceSection extends StatelessWidget {
  InvoiceSection({super.key});
  final PaymentController paymentController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Invoice ID",
              style: customTextStyle.bodyMedium.override(
                fontFamily: 'Nunito',
                color: customColors.primaryText,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                useGoogleFonts: false,
              ),
            ),
            Obx(
              () => Text(
                "#${paymentController.invoiceId.value}",
                style: customTextStyle.bodyMedium.override(
                  fontFamily: 'Nunito',
                  fontSize: 14.sp,
                  useGoogleFonts: false,
                ),
              ),
            ),
          ],
        ),
        // IconWithContainer(
        //   borderRadius: 20,
        //   buttonSize: 40,
        //   backgroundColor: customColors.primary,
        //   icon: Icons.qr_code,
        //   onTap: () {},
        //   iconColor: customColors.info,
        // )
      ],
    );
  }
}
