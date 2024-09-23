// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../data/student.dart';
import 'customAppBar2.dart';
import 'customBottomAppBar.dart';

class StudentListWidget extends StatelessWidget {
  final Widget Function(Map<String, dynamic> student) onSelectRoute;

  StudentListWidget({required this.onSelectRoute});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar2("Select Student"),
      body: Column(
        children: [
          SizedBox(height: 40),
          Center(
            child: Text(
              "Please select a student ",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 40),
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => onSelectRoute(student)),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 10), // Adjust margin for spacing
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 127, 195, 224),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        student['name'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomAppBar(),
    );
  }
}
