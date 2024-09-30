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

import 'package:eskool/users/component/CustomScaffold.dart';
import 'package:eskool/users/component/customAppBar2.dart';
import 'package:eskool/users/component/customButtonStyle.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentPage extends StatefulWidget {
  final String studentId;
  final String studentName;

  final double amount;
  PaymentPage(
      {required this.studentName,
      required this.amount,
      required this.studentId,
      super.key});
  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  // This can be dynamic based on payment
  final String esewaMerchantId = "EPAYTEST";

  final String esewaPaymentUrl = "https://uat.esewa.com.np/epay/main";
  // UAT (sandbox)
  final String successUrl = "https://www.facebook.com/";

  final String failureUrl = "https://www.netflix.com/np/";

  Future<void> _payWithEsewa(BuildContext context) async {
    // Assuming there are no additional charges for this transaction
    final double transactionFee = 0.0; // Set transaction fee if applicable
    final double totalAmount =
        widget.amount + transactionFee; // Total amount to be charged

    // Construct the URL with necessary parameters for eSewa
    final String url = Uri.encodeFull(
        '$esewaPaymentUrl?tAmt=$totalAmount' // Required parameter
        '&amt=${widget.amount}' // Payment amount
        '&txAmt=$transactionFee' // Transaction fee
        '&psc=0' // Payment service charge
        '&pdc=0' // Partner service charge
        '&scd=$esewaMerchantId' // Merchant/service code
        '&pid=${widget.studentName}' // Product/Payment ID
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
    return CustomScaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Student Name: ${widget.studentName}",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0XFF343E87)),
                ),
                SizedBox(height: 10),
                Text(
                  "Student Id: Rs. ${widget.studentId}",
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
                SizedBox(height: 20),
                Text(
                  "Amount: Rs. ${widget.amount}",
                  style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton.icon(
                      onPressed: () => _payWithEsewa(context),
                      icon: Icon(Icons.payment),
                      label: Text("Pay with eSewa"),
                      style: customButtonStyle),
                ),
                SizedBox(height: 20),
                Text(
                  "Please ensure your eSewa account has sufficient balance before proceeding.",
                  style: TextStyle(color: Colors.red, fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        appBar: customAppBar2("Esewa Payment"));
  }
}
