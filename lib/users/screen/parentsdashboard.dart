// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../component/Drawerlist.dart';
import '../component/boxDesign.dart';
import '../component/customAppBar.dart';
import '../component/customBottomAppBar.dart';
import '../component/customBox.dart';
import '../data/colorCombination.dart';
import '../data/data.dart';
import '../data/menuItems.dart';
import '../data/userImage.dart';

class Parentsdashboard extends StatelessWidget {
  const Parentsdashboard({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String dayOfWeekShort = DateFormat('EEE').format(now);
    String day = DateFormat('d').format(now);
    String monthShort = DateFormat('MMM').format(now);

    return Scaffold(
      appBar: customAppBar("Dashboard"),
      drawer: drawerlist(context),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity, // Use full width
                height: MediaQuery.of(context).size.height / 3.7,
                decoration: boxDesign(),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      child: RichText(
                        text: TextSpan(
                          text: dayOfWeekShort,
                          style: TextStyle(
                            color: Color.fromARGB(255, 46, 121, 214),
                            fontSize: MediaQuery.of(context).size.height / 45,
                            fontWeight: FontWeight.w900,
                          ),
                          children: [
                            TextSpan(
                              text: ' $day $monthShort',
                              style: TextStyle(
                                color: Color(0XFF263064),
                                fontSize:
                                    MediaQuery.of(context).size.height / 50,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.height / 15,
                          height: MediaQuery.of(context).size.height / 15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(width: 1, color: Colors.white),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blueGrey.withOpacity(0.2),
                                blurRadius: 12,
                                spreadRadius: 8,
                              ),
                            ],
                            image: userImage(),
                          ),
                        ),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            introduction['greeting'] ??
                                Text(''), // Ensure fallback values
                            SizedBox(height: 10),
                            introduction['email'] ?? Text(''),
                            SizedBox(height: 6),
                            introduction['number'] ?? Text(''),
                            SizedBox(height: 8),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 30,
                    childAspectRatio: 1.0, // Adjusted for square items
                  ),
                  itemCount: menuItems(context).length - 2,
                  itemBuilder: (context, index) {
                    final menuItem =
                        menuItems(context)[index + 1]; // Adjust for context
                    return GestureDetector(
                      onTap: menuItem.onTap,
                      child: customBox(
                        menuItem,
                        boxGradients[index % boxGradients.length],
                      ),
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: CustomBottomAppBar(),
    );
  }
}
