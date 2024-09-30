import 'dart:convert';

import 'package:eskool/users/component/CustomScaffold.dart';
import 'package:eskool/users/component/customAppBar2.dart';
import 'package:eskool/users/component/customButtonStyle.dart';
import 'package:flutter/material.dart';

import '../../Screens/admin/billing/data/studentList.dart';
import '../../Screens/admin/billing/fetchData/studentFetch.dart';
import '../../constants/constants.dart';
import '../../data/class_list.dart';
import 'package:http/http.dart' as http;

import '../component/CustomAlertDialogBox.dart';

class Resultassign extends StatefulWidget {
  final String subject;
  final String teacherId;
  const Resultassign(
      {required this.subject, required this.teacherId, super.key});

  @override
  State<Resultassign> createState() => _ResultassignState();
}

class _ResultassignState extends State<Resultassign> {
  String? selectedClass;
  List<Student> students = [];
  bool isLoading = false;
  Map<String, double> marks = {}; // Map to hold marks for each student

  final _formKey = GlobalKey<FormState>(); // To handle validation

  /// Function to call fetchStudentsByClass and update the UI
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

  // Function to handle result assignment submission
  void submitResults() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Loop through the students and assign marks for each one
        for (var student in students) {
          // Check if marks are assigned for the current student
          if (marks.containsKey(student.id)) {
            final response = await http.post(
              Uri.parse('$url/api/result/assign-marks/${student.id}'),
              headers: {
                'Content-Type': 'application/json',
              },
              body: json.encode({
                'studentId': student.id,
                'teacherId':
                    widget.teacherId, // Pass the logged-in teacher's ID
                'subject':
                    widget.subject, // Subject for which marks are assigned
                'marks': marks[student.id], // Pass the student's marks
              }),
            );

            if (response.statusCode == 200) {
              await customAlertDialogBox(
                context,
                "Assign Marks",
                'Mark has been assigned .',
                [
                  TextButton(
                    onPressed: () {
                      print(
                          " marks assign ${marks[student.id]} for ${widget.subject}");
                      Navigator.pop(context); // Close the confirmation dialog
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
              print('Results assigned successfully for ${student.fullName}');
            } else {
              await customAlertDialogBox(
                context,
                "Error!",
                "Failed to assign Marks",
                [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the confirmation dialog
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
              print('Error: ${response.body} for ${student.fullName}');
            }
          }
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Results assigned successfully!')),
        );
      } catch (error) {
        print('Error occurred while assigning results: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to assign results: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Select Class',
                border: OutlineInputBorder(),
              ),
              value: selectedClass,
              items: classList.isNotEmpty
                  ? classList.map((classAssigned) {
                      return DropdownMenuItem(
                        value: classAssigned,
                        child: Text('Class $classAssigned'),
                      );
                    }).toList()
                  : [
                      const DropdownMenuItem(
                        value: null,
                        child: Text('No classes available'),
                      ),
                    ],
              onChanged: (value) {
                setState(() {
                  selectedClass = value;
                  print('Selected class: $selectedClass');
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
                                child: Form(
                                  key: _formKey,
                                  child: ListTile(
                                    title: Text(student.fullName),
                                    subtitle:
                                        Text('Class: ${student.classAssigned}'),
                                    trailing: SizedBox(
                                      width:
                                          100, // Adjust width for your layout
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          setState(() {
                                            // Store marks for this student
                                            marks[student.id] =
                                                double.tryParse(value) ?? 0.0;
                                          });
                                        },
                                        style: const TextStyle(fontSize: 18),
                                        decoration: const InputDecoration(
                                          labelText: 'Marks',
                                          border: OutlineInputBorder(),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Enter marks';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: customButtonStyle,
            onPressed: submitResults, // Call the submit function
            child: const Text('Assign Results'),
          ),
        ],
      ),
      appBar: customAppBar2("Assign Marks for ${widget.subject}"),
    );
  }
}
