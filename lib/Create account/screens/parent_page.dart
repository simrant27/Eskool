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

  void _editParent(Map<String, dynamic> updatedParent) {
    setState(() {
      int index = parents.indexWhere((p) => p['fullName'] == updatedParent['fullName']);
      if (index != -1) {
        parents[index] = updatedParent; // Update the parent's details
      }
    });
  }

  void _deleteParent(String parentName) {
    setState(() {
      parents.removeWhere((p) => p['fullName'] == parentName); // Delete the parent based on their name
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
                return ParentCard(
                  parent: parents[index],
                  onEdit: _editParent,
                  onDelete: () => _deleteParent(parents[index]['fullName']),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
