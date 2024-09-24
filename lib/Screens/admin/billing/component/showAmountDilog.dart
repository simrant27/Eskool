import 'package:flutter/material.dart';
import '../../../../models/Students_model.dart';

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
      title: Text('Enter Amounts for ${widget.student.name}'),
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
          onPressed: () {
            // Validate the form before submission
            if (_formKey.currentState!.validate()) {
              // Call the callback function to handle the fee amounts
              widget.onSubmit(feeAmounts);
              Navigator.pop(context); // Close the dialog after saving
            }
          },
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
