import 'package:flutter/material.dart';
import '../../../data/class_list.dart';
import '../../../users/component/customButtonStyle.dart';
import '../admindashboard/components/customAppbar.dart';
import '../admindashboard/components/responsive_drawer_layout.dart';
import 'component/updateAndDeleteFee.dart';
import 'data/feeList.dart';
import 'data/studentList.dart';
import 'fetchData/studentFetch.dart';

class FeeAssignPage extends StatefulWidget {
  @override
  _FeeAssignPageState createState() => _FeeAssignPageState();
}

class _FeeAssignPageState extends State<FeeAssignPage> {
  Map<Student, Map<String, double>> feeAmounts = {};
  Map<String, double> globalAmounts = {};
  Map<String, bool> feeSelections = {};
  String selectedClass = '1';
  List<Student> students = [];
  bool isLoading = true;

  final TextEditingController tutionController = TextEditingController();
  final TextEditingController sportsController = TextEditingController();
  final TextEditingController libraryController = TextEditingController();
  final TextEditingController extraController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initializeFeeAmountsForClass(selectedClass);
  }

  Future<void> initializeFeeAmountsForClass(String className) async {
    setState(() {
      isLoading = true;
      feeAmounts.clear();
      globalAmounts.clear();
      feeSelections.clear();
    });

    List<Student> fetchedStudents = await fetchStudentsByClass(className);

    setState(() {
      students = fetchedStudents;

      for (var student in students) {
        feeAmounts[student] = {for (var fee in fees) fee: 0.0};
      }

      for (var fee in fees) {
        globalAmounts[fee] = 0.0;
        feeSelections[fee] = false;
      }

      isLoading = false;
    });
  }

  void updateFeeForAllStudents() {
    for (var student in feeAmounts.keys) {
      for (var fee in fees) {
        if (feeSelections[fee] == true && globalAmounts[fee]! > 0) {
          updateFee(student.id, fee, globalAmounts[fee]!, '2024-12-30');
        }
      }
    }
  }

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
              hinttext: "Search for students",
              onChanged: (value) {},
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.deepPurple[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black38, width: 2),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: DropdownButton<String>(
                  value: selectedClass,
                  icon: Icon(Icons.arrow_drop_down, color: Colors.deepPurple),
                  iconSize: 24,
                  elevation: 16,
                  dropdownColor: Colors.white38,
                  underline: SizedBox(),
                  style: TextStyle(
                    color: Colors.black87,
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
                      child: Text("Class $value"),
                    );
                  }).toList(),
                ),
              ),
            ),
            if (isLoading) CircularProgressIndicator(),
            if (!isLoading) ...[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: fees.map((fee) {
                    return Expanded(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 60.0,
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
                                // Logic to assign this fee to all students
                                for (var student in students) {
                                  feeAmounts[student]![fee] =
                                      globalAmounts[fee]!;
                                }
                              });
                            },
                            child: Text("Assign For All"),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: DataTable(
                  columns: [
                    DataColumn(
                      label: Text('Student Name',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                    ),
                    DataColumn(
                      label: Text('Class',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                    ),
                    ...fees.map((fee) => DataColumn(
                          label: Text(fee,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                        )),
                  ],
                  rows: students.map((student) {
                    return DataRow(cells: [
                      DataCell(Text(student.fullName,
                          style: TextStyle(fontSize: 18))),
                      DataCell(Text(student.classAssigned,
                          style: TextStyle(fontSize: 18))),
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
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: updateFeeForAllStudents,
                      style: customButtonStyle,
                      child: const Text('Update Fee'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: deleteFeeForAllStudents,
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
