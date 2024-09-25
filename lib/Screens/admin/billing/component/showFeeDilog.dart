import 'package:flutter/material.dart';
import '../data/studentList.dart';
import 'showAmountDilog.dart';

class ShowFeeDialog extends StatefulWidget {
  final List<String> fees; // List of available fees
  final Student student;

  ShowFeeDialog({
    Key? key,
    required this.fees,
    required this.student,
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
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // Get selected fees
            List<String> selectedFees = feeSelections.entries
                .where((entry) => entry.value)
                .map((entry) => entry.key)
                .toList();

            if (selectedFees.isEmpty) {
              // Show an error message if no fees are selected
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please select at least one fee.'),
                ),
              );
              return; // Exit early if no fees are selected
            }

            Navigator.pop(context); // Close current dialog

            // Show the amount entry dialog for selected fees
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return ShowAmountEntryDialog(
                  selectedFees: selectedFees,
                  student: widget.student,
                  onSubmit: (feeAmounts) {
                    // Handle the submitted fee amounts here
                    print('Submitted amounts: $feeAmounts');
                    // Do something with the feeAmounts, e.g., saving to database
                  },
                );
              },
            );

            // Show a SnackBar with the selected fees
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Selected Fees: ${selectedFees.join(", ")}'),
              ),
            );
          },
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
