import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/functions/validation/name_validation.dart';
import 'package:evento/core/shared/functions/validation/phone_validation.dart';
import 'package:evento/core/shared/widgets/text_fields/edit_profile_field.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/features/edit_profile/controller/edit_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Fields extends StatelessWidget {
   Fields({super.key});
 final EditProfileController editProfileController = Get.find();
 
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(children: [
         EditProfileField(
          suffixIcon: Icons.person_outline,
                    controller: editProfileController.firstName,
                    hintText: "Mohammad",
                    labelText: "First Name",
                    onChanged: (value){
                      editProfileController.firstName.text=value;
                    },
                    validator: (value){
                      return nameValidation(value);
                    }),
                EditProfileField(
                  suffixIcon: Icons.person_outline,
                    controller: editProfileController.lastName,
                    hintText: "Ahmad",
                    labelText: "Last Name",
                    onChanged: (value){
                      editProfileController.lastName.text=value;
                    },
                    validator: (value){
                      return nameValidation(value);
                    }),
                EditProfileField(
                  suffixIcon: Icons.calendar_month,
                    controller: editProfileController.date,
                    hintText: "19/7/1999",
                    labelText: "Date of Brith",
                    onChanged: (value){
                      editProfileController.date.text=value;
                    },
                    validator: (value){
                      return null;
                    }),
                EditProfileField(
                  suffixIcon: Icons.phone_outlined,
                    controller: editProfileController.phone,
                    hintText: "+963 900000000",
                    labelText: "Phone Number",
                    onChanged: (value){
                      editProfileController.phone.text=value;
                    },
                    validator: (value){
                      return phoneValidation(value);
                    }),
                EditProfileField(
                  suffixIcon: Icons.location_on_outlined,
                    controller: editProfileController.location,
                    hintText: "Damascus, Mazzah",
                    labelText: "Location/Adress",
                    onChanged: (value){
                      editProfileController.location.text=value;
                    },
                    validator: (value){
                      return null;
                    }),
                EditProfileField(
                  suffixIcon: Icons.people_alt_outlined,
                    controller: editProfileController.gender,
                    hintText: "Male",
                    labelText: "Gender",
                    onChanged: (value){
                      editProfileController.gender.text=value;
                    },
                    validator: (value){
                      return null;
                    }),
      ].divide(SizedBox(height: scaleHeight(10),)),
      ),
    );
  }
}