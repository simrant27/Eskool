import 'package:eskool/constants/constants.dart';
import 'package:eskool/users/component/CustomScaffold.dart';
import 'package:eskool/users/component/customAppBar2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class MaterialListScreen extends StatefulWidget {
  @override
  _MaterialListScreenState createState() => _MaterialListScreenState();
}

class _MaterialListScreenState extends State<MaterialListScreen> {
  List<dynamic> _materials = [];

  Future<void> _fetchMaterials() async {
    try {
      final response = await http
          .get(Uri.parse('$url/api/materials')); // Replace with your API URL
      if (response.statusCode == 200) {
        setState(() {
          _materials = json.decode(response.body);
        });
      } else {
        throw Exception('Failed to load materials');
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> _openFile(String filename) async {
    final url1 =
        '$url/uploads/materials/$filename'; // Replace with your API URL
    if (await canLaunch(url1)) {
      await launch(url1);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchMaterials();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: _materials.isEmpty
            ? Center(child: CircularProgressIndicator())
            : Card(
                child: ListView.builder(
                  itemCount: _materials.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(_materials[index]['title']),
                        subtitle: Text(_materials[index]['description'] ?? ''),
                        trailing: IconButton(
                          icon: Icon(Icons.download),
                          onPressed: () {
                            _openFile(_materials[index][
                                'file']); // Call openFile function with the file name
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
        appBar: customAppBar2("Uploaded Materials"));
  }
}
