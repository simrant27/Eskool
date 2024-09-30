import 'package:eskool/users/component/CustomScaffold.dart';
import 'package:eskool/users/component/customAppBar2.dart';
import 'package:eskool/users/component/customButtonStyle.dart';
import 'package:flutter/material.dart';

import '../../Screens/admin/billing/data/studentList.dart';
import '../../Screens/admin/billing/fetchData/studentFetch.dart';
import '../../constants/constants.dart';
import '../../data/class_list.dart';
import 'package:http/http.dart' as http;

class Resultassign extends StatefulWidget {
  const Resultassign({super.key});

  @override
  State<Resultassign> createState() => _ResultassignState();
}

class _ResultassignState extends State<Resultassign> {
  String? selectedClass;
  List<Student> students = [];
  bool isLoading = false;

  // Function to call fetchStudentsByClass and update the UI
  Future<void> fetchClassStudents() async {
    if (selectedClass != null) {
      setState(() {
        isLoading = true;
        print('Fetching students for class: $selectedClass');
      });

      try {
        // Directly fetch students for the selected class from the API
        List<Student> fetchedStudents =
            await fetchStudentsByClass(selectedClass!);

        setState(() {
          students = fetchedStudents;
          isLoading = false;
          print('Fetched students: $students');
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
  // Ensure you have a way to collect marks for each student
  for (var student in students) {
    // Here you may want to collect marks for each student from a form field
    // You might want to implement a map or a list to collect this data
    var marks = ...; // Get marks for this student

    try {
      final response = await http.post(
        Uri.parse('$url/api/result/assign-marks/:${student.id}'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'teacherId': yourTeacherId, // Pass the logged-in teacher's ID
          'subject': , // Subject for which marks are assigned
          'marks': marks,
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Results assigned successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.body}')),
        );
      }
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
          SizedBox(height: 30),
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
                                child: ListTile(
                                  title: Text(student.fullName),
                                  subtitle:
                                      Text('Class: ${student.classAssigned}'),
                                  trailing: SizedBox(
                                    width: 100, // Adjust width for your layout
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        // You may want to store this value for later use
                                      },
                                      style: TextStyle(fontSize: 18),
                                      decoration: InputDecoration(
                                        labelText: 'Marks',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                  onTap: () {},
                                ),
                              );
                            },
                          ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: customButtonStyle,
            onPressed: submitResults, // Call the submit function
            child: Text('Assign Results'),
          ),
        ],
      ),
      appBar: customAppBar2("Assign Result"),
    );
  }
}
// /api/result/assign-marks/:studentId