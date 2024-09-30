import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'eSewa Payment',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: PaymentPage(),
    );
  }
}

class PaymentPage extends StatelessWidget {
  final String studentId = "ST123456";
  final double amount = 1200.0; // This can be dynamic based on payment
  final String esewaMerchantId = "EPAYTEST";
  final String esewaPaymentUrl = "https://uat.esewa.com.np/epay/main"; // UAT (sandbox)

  // Dummy success and failure URLs for redirection
  final String successUrl = "https://yourapp.com/success";
  final String failureUrl = "https://yourapp.com/failure";

  Future<void> _payWithEsewa(BuildContext context) async {
    // Assuming there are no additional charges for this transaction
    final double transactionFee = 0.0; // Set transaction fee if applicable
    final double totalAmount = amount + transactionFee; // Total amount to be charged

    // Construct the URL with necessary parameters for eSewa
    final String url = Uri.encodeFull(
        '$esewaPaymentUrl?tAmt=$totalAmount' // Required parameter
        '&amt=$amount' // Payment amount
        '&txAmt=$transactionFee' // Transaction fee
        '&psc=0' // Payment service charge
        '&pdc=0' // Partner service charge
        '&scd=$esewaMerchantId' // Merchant/service code
        '&pid=$studentId' // Product/Payment ID
        '&su=$successUrl' // Success URL
        '&fu=$failureUrl' // Failure URL
    );

    // Check if the URL can be launched
    if (await canLaunch(url)) {
      await launch(url); // Launch the eSewa payment page
    } else {
      // Show error if URL can't be launched
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Could not launch eSewa payment page'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("eSewa Payment"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Student ID: $studentId",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Amount: Rs. $amount",
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () => _payWithEsewa(context),
                icon: Icon(Icons.payment),
                label: Text("Pay with eSewa"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Please ensure your eSewa account has sufficient balance before proceeding.",
              style: TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
