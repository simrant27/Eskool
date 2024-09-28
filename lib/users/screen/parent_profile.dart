import 'package:eskool/users/component/CustomScaffold.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Screens/admin/billing/data/studentList.dart';
import '../component/buildProfileSection.dart';
import '../component/buildSecuritySection.dart';
import '../data/menuItems.dart';
import '../data/userImage.dart';
import '../forBackend/fetchstudentAsParent.dart';
import '../forBackend/parent_model.dart';
import '../forBackend/userService.dart';
import 'StudentDetail.dart';

class ParentProfile extends StatefulWidget {
  const ParentProfile({super.key});

  @override
  State<ParentProfile> createState() => _ParentProfileState();
}

class _ParentProfileState extends State<ParentProfile> {
  List<Student> students = [];
  bool isLoading = false;
  Parent? parent; // Store parent data

  @override
  void initState() {
    super.initState();
    _loadParent();
  }

  Future<void> _loadParent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? parentID = prefs.getString('userId');

    if (parentID != null && parentID.isNotEmpty) {
      print("sharePrefrence $parentID");
      await fetchStudentParentId(parentID);
      await _fetchParentData(); // Fetch parent data
    } else {
      print('Parent ID is null or empty');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Parent ID not found')),
      );
    }
  }

  Future<void> fetchStudentParentId(String selectedParent) async {
    setState(() {
      isLoading = true; // Show loading indicator while fetching
      print('Fetching students for parent: $selectedParent');
    });

    try {
      List<Student> fetchedStudents =
          await fetchStudentsByParentId(selectedParent);

      setState(() {
        students = fetchedStudents;
        isLoading = false; // Hide loading indicator
        print('$students');
      });
    } catch (error) {
      setState(() {
        isLoading = false; // Hide loading indicator on error
      });
      print('Error occurred: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching students: $error')),
      );
    }
  }

  Future<Parent> _fetchParentData() async {
    UserService userService = UserService();
    var fetchedUser = await userService.fetchUserData();
    if (fetchedUser is Parent) {
      setState(() {
        parent = fetchedUser; // Store fetched Parent data
      });
      return fetchedUser; // Return the Parent object
    } else {
      throw Exception('Failed to load Parent data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            // ParentProfile Image
            Center(
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
                  image: userImage(),
                ),
              ),
            ),

            SizedBox(height: 40), // Add some spacing

            // Personal Information
            if (parent != null) // Check if parent data is loaded
              buildProfileSection(
                "Personal Information",
                context,
                parent!.fullName, // Pass the parent's full name
                parent!.email, // Pass the parent's email
                parent!.phone, // Pass the parent's phone
              ),
            SizedBox(height: 16),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Linked Students",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics:
                      NeverScrollableScrollPhysics(), // Prevent inner scrolling
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    final student = students[index];
                    return ListTile(
                      leading: Icon(Icons.child_care, color: Colors.blue),
                      title: Text(student.fullName,
                          style: TextStyle(fontSize: 18)),
                      subtitle: Text('Grade: ${student.classAssigned}'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StudentDetailScreen(
                              studentName: student.fullName,
                              studentGrade: student.classAssigned.toString(),
                              studentDetails: student.toJson(),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 16),

            // Security & Privacy
            buildSecuritySection(context),
            SizedBox(height: 16),

            // Logout List Tile
            FutureBuilder<List<MenuItem>>(
              future: menuItems(context), // Fetch menu items asynchronously
              builder: (context, menuSnapshot) {
                if (menuSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator()); // Loading menu items
                } else if (menuSnapshot.hasError) {
                  return Center(
                    child: Text('Error: ${menuSnapshot.error}'),
                  ); // Error loading menu items
                } else if (menuSnapshot.hasData && menuSnapshot.data != null) {
                  List<MenuItem> logoutItems = menuSnapshot.data!.where((item) {
                    return item.title == 'Logout';
                  }).toList();

                  // Assuming there's only one logout item
                  if (logoutItems.isNotEmpty) {
                    final logoutItem = logoutItems.first;

                    return ListTile(
                      leading: Icon(logoutItem.icon, color: Colors.black87),
                      title: Text(logoutItem.title,
                          style: TextStyle(fontSize: 22)),
                      onTap: logoutItem.onTap, // Handle tap event for the item
                    );
                  }
                }
                return SizedBox(); // Return an empty widget if no logout item found
              },
            ),
          ],
        ),
        appbartitle: "Profile",
        showArrow: false);
  }
}
