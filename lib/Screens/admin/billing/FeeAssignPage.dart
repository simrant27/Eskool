import 'package:flutter/material.dart';
import '../../../users/component/customButtonStyle.dart';
import '../admindashboard/components/customAppbar.dart';
import '../admindashboard/components/responsive_drawer_layout.dart';
import 'component/updateAndDeleteFee.dart';
import 'data/class_list.dart';
import 'data/feeList.dart';
import 'data/studentList.dart';
import 'fetchData/studentFetch.dart';

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
  String selectedClass = '1';
  List<Student> students = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Initialize amounts and selections for the default selected class
    initializeFeeAmountsForClass(selectedClass);
  }

  // Fetch and initialize fee amounts and selections for each student in the class
  Future<void> initializeFeeAmountsForClass(String className) async {
    setState(() {
      isLoading = true; // Show loading indicator
      feeAmounts.clear();
      globalAmounts.clear();
      feeSelections.clear();
    });

    List<Student> fetchedStudents = await fetchStudentsByClass(className);

    setState(() {
      students = fetchedStudents;

      for (var student in students) {
        feeAmounts[student] = {
          for (var fee in fees) fee: 0.0
        }; // Initialize amounts
      }

      for (var fee in fees) {
        globalAmounts[fee] = 0.0; // Initialize global fee amounts
        feeSelections[fee] = false; // Initialize fee selection checkboxes
      }

      isLoading = false; // Hide loading indicator
    });
  }

  // Update fees for all students based on global amounts and selections
  void updateFeeForAllStudents() {
    for (var student in feeAmounts.keys) {
      for (var fee in fees) {
        if (feeSelections[fee] == true && globalAmounts[fee]! > 0) {
          // Only update fees for the selected fees with non-zero amounts
          updateFee(student.id, fee, globalAmounts[fee]!, '2024-12-30');
        }
      }
    }
  }

  // Delete fees for all students for selected fees
  void deleteFeeForAllStudents() {
    for (var student in feeAmounts.keys) {
      for (var fee in fees) {
        if (feeSelections[fee] == true) {
          deleteFee(student.id, fee);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.deepPurple[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.deepPurple, width: 2),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: DropdownButton<String>(
                  value: selectedClass,
                  icon: Icon(Icons.arrow_drop_down, color: Colors.deepPurple),
                  iconSize: 24,
                  elevation: 16,
                  dropdownColor: Colors.deepPurple[50],
                  underline: SizedBox(),
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedClass = newValue!;
                      initializeFeeAmountsForClass(selectedClass);
                    });
                  },
                  items:
                      classList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),

            // Loading Indicator
            if (isLoading) CircularProgressIndicator(),

            // Global Fee Inputs for all students
            if (!isLoading) ...[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: fees.map((fee) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 60.0,
                          width: 200.0,
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
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              feeSelections[fee] = !feeSelections[fee]!;
                            });
                          },
                          child:
                              Text(feeSelections[fee]! ? 'Selected' : 'Select'),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),

              // Table for student-specific fees
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: DataTable(
                  columns: [
                    DataColumn(
                      label: Text(
                        'Student Name',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Class',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    ...fees.map((fee) => DataColumn(
                          label: Text(
                            fee,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        )),
                  ],
                  rows: students.map((student) {
                    return DataRow(cells: [
                      DataCell(
                        Text(
                          student.fullName,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      DataCell(
                        Text(
                          student.classAssigned,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      ...fees.map((fee) {
                        return DataCell(
                          TextFormField(
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
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

              // Buttons to update or delete fees
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        updateFeeForAllStudents(); // Update fees
                      },
                      style: customButtonStyle,
                      child: const Text('Update Fee'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        deleteFeeForAllStudents(); // Delete fees
                      },
                      style: customButtonStyle,
                      child: const Text('Delete Fee'),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
