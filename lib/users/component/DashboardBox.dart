import 'package:eskool/users/component/customBox.dart';
import 'package:eskool/users/data/menuItems.dart';
import 'package:flutter/material.dart';

import '../data/colorCombination.dart';

FutureBuilder<List<MenuItem>> DashboardBox(BuildContext context) {
  return FutureBuilder<List<MenuItem>>(
    future: menuItems(context), // Fetch menu items asynchronously
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator()); // Loading state
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}')); // Error state
      } else if (snapshot.hasData) {
        final menuItemsList = snapshot.data!; // Get the list of menu items

        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: GridView.builder(
              physics:
                  NeverScrollableScrollPhysics(), // Disable inner scrolling
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 30,
                childAspectRatio: 1.0, // Adjust for square items
              ),
              itemCount: menuItemsList.length - 2, // Adjust for specific items
              itemBuilder: (context, index) {
                final menuItem = menuItemsList[index + 1]; // Adjust for context
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
        );
      } else {
        return Center(child: Text('No menu items available')); // No data state
      }
    },
  );
}
