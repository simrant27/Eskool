import 'package:flutter/material.dart';
import '../../../../users/component/CustomAlertDialogBox.dart';
import '../data/studentList.dart';
import '../fetchData/feeassign.dart';
import 'updateAndDeleteFee.dart';

class ShowAmountEntryDialog extends StatefulWidget {
  final List<String> selectedFees;
  final Student student;
  final Map<String, double>? initialFeeAmounts; // Optional initial amounts
  final Function(Map<String, double>)
      onSubmit; // Function to handle the submission of fee amounts

  const ShowAmountEntryDialog({
    Key? key,
    required this.selectedFees,
    required this.student,
    required this.onSubmit,
    this.initialFeeAmounts,
  }) : super(key: key);

  @override
  _ShowAmountEntryDialogState createState() => _ShowAmountEntryDialogState();
}

class _ShowAmountEntryDialogState extends State<ShowAmountEntryDialog> {
  late Map<String, double> feeAmounts;
  final _formKey = GlobalKey<FormState>(); // To handle validation

  @override
  void initState() {
    super.initState();
    // Initialize fee amounts, either from initial values or default to 0.0
    feeAmounts = {
      for (var fee in widget.selectedFees)
        fee: widget.initialFeeAmounts?[fee] ?? 0.0
    };
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Enter Amounts for ${widget.student.fullName}'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey, // Attach form validation
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...widget.selectedFees.map((fee) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    initialValue: feeAmounts[fee].toString(),
                    decoration: InputDecoration(
                      labelText: '$fee Amount',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an amount';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Enter a valid number';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        feeAmounts[fee] = double.tryParse(value) ?? 0.0;
                      });
                    },
                  ),
                );
              }).toList(),
            ],
          ),
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
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              bool assignFeeSuccess = true;

              // Call the API to assign the fee for each selected fee
              try {
                for (var fee in feeAmounts.entries) {
                  await assignFee(
                      widget.student.id, fee.key, fee.value, "2024-12-30");
                }
              } catch (e) {
                assignFeeSuccess = false; // Set to false if there's an error
              }

              // If the fee was assigned successfully, show confirmation dialog
              if (assignFeeSuccess) {
                await customAlertDialogBox(
                  context,
                  "Assign Fee",
                  'Fee has been assigned for ${widget.student.fullName}.',
                  [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Close the confirmation dialog
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              } else {
                // Show an error dialog if the assignment failed
                await customAlertDialogBox(
                  context,
                  "Error",
                  'Failed to assign fee for ${widget.student.fullName}. Please try again.',
                  [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);

                        print('${widget.student.fullName}');
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              }

              // Close the amount entry dialog after showing success or error dialog
              Navigator.pop(context);
            }
          },
          child: const Text('Assign'),
        )
      ],
    );
  }
}
