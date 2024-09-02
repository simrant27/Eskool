import 'package:flutter/material.dart';
import '../component/boxDesign.dart';
import '../component/Drawerlist.dart';
import '../component/customAppBar.dart';
import '../component/customBottomAppBar.dart';
import '../data/menuItems.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final notification = menuItems(context);
    return Scaffold(
      appBar: customAppBar("Profile", MediaQuery.of(context).size.height / 40),
      drawer: drawerlist(context),
      body: Stack(
        children: [
          Container(
            width: double.infinity, // Use full width
            height: MediaQuery.of(context).size.height / 6,
            decoration: boxDesign(),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Column(
              children: [
                // Add your content here
              ],
            ),
          ),
          Column(
            children: [],
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 3,
            top: MediaQuery.of(context).size.height / 8 - 60,
            child: Container(
              width: MediaQuery.of(context).size.width / 3,
              height: MediaQuery.of(context).size.width / 3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(width: 1, color: Colors.white),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueGrey.withOpacity(0.2),
                    blurRadius: 12,
                    spreadRadius: 8,
                  ),
                ],
                image: DecorationImage(
                  fit: BoxFit.cover, // Ensure the image covers the container
                  image: NetworkImage(
                    "https://images.unsplash.com/photo-1541647376583-8934aaf3448a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1234&q=80",
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
      bottomNavigationBar: CustomBottomAppBar(),
    );
  }
}
