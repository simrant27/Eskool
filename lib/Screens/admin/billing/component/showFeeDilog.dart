import 'package:flutter/material.dart';
import '../../../../models/Students_model.dart';

class ShowFeeDialog extends StatefulWidget {
  final List<String> fees; // List of available fees
  final Student student;
  final Function(Map<String, bool>) confirm; // Function to handle confirmation

  ShowFeeDialog({
    Key? key,
    required this.fees,
    required this.student,
    required this.confirm,
  }) : super(key: key);

  @override
  _ShowFeeDialogState createState() => _ShowFeeDialogState();
}

class _ShowFeeDialogState extends State<ShowFeeDialog> {
  Map<String, bool> feeSelections = {};
  bool selectAll = false;

  @override
  void initState() {
    super.initState();
    // Initialize all checkboxes to false (not selected)
    feeSelections = {for (var fee in widget.fees) fee: false};
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Fees for ${widget.student.name}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Select All Checkbox
          CheckboxListTile(
            title: Text('Select All'),
            value: selectAll,
            onChanged: (value) {
              setState(() {
                selectAll = value ?? false;
                feeSelections.forEach((key, _) {
                  feeSelections[key] = selectAll;
                });
              });
            },
          ),
          Divider(),
          // Fee checkboxes
          ...widget.fees.map((fee) {
            return CheckboxListTile(
              title: Text(fee),
              value: feeSelections[fee],
              onChanged: (value) {
                setState(() {
                  feeSelections[fee] = value ?? false;
                  // Update selectAll based on individual checkbox states
                  selectAll =
                      feeSelections.values.every((isSelected) => isSelected);
                });
              },
            );
          }).toList(),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close dialog without saving
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // Call the confirm function with the selected fees
            widget.confirm(feeSelections);
            Navigator.pop(context); // Close dialog after confirmation
          },
          child: Text('Confirm'),
        ),
      ],
    );
  }
}
