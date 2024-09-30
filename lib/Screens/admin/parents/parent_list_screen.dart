import 'package:eskool/Screens/admin/admindashboard/components/customAppbar.dart';
import 'package:eskool/Screens/admin/admindashboard/components/responsive_drawer_layout.dart';
import 'package:eskool/Screens/admin/components/custon_button.dart';
import 'package:eskool/models/ParentMode.dart';
// import 'package:eskool/Screens/admin/Parent1/demo.dart';
import 'package:eskool/services/parentService.dart';
import 'package:flutter/material.dart';
// import '../../../models/ParentModel.dart';
import 'add_edit_parent_form.dart';
import 'parent_detail_scree.dart';

class ParentListScreen extends StatefulWidget {
  @override
  _ParentListScreenState createState() => _ParentListScreenState();
}

class _ParentListScreenState extends State<ParentListScreen> {
  late Future<List<Parent>> futureParents;
  final ParentService parentService = ParentService();

  @override
  void initState() {
    super.initState();
    // Fetch the list of Parents when the screen is initialized
    futureParents = parentService.fetchParents();
  }

  // Method to add a new Parent to the list
  void _addParent(Parent parent) {
    setState(() {
      futureParents = parentService.fetchParents();
    });
  }

  void _editParent(Parent updatedParent) {
    setState(() {
      futureParents = parentService.fetchParents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveDrawerLayout(
      content: Column(
        children: [
          CustomAppbar(
            showBackButton: true,
            showSearch: true,
            hinttext: "Parent",
          ),
          CustomButton(
            label: "Create",
            color: Colors.blue,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditParentScreen(
                    onAddParent:
                        _addParent, // Pass the callback to add a Parent
                  ),
                ),
              ).then((_) {
                // Correct syntax for the then method
                setState(() {
                  futureParents = parentService.fetchParents();
                });
              }).catchError((error) {
                // Handle errors if needed
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: $error')),
                );
              });
            },
          ),
          Expanded(
            child: FutureBuilder<List<Parent>>(
              future: futureParents,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No Parents found.'));
                } else {
                  final parents = snapshot.data!;
                  return ListView.builder(
                    itemCount: parents.length,
                    itemBuilder: (context, index) {
                      final parent = parents[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ParentDetailScreen(parent: parent),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 4,
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  parent.fullName ?? 'No Name',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Email: ${parent.email ?? 'No Email'}',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AddEditParentScreen(
                                              parent: parent,
                                              onEditParent: (updatedParent) {
                                                _editParent(
                                                    updatedParent); // Call the edit method
                                              },
                                            ),
                                          ),
                                        ).then((_) {
                                          // Optionally, you can refresh the state if needed
                                          setState(() {
                                            futureParents =
                                                parentService.fetchParents();
                                          });
                                        });
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () async {
                                        final confirm = await showDialog<bool>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Confirm Deletion'),
                                              content: Text(
                                                  'Are you sure you want to delete this Parent?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(false),
                                                  child: Text('Cancel'),
                                                ),
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(true),
                                                  child: Text('Delete'),
                                                ),
                                              ],
                                            );
                                          },
                                        );

                                        if (confirm == true) {
                                          try {
                                            print(
                                                'Deleting Parent with ID: ${parent.id}');

                                            // Call the deleteParent function
                                            await parentService
                                                .deleteParent(parent.id!);

                                            // Show success message
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                  content: Text(
                                                      'Parent deleted successfully!')),
                                            );

                                            // Refresh the list of Parents
                                            setState(() {
                                              futureParents = parentService
                                                  .fetchParents(); // Refresh the list
                                            });
                                          } catch (e) {
                                            // Show error message if the deletion fails
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                  content: Text('Error: $e')),
                                            );
                                          }
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
