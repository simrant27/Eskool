// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../component/Drawerlist.dart';
import '../component/boxDesign.dart';
import '../component/customAppBar.dart';
import '../component/customBox.dart';
import '../data/colorCombination.dart';
import '../data/data.dart';
import '../data/menuItems.dart';

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
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      child: RichText(
                        text: TextSpan(
                          text: "Wed",
                          style: TextStyle(
                            color: Color.fromARGB(255, 46, 121, 214),
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                          ),
                          children: [
                            TextSpan(
                              text: " 10 Oct",
                              style: TextStyle(
                                color: Color(0XFF263064),
                                fontSize: 14,
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
                              ),
                            ],
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                "https://images.unsplash.com/photo-1541647376583-8934aaf3448a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1234&q=80",
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            introduction['greeting']!,
                            SizedBox(height: 10),
                            introduction['RegNO']!,
                            SizedBox(height: 6),
                            introduction['Standard']!,
                            SizedBox(height: 8),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
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
                  child: ListView(
                    children: [
                      // You can add content here or remove this ListView if not needed
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 30,
                        childAspectRatio: 1.5 / 1.5,
                      ),
                      itemCount: menuItems.length - 2,
                      itemBuilder: (context, index) {
                        // Cycle through the gradients or use a different logic
                        return customBox(
                          menuItems[index + 1],
                          boxGradients[index % boxGradients.length],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                // Handle Home button press
              },
            ),
            IconButton(
              icon: Icon(Icons.chat),
              onPressed: () {
                // Handle Chat button press
              },
            ),
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                // Handle Notifications button press
              },
            ),
            IconButton(
              icon: Icon(Icons.person_2_rounded),
              onPressed: () {
                // Handle Notifications button press
              },
            ),
          ],
        ),
      ),
    );
  }
}
