import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HelloPage extends StatefulWidget {
  @override
  _HelloPageState createState() => _HelloPageState();
}

class _HelloPageState extends State<HelloPage> {
  String responseMessage = '';

  Future<void> fetchHelloMessage() async {
    try {
      final response =
          await http.get(Uri.parse("http://192.168.18.121:3000/hello"));

      if (response.statusCode == 200) {
        setState(() {
          responseMessage = response.body;
        });
      } else {
        setState(() {
          responseMessage = 'Failed to connect: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        responseMessage = 'Error: $e';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchHelloMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello Message'),
      ),
      body: Center(
        child: Text(responseMessage),
      ),
    );
  }
}
