// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:evento/core/utils/helper/form_field_controller.dart';
import 'package:evento/features/events/event_detailes/model/event_detailes_model.dart';
import 'package:flutter/material.dart';

class TicketModel {
  Class? selectedClass = null;
  List<Amenity> selectedAminiteds = [];
  int totalPrice = 0;
  TextEditingController fisrtName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  String couponCode = "";
  int couponNumber = 0;
  TextEditingController age = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  FormFieldController<String>? dropDownValueController;

  // String? selectedCoupon = null;
  TicketModel();
}
