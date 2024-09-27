import 'package:eskool/users/component/customButtonStyle.dart';
import 'package:flutter/material.dart';

import '../admindashboard/components/customAppbar.dart';
import '../admindashboard/components/responsive_drawer_layout.dart';
import 'FeeAssignPage.dart';
import 'component/showFeeDilog.dart';
import 'data/class_list.dart';
import 'data/feeList.dart';
import 'data/studentList.dart';
import 'fetchData/studentFetch.dart';

class BillingPage extends StatefulWidget {
  const BillingPage({Key? key}) : super(key: key);

  @override
  _BillingPageState createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {
  String? selectedClass;
  List<Student> students = [];
  bool isLoading = false;

// Function to call fetchStudentsByClass and update the UI
  Future<void> fetchClassStudents() async {
    if (selectedClass != null) {
      setState(() {
        isLoading = true;
        print(
            ' from fetchClassStudents $selectedClass'); // Show loading indicator while fetching
      });

      try {
        // Directly fetch students for the selected class from the API
        List<Student> fetchedStudents =
            await fetchStudentsByClass(selectedClass!);

        setState(() {
          students = fetchedStudents;
          isLoading = false;
          print('$students'); // Hide loading indicator
        });
      } catch (error) {
        setState(() {
          isLoading = false; // Hide loading indicator on error
        });
        print('Error occurred: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching students: $error')),
        );
      }
    }
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
          const SizedBox(height: 20),
          // Class Selection Dropdown
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Select Class',
                border: OutlineInputBorder(),
              ),
              value: selectedClass,
              items: classList.map((classAssigned) {
                return DropdownMenuItem(
                  value: classAssigned,
                  child: Text('Class $classAssigned'),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedClass = value;
                  print('from DropdownMenuItem $selectedClass');
                });
                fetchClassStudents(); // Fetch students when the class changes
              },
            ),
          ),
          const SizedBox(height: 20),
          // Display students or loading indicator
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : selectedClass == null
                    ? const Center(
                        child: Text(
                          'Please select a class to view students',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      )
                    : students.isEmpty
                        ? const Center(
                            child: Text(
                                'No students found for the selected class'),
                          )
                        : ListView.builder(
                            itemCount: students.length,
                            itemBuilder: (context, index) {
                              final student = students[index];
                              return Card(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                child: ListTile(
                                  title: Text(student.fullName),
                                  subtitle: Text('Status: ${student.status}'),
                                  trailing: Text(
                                    student.status == true ? 'Paid' : 'Due',
                                    style: TextStyle(
                                      color: student.status == true
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ),
                                  onTap: () {
                                    // Navigate to the ShowFeeDialog for the individual student
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return ShowFeeDialog(
                                          fees:
                                              fees, // Pass the appropriate fee list
                                          student: student,
                                        );
                                      },
                                    );
                                  },
                                ),
                              );
                            },
                          ),
          ),

          const SizedBox(height: 20),
          // Button to navigate to FeeAssignPage for all students
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FeeAssignPage(),
                ),
              );
            },
            style: customButtonStyle,
            child: const Text('For All'),
          ),
        ],
      ),
    );
  }
}
