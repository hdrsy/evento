import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';

class MultiSelectDropDown extends StatefulWidget {
  final List<String> options;
  final List<String> selectedValues;
  final Function(List<String>) onSelectionChanged;
  final String title;
  const MultiSelectDropDown({
    Key? key,
    required this.options,
    required this.selectedValues,
    required this.onSelectionChanged,
    required this.title,
  }) : super(key: key);

  @override
  _MultiSelectDropDownState createState() => _MultiSelectDropDownState();
}

class _MultiSelectDropDownState extends State<MultiSelectDropDown> {
  void _showMultiSelectDialog() async {
    final List<String> selectedValues = List.from(widget.selectedValues);

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          // Use StatefulBuilder to manage state inside the dialog
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: customColors.secondaryBackground,
              title: Text(
                'Select Options',
                style: customTextStyle.bodyMedium.override(
                  fontFamily: 'Nunito',
                  color: customColors.primaryText,
                  useGoogleFonts: true,
                ),
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: widget.options.map((String option) {
                    return CheckboxListTile(
                      value: selectedValues.contains(option),
                      title: Text(
                        option,
                        style: customTextStyle.bodyMedium.override(
                          fontFamily: 'Nunito',
                          color: customColors.secondaryText,
                          useGoogleFonts: true,
                        ),
                      ),
                      onChanged: (bool? value) {
                        setState(() {
                          // This setState refers to the StatefulBuilder's setState
                          if (value == true) {
                            if (!selectedValues.contains(option)) {
                              selectedValues.add(option);
                            }
                          } else {
                            selectedValues.remove(option);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Done'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    widget.onSelectionChanged(
                        selectedValues); // Ensure this updates the state outside the dialog
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showMultiSelectDialog,
      child: Container(
        width: double.infinity,
        height: scaleHeight(50),
        padding: padding(0, 10, 0, 10),
        decoration: BoxDecoration(
          border: Border.all(color: customColors.primaryBackground, width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                widget.selectedValues.isEmpty
                    ? widget.title
                    : widget.selectedValues.join(', '),
                style: customTextStyle.bodyMedium.override(
                  fontFamily: 'Nunito',
                  color: customColors.primary,
                  useGoogleFonts: true,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: customColors.secondaryText,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }
}
