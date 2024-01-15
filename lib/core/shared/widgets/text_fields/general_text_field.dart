import '../../../../main.dart';
import 'package:flutter/material.dart';

Widget generalTextField({required String hint,required TextEditingController textEditingController }){
  return TextFormField(
    controller: textEditingController,
                  // Add appropriate controllers and focus nodes.
                  decoration: InputDecoration(
                    
                    labelText: hint, // Replace with localization if needed.
                    enabledBorder: _buildBorder(),
                    focusedBorder: _buildBorder(),
                    filled: true,
                    fillColor: customColors.primaryBackground,
                    contentPadding: const EdgeInsets.all(16),
                     labelStyle: customTextStyle
                              .bodyMedium
                              .copyWith(
                                fontFamily: 'Merriweather',
                                color:
                                    customColors.secondaryText,
                                fontSize: 12,
                                
                              ),
                          hintStyle: customTextStyle
                              .bodyMedium
                              .copyWith(
                                fontFamily: 'Merriweather',
                                color: customColors. primaryText,
                                
                              ),
                         
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0x00000000),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0x00000000),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                  ),
                  // Add any necessary styling and validation.
                );
}
OutlineInputBorder _buildBorder() {
    // Helper method to create a consistent border style for input fields.
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: customColors.primaryBackground,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(40),
    );
  }
