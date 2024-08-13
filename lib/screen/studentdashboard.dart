// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../component/Drawerlist.dart';
import '../component/boxDesign.dart';
import '../component/customAppBar.dart';
import '../component/customBox.dart';
import '../data/data.dart';

class Studentdashboard extends StatelessWidget {
  const Studentdashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      drawer: drawerlist(),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                decoration: boxDesign(),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: Column(children: [
                  Container(
                    alignment: Alignment.centerRight,
                    child: RichText(
                      text: TextSpan(
                          text: "wed",
                          style: TextStyle(
                            color: Color.fromARGB(
                                255, 46, 121, 214), // Correct usage
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                          ),
                          children: [
                            TextSpan(
                              text: " 10 Oct",
                              style: TextStyle(
                                  color: Color(0XFF263064),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            )
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(width: 1, color: Colors.white),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueGrey.withOpacity(0.2),
                              blurRadius: 12,
                              spreadRadius: 8,
                            )
                          ],
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://images.unsplash.com/photo-1541647376583-8934aaf3448a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1234&q=80"),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          introduction['greeting']!,
                          SizedBox(height: 10),
                          introduction['RegNO']!,
                          SizedBox(height: 6),
                          introduction['Standard']!,
                          SizedBox(height: 8)
                        ],
                      )
                    ],
                  )
                ]),
              ),
              Positioned(
                top: 185,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: MediaQuery.of(context).size.height - 245,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ListView(),
                ),
              )
            ],
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                customBox('Employee', Icons.lock),
                customBox('Parents', Icons.person),
                customBox('Students', Icons.people),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
