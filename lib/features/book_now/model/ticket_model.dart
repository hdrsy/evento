// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:evento/features/events/event_detailes/model/event_detailes_model.dart';
import 'package:flutter/material.dart';

class TicketModel {
  Class? selectedClass=null;
   List<Amenity> selectedAminiteds=[];
   int totalPrice=0;
   TextEditingController fisrtName=TextEditingController();
   TextEditingController lastName=TextEditingController();
   TextEditingController couponNumber=TextEditingController();
   TextEditingController age=TextEditingController();
   TextEditingController phoneNumber=TextEditingController();
  TicketModel();
}
