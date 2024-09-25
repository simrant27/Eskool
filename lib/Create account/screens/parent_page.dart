import 'package:flutter/material.dart';
import '../componets/parent_form_popup.dart';
import '../Widgets/parent_card.dart';

class ParentPage extends StatefulWidget {
  @override
  _ParentPageState createState() => _ParentPageState();
}

class _ParentPageState extends State<ParentPage> {
  List<Map<String, dynamic>> parents = [];

  void _addParent(Map<String, dynamic> parent) {
    setState(() {
      parents.add(parent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Parents'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return ParentFormPopup(onSubmit: _addParent);
                },
              );
            },
            child: Text('Add Parent'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: parents.length,
              itemBuilder: (context, index) {
                return ParentCard(parent: parents[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
