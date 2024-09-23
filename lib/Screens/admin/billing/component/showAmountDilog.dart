import 'package:flutter/material.dart';
import '../../../../models/Students_model.dart';

class ShowAmountEntryDialog extends StatelessWidget {
  final List<String> selectedFees;
  final Student student;

  const ShowAmountEntryDialog({
    Key? key,
    required this.selectedFees,
    required this.student,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize the feeAmounts map
    Map<String, double> feeAmounts = {for (var fee in selectedFees) fee: 0.0};

    return AlertDialog(
      title: Text('Enter Amounts for ${student.name}'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...selectedFees.map((fee) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: '$fee Amount',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    feeAmounts[fee] = double.tryParse(value) ?? 0.0;
                  },
                ),
              );
            }).toList(),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close the dialog without saving
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // Handle fee amount submission
            print('Fee amounts for ${student.name}: $feeAmounts');
            Navigator.pop(context); // Close the amount entry dialog
          },
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
