import 'package:flutter/material.dart';

class FinanceBillScreen extends StatelessWidget {
  final String studentName;
  final List<Map<String, dynamic>> billItems;
  final double totalAmount;

  FinanceBillScreen({
    required this.studentName,
    required this.billItems,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 196, 232, 248),
        toolbarHeight: 80,
        title: Text(
          'Finance - Bill for $studentName',
          style: TextStyle(
            color: Colors.black,
            fontSize: MediaQuery.of(context).size.height / 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Divider(thickness: 2),
            Expanded(
              child: ListView.builder(
                itemCount: billItems.length,
                itemBuilder: (context, index) {
                  final item = billItems[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(item['description']),
                    trailing: Text('\$${item['amount'].toStringAsFixed(2)}'),
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$${totalAmount.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            // Payment Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle payment action
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Payment Successful'),
                        content: Text('Your payment has been processed.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('Pay Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
