import 'package:flutter/material.dart';
import '../../../data/class_list.dart';
import '../../../data/feeList.dart'; // Fee list containing available fees
import '../../../data/student_data.dart'; // Contains student data
import '../../../models/Students_model.dart';
import '../admindashboard/components/customAppbar.dart';
import '../admindashboard/components/responsive_drawer_layout.dart';

class FeeAssignPage extends StatefulWidget {
  @override
  _FeeAssignPageState createState() => _FeeAssignPageState();
}

class _FeeAssignPageState extends State<FeeAssignPage> {
  // Store fee amounts for each student
  Map<Student, Map<String, double>> feeAmounts = {};
  // Store global amounts for fees
  Map<String, double> globalAmounts = {};
  // Store checkbox selections for each fee
  Map<String, bool> feeSelections = {};
  // Selected class from dropdown
  String selectedClass = 'Class 1';

  @override
  void initState() {
    super.initState();
    // Initialize amounts and selections for the default selected class (Class 1)
    initializeFeeAmountsForClass(selectedClass);
  }

  void initializeFeeAmountsForClass(String className) {
    List<Student> students = classWiseStudents[className] ?? [];
    feeAmounts.clear();

    for (var student in students) {
      feeAmounts[student] = {
        for (var fee in fees) fee: 0.0
      }; // Initialize amounts
    }

    for (var fee in fees) {
      globalAmounts[fee] = 0.0; // Initialize global amounts
      feeSelections[fee] = false; // Initialize checkbox selections
    }
  }

  void updateFeeAmounts() {
    List<Student> students = classWiseStudents[selectedClass] ?? [];
    for (var student in students) {
      for (var fee in fees) {
        if (feeSelections[fee] == true) {
          // If the checkbox is selected, update with the global amount
          feeAmounts[student]![fee] = globalAmounts[fee]!;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Student> students = classWiseStudents[selectedClass] ?? [];

    return ResponsiveDrawerLayout(
      content: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppbar(
              showSearch: true,
              hinttext: "students",
              onChanged: (value) {
                // Implement search logic if needed
              },
            ),
            // Class Selection Dropdown
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DropdownButton<String>(
                value: selectedClass,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedClass = newValue!;
                    initializeFeeAmountsForClass(selectedClass);
                  });
                },
                items: classList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            // Global Amounts Input
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: fees.map((fee) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 60.0, // Set the height you want
                        width: 200.0, // Set the width you want
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Enter $fee Amount',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              globalAmounts[fee] =
                                  double.tryParse(value) ?? 0.0;
                            });
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Text("For All: "),
                          Checkbox(
                            value: feeSelections[fee],
                            onChanged: (value) {
                              setState(() {
                                feeSelections[fee] = value ?? false;
                              });
                            },
                          ),
                          ElevatedButton(
                            onPressed: () {
                              updateFeeAmounts(); // Update amounts when button is pressed
                            },
                            child: Text('Done'),
                          ),
                        ],
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
            // Table for Student Fees
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: DataTable(
                columns: [
                  DataColumn(
                    label: Text(
                      'Student Name',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Class',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  ...fees.map((fee) => DataColumn(
                        label: Text(
                          fee,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      )), // Create a column for each fee
                ],
                rows: students.map((student) {
                  return DataRow(cells: [
                    DataCell(
                      Text(
                        student.name,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    DataCell(
                      Text(
                        student.className,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    ...fees.map((fee) {
                      return DataCell(
                        TextFormField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              // Retain the manually entered amount
                              feeAmounts[student]![fee] =
                                  double.tryParse(value) ?? 0.0;
                            });
                          },
                          initialValue: feeAmounts[student]![fee]?.toString(),
                          style: TextStyle(fontSize: 18),
                        ),
                      );
                    }).toList(),
                  ]);
                }).toList(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Collect amounts for each student
                students.forEach((student) {
                  var amounts = feeAmounts[student];
                  print('Amounts for ${student.name}: $amounts');
                  // Handle the logic to proceed with these amounts (save to backend, etc.)
                });
              },
              child: const Text('Confirm Selections'),
            ),
          ],
        ),
      ),
    );
  }
}
