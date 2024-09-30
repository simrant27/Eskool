import 'package:eskool/constants/constants.dart';
import 'package:eskool/users/data/student.dart';
import 'package:flutter/material.dart';
import '../component/CustomAlertDialogBox.dart';
import '../component/CustomScaffold.dart';
import '../component/customAppBar2.dart';
import '../component/customButtonStyle.dart';
import '../forBackend/fetchStudentFee.dart';

class FinanceBillScreen extends StatefulWidget {
  final String studentId;
  final String studentName;
  final bool payButton;
  final bool showBottomApp;

  const FinanceBillScreen({
    Key? key,
    required this.studentId,
    required this.studentName,
    this.payButton = true,
    this.showBottomApp = true,
  }) : super(key: key);

  @override
  _FinanceBillScreenState createState() => _FinanceBillScreenState();
}

class _FinanceBillScreenState extends State<FinanceBillScreen> {
  List<Map<String, dynamic>> billItems = [];
  double totalAmount = 0.0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFees(widget.studentId).then((data) {
      setState(() {
        billItems = List<Map<String, dynamic>>.from(data['fees']);
        totalAmount = billItems.fold(0, (sum, item) => sum + item['amount']);
        isLoading = false;
      });
    }).catchError((error) {
      // Handle error appropriately
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(' fetching fees: No fee Added')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return CustomScaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(50, 30, 50, 150),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bill Header
            Text(
              'Student Name: ${widget.studentName}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                      item['feeType'],
                      style: TextStyle(fontSize: 18),
                    ),
                    subtitle: Text(
                      'Due Date: ${DateTime.parse(item['dueDate']).toLocal().toString().split(' ')[0]}', // Format the date
                      style: TextStyle(fontSize: 14),
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$${totalAmount.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),

            // Payment Button
            widget.payButton
                ? Center(
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
                      child: Text('Pay Now'),
                    ),
                  )
                : Text("")
          ],
        ),
      ),
      bottomApp: widget.showBottomApp,
      appBar: customAppBar2("Fee for ${widget.studentName}"),
    );
  }
}
