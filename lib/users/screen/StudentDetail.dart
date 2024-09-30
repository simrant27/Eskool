import 'package:eskool/users/component/CustomScaffold.dart';
import 'package:eskool/users/component/RectangleBox.dart';
import 'package:eskool/users/component/customAppBar2.dart';
import 'package:eskool/users/screen/finance.dart';
import 'package:eskool/users/screen/seeResult.dart';
import 'package:flutter/material.dart';

import '../data/menuItems.dart';

class StudentDetailScreen extends StatelessWidget {
  final String studentName;
  final String studentGrade;
  final String studentId;

  StudentDetailScreen({
    required this.studentName,
    required this.studentGrade,
    required this.studentId,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: $studentName',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              'Grade: $studentGrade',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Details:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: FutureBuilder<List<MenuItem>>(
                future: menuItems(context), // Fetch menu items asynchronously
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    List<MenuItem> filteredMenuItems = snapshot.data!
                        .where((item) =>
                                item.title == 'Finance' ||
                                item.title == 'Result'
                            // ||item.title == 'Assignment'
                            )
                        .toList();

                    return ListView.builder(
                      itemCount: filteredMenuItems.length,
                      itemBuilder: (context, index) {
                        MenuItem menuItem = filteredMenuItems[index];
                        return GestureDetector(
                          onTap: () {
                            // Handle navigation based on the menu item title
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  switch (menuItem.title) {
                                    case 'Finance':
                                      return FinanceBillScreen(
                                          studentId: studentId,
                                          studentName: studentName);
                                    case 'Result':
                                      return Seeresult(
                                          studentId: studentId,
                                          studentName: studentName);
                                    // Add a case for 'Assignment' if needed
                                    default:
                                      return Container(); // Fallback case
                                  }
                                },
                              ),
                            );
                          },
                          child: RectangleBox(menuItem.title),
                        );
                      },
                    );
                  } else {
                    return Center(child: Text('No menu items available'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
      appBar: customAppBar2("Student Detail"),
    );
  }
}
