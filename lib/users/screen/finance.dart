// ignore_for_file: prefer_const_constructors

import 'package:eskool/users/component/CustomScaffold.dart';
import 'package:flutter/material.dart';
import '../component/customButtonStyle.dart';
import '../component/CustomAlertDialogBox.dart';
import '../component/customAppBar2.dart';

class FinanceBillScreen extends StatelessWidget {
  final String studentName;
  final List<Map<String, dynamic>> billItems;
  final double totalAmount;

  const FinanceBillScreen({
    super.key,
    required this.studentName,
    required this.billItems,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: Padding(
          padding: EdgeInsets.fromLTRB(50, 30, 50, 150),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bill Header
              Text(
                'Student Name: $studentName',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Bill Date: September 1, 2024',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Due Date: September 15, 2024',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),

              // Bill Items List
              Text(
                'Bill Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Divider(thickness: 2),
              Expanded(
                child: ListView.builder(
                  itemCount: billItems.length,
                  itemBuilder: (context, index) {
                    final item = billItems[index];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        item['description'],
                        style: TextStyle(fontSize: 18),
                      ),
                      trailing: Text(
                        '\$${item['amount'].toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  },
                ),
              ),

              // Total Amount
              Divider(thickness: 2),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Amount',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\$${totalAmount.toStringAsFixed(2)}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              // Payment Button
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      customAlertDialogBox(
                        context,
                        "Payment",
                        'Your payment has been processed.',
                        [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(
                                  context); // Close the dialog after confirmation
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                    style: customButtonStyle,
                    child: Text('Pay Now')),
              )
            ],
          ),
        ),
        appBar: customAppBar2("Finance"));
  }
}
