// lib/data/student_data.dart

import 'package:eskool/models/Students_model.dart';

final Map<String, List<Student>> classWiseStudents = {
  'Class 1': [
    Student(
      name: "John Doe",
      rollNo: "1",
      grade: "A",
      parentName: "Jane Doe",
      className: 'Class 1',
      status: 'Paid',
      dueAmount: 0,
    ),
    Student(
      name: "Emma Watson",
      rollNo: "2",
      grade: "B",
      parentName: "Richard Watson",
      className: 'Class 1',
      status: 'Due',
      dueAmount: 5000,
    ),
  ],
  'Class 2': [
    Student(
      name: "Chris Evans",
      rollNo: "3",
      grade: "A",
      parentName: "Lisa Evans",
      className: 'Class 2',
      status: 'Paid',
      dueAmount: 0,
    ),
    Student(
      name: "Scarlett Johansson",
      rollNo: "4",
      grade: "B",
      parentName: "Paul Johansson",
      className: 'Class 2',
      status: 'Due',
      dueAmount: 7000,
    ),
  ],
  'Class 3': [
    Student(
      name: "Charlie Adams",
      rollNo: "5",
      grade: "A",
      parentName: "Alice Adams",
      className: 'Class 3',
      status: 'Paid',
      dueAmount: 0,
    ),
    Student(
      name: "Sophia Brown",
      rollNo: "6",
      grade: "B",
      parentName: "David Brown",
      className: 'Class 3',
      status: 'Overdue',
      dueAmount: 3000,
    ),
  ],
  // Add more classes and students here...
};
