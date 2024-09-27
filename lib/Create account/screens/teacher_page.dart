import 'package:eskool/Screens/admin/admindashboard/components/customAppbar.dart';
import 'package:eskool/Screens/admin/admindashboard/components/responsive_drawer_layout.dart';
import 'package:flutter/material.dart';
import '../componets/teacher_form_popup.dart'; // Assuming TeacherFormPopup exists
import '../Widgets/teacher_card.dart'; // TeacherCard widget

class TeacherPage extends StatefulWidget {
  @override
  _TeacherPageState createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  List<Map<String, dynamic>> teachers = [];

  // Add Teacher
  void _addTeacher(Map<String, dynamic> teacher) {
    setState(() {
      teachers.add(teacher);
    });
  }

  // Edit Teacher
  void _editTeacher(Map<String, dynamic> updatedTeacher, int index) {
    setState(() {
      teachers[index] = updatedTeacher;
    });
  }

  // Delete Teacher
  void _deleteTeacher(int index) {
    setState(() {
      teachers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveDrawerLayout(
      content: Column(
        children: [
          CustomAppbar(
            showSearch: true,
            hinttext: "teachers",
          ),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return TeacherFormPopup(
                      onSubmit:
                          _addTeacher); // Assuming TeacherFormPopup exists
                },
              );
            },
            child: Text('Add Teacher'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: teachers.length,
              itemBuilder: (context, index) {
                return TeacherCard(
                  teacher: teachers[index],
                  onEdit: (updatedTeacher) {
                    _editTeacher(
                        updatedTeacher, index); // Pass updated teacher data
                  },
                  onDelete: () {
                    _deleteTeacher(index); // Handle delete
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
