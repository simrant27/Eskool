import 'package:flutter/material.dart';

import '../../../data/class_list.dart';
import '../../../data/feeList.dart';
import '../../../data/student_data.dart';
import '../../../models/Students_model.dart';
import '../admindashboard/components/customAppbar.dart';
import '../admindashboard/components/responsive_drawer_layout.dart';
import 'FeeAssignPage.dart';
import 'component/showAmountDilog.dart';
import 'component/showFeeDilog.dart';

class BillingPage extends StatefulWidget {
  const BillingPage({Key? key}) : super(key: key);

  @override
  _BillingPageState createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {
  String? selectedClass;

  // Fetch students by selected class from classWiseStudents
  List<Student> getStudentsByClass(String? className) {
    if (className == null || !classWiseStudents.containsKey(className)) {
      return [];
    }
    return classWiseStudents[className]!;
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
              items: classList.map((className) {
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
          const SizedBox(height: 20),
          // Display students based on the selected class
          Expanded(
            child: selectedClass == null
                ? const Center(
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
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: ListTile(
                          title: Text(student.name),
                          subtitle: Text('Status: ${student.status}'),
                          trailing: Text(
                            student.status == 'Paid'
                                ? 'Paid'
                                : 'Due: ${student.dueAmount}',
                            style: TextStyle(
                              color: student.status == 'Paid'
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
                                  fees: fees,
                                  student: student,
                                  confirm: (feeSelections) {
                                    // Get selected fees
                                    List<String> selectedFees = feeSelections
                                        .entries
                                        .where((entry) => entry.value)
                                        .map((entry) => entry.key)
                                        .toList();

                                    if (selectedFees.isEmpty) {
                                      // Show an error message if no fees are selected
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Please select at least one fee.'),
                                        ),
                                      );
                                      return; // Exit if no fees are selected
                                    }

                                    Navigator.pop(
                                        context); // Close the selection dialog

                                    // Show the amount entry dialog
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ShowAmountEntryDialog(
                                          selectedFees: selectedFees,
                                          student: student,
                                        );
                                      },
                                    );
                                  },
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
          ElevatedButton(
            onPressed: () {
              // Fetch all students from the selected class
              final selectedStudents = getStudentsByClass(selectedClass);

              if (selectedStudents.isNotEmpty) {
                // Show the fee dialog for all students in the selected class
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FeeAssignPage(
                        students: selectedStudents), // Pass actual students
                  ),
                );
              } else {
                // Show an error message if no students are found
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('No students in selected class.'),
                  ),
                );
              }
            },
            child: const Text('For All'),
          ),
        ],
      ),
    );
  }
}
