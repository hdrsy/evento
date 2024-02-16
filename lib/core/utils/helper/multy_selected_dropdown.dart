import 'package:flutter/material.dart';

class MultiSelectDropDown extends StatefulWidget {
  final List<String> options;
  final List<String> selectedValues;
  final Function(List<String>) onSelectionChanged;

  const MultiSelectDropDown({
    Key? key,
    required this.options,
    required this.selectedValues,
    required this.onSelectionChanged,
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
        return AlertDialog(
          title: Text('Select Options'),
          content: SingleChildScrollView(
            child: ListBody(
              children: widget.options.map((String option) {
                return CheckboxListTile(
                  value: selectedValues.contains(option),
                  title: Text(option),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        selectedValues.add(option);
                      } else {
                        selectedValues.remove(option);
                      }
                      print("new length is :${selectedValues.length}");
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
                widget.onSelectionChanged(selectedValues);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showMultiSelectDialog,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                widget.selectedValues.join(', '),
                style: TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}
