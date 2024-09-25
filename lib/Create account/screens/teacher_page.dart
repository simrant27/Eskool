import 'package:flutter/material.dart';
import '../componets/teacher_form_popup.dart';
import '../Widgets/teacher_card.dart';

class TeacherPage extends StatefulWidget {
  @override
  _TeacherPageState createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  List<Map<String, dynamic>> teachers = [];

  void _addTeacher(Map<String, dynamic> teacher) {
    setState(() {
      teachers.add(teacher);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Teachers'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return TeacherFormPopup(onSubmit: _addTeacher);
                },
              );
            },
            child: Text('Add Teacher'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: teachers.length,
              itemBuilder: (context, index) {
                return TeacherCard(teacher: teachers[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
