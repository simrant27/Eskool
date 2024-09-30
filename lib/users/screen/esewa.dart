// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:webview_flutter/webview_flutter.dart';

// class FeePaymentScreen extends StatefulWidget {
//   @override
//   _FeePaymentScreenState createState() => _FeePaymentScreenState();
// }

// class _FeePaymentScreenState extends State<FeePaymentScreen> {
//   late String paymentUrl;

//   Future<void> payFee() async {
//     final response = await http.post(
//       Uri.parse('http://localhost:500/api/pay'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, dynamic>{
//         'amount': 1000, // Amount to pay
//         'productId': 'your_product_id',
//         'userId': 'user_id', // This should be the authenticated user ID
//       }),
//     );

//     if (response.statusCode == 200) {
//       setState(() {
//         paymentUrl = jsonDecode(response.body)['paymentUrl'];
//       });
//     } else {
//       // Handle error
//       print('Error: ${response.body}');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Pay Fees')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 payFee();
//               },
//               child: Text('Pay Fee'),
//             ),
//             if (paymentUrl != null)
//               Expanded(
//                 child: WebView(
//                   initialUrl: paymentUrl,
//                   javascriptMode: JavascriptMode.unrestricted,
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentPage extends StatelessWidget {
  final String studentId = "ST123456";
  final double amount = 1200.0; // This can be dynamic based on payment
  final String esewaMerchantId = "EPAYTEST";
  final String esewaPaymentUrl =
      "https://uat.esewa.com.np/epay/main"; // UAT (sandbox)

  // Dummy success and failure URLs for redirection
  final String successUrl = "https://www.facebook.com/";
  final String failureUrl = "https://www.netflix.com/np/";

  Future<void> _payWithEsewa(BuildContext context) async {
    // Assuming there are no additional charges for this transaction
    final double transactionFee = 0.0; // Set transaction fee if applicable
    final double totalAmount =
        amount + transactionFee; // Total amount to be charged

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
