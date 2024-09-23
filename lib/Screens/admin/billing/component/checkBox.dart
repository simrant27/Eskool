import 'package:flutter/material.dart';

// Pass feeSelections and the selectAll state as parameters
CheckboxListTile checkBox(
  String fee,
  StateSetter setState,
  bool selectAll,
  Map<String, bool> feeSelections,
) {
  return CheckboxListTile(
    title: Text(fee),
    value: feeSelections[fee],
    onChanged: (value) {
      setState(() {
        feeSelections[fee] = value ?? false;

        // Uncheck "Select All" if any fee is deselected
        if (value == false) {
          selectAll = false;
        } else {
          // Check if all fees are selected
          selectAll = feeSelections.values.every((selected) => selected);
        }
      });
    },
  );
}
