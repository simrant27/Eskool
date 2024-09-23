import 'package:eskool/Screens/admin/admindashboard/components/customAppbar.dart';
import 'package:eskool/Screens/admin/admindashboard/components/responsive_drawer_layout.dart';
import 'package:flutter/material.dart';

class BillingPage extends StatefulWidget {
  const BillingPage({super.key});

  @override
  _BillingPageState createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {
  String? selectedClass;
  final List<String> classes = [
    'Class 1',
    'Class 2',
    'Class 3',
    'Class 4',
    'Class 5'
  ];

  // Sample student data, replace with your backend API call
  final Map<String, List<Map<String, dynamic>>> studentsData = {
    'Class 1': [
      {'name': 'John Doe', 'status': 'Paid', 'dueAmount': 0},
      {'name': 'Jane Doe', 'status': 'Due', 'dueAmount': 5000},
    ],
    'Class 2': [
      {'name': 'Alice Smith', 'status': 'Paid', 'dueAmount': 0},
      {'name': 'Bob Brown', 'status': 'Overdue', 'dueAmount': 7000},
    ],
    'Class 3': [
      {'name': 'Charlie Adams', 'status': 'Paid', 'dueAmount': 0},
    ],
    // Add more students for other classes
  };

  List<Map<String, dynamic>> getStudentsByClass(String? className) {
    if (className == null || !studentsData.containsKey(className)) {
      return [];
    }
    return studentsData[className]!;
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveDrawerLayout(
      content: Column(
        children: [
          CustomAppbar(
            showSearch: true,
            hinttext: "students",
            onChanged: (value) {
              // Implement search logic here if needed
            },
          ),
          SizedBox(height: 20),
          // Class Selection Dropdown
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Select Class',
                border: OutlineInputBorder(),
              ),
              value: selectedClass,
              items: classes.map((className) {
                return DropdownMenuItem(
                  value: className,
                  child: Text(className),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedClass = value;
                });
              },
            ),
          ),
          SizedBox(height: 20),
          // Display students based on the selected class
          Expanded(
            child: selectedClass == null
                ? Center(
                    child: Text(
                      'Please select a class to view students',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: getStudentsByClass(selectedClass).length,
                    itemBuilder: (context, index) {
                      final student = getStudentsByClass(selectedClass)[index];
                      return Card(
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: ListTile(
                          title: Text(student['name']),
                          subtitle: Text('Status: ${student['status']}'),
                          trailing: Text(
                            student['status'] == 'Paid'
                                ? 'Paid'
                                : 'Due: ${student['dueAmount']}',
                            style: TextStyle(
                              color: student['status'] == 'Paid'
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                          onTap: () {
                            // Handle student details tap, for example show payment history
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
