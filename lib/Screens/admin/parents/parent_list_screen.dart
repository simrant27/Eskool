import 'package:eskool/models/parentModel.dart';
import 'package:flutter/material.dart';

import 'create_parent.dart';

class ParentListScreen extends StatefulWidget {
  @override
  _ParentListScreenState createState() => _ParentListScreenState();
}

class _ParentListScreenState extends State<ParentListScreen> {
  List<Parent> parents = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // fetchParents();
  }

  // void fetchParents() async {
  //   try {
  //     List<Parent> fetchedParents = await ParentService.fetchParents();
  //     setState(() {
  //       parents = fetchedParents;
  //       isLoading = false;
  //     });
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }

  // void deleteParent(String id) async {
  //   await ParentService.deleteParent(id);
  //   fetchParents(); // Refresh the list after deletion
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Parents List')),
      // body:
      //  isLoading
      //     ? Center(child: CircularProgressIndicator())
      //     : ListView.builder(
      //         itemCount: parents.length,
      //         itemBuilder: (context, index) {
      //           Parent parent = parents[index];
      //           return ListTile(
      //             title: Text(parent.fullName),
      //             subtitle: Text(parent.email),
      //             onTap: () => Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => ParentDetail(parent: parent),
      //               ),
      //             ),
      //             trailing: Row(
      //               mainAxisSize: MainAxisSize.min,
      //               children: [
      //                 IconButton(
      //                   icon: Icon(Icons.edit),
      //                   onPressed: () => Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                       builder: (context) => EditParent(parent: parent),
      //                     ),
      //                   ),
      //                 ),
      //                 IconButton(
      //                   icon: Icon(Icons.delete),
      //                   onPressed: () => deleteParent(parent.id),
      //                 ),
      //               ],
      //             ),
      //           );
      //         },
      //       ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ParentFormPage()),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
