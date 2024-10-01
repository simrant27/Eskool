import 'package:eskool/chat/Screens/individual_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/ParentMode.dart';
import '../../models/teacherModel.dart';
import '../../services/parentService.dart';
import '../../services/teacherService.dart';
import '../models/chat_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<ChatModel>> chatModelsFuture;
  ParentService parentService = ParentService();
  TeacherService teacherService = TeacherService();
  String? userId; // Variable to store the user ID

  @override
  void initState() {
    super.initState();
    _getUserId(); // Fetch the user ID when initializing the widget
    chatModelsFuture =
        _fetchUsersBasedOnRole(); // Fetch chat users based on the role
  }

  Future<void> _getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId') ??
          'No id found'; // Get the user ID from SharedPreferences
    });
  }

  Future<List<ChatModel>> _fetchUsersBasedOnRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String role = prefs.getString('role') ?? 'No role found';
    String userId = prefs.getString('userId') ?? 'No id found';

    print('Logged in Role: $role');
    print('Logged in User ID: $userId');

    if (role == 'teacher') {
      // Fetch parents and convert them to ChatModel
      List<Parent> parents = await parentService.fetchParents();
      return parents.map((parent) {
        return ChatModel(
          name: parent.fullName!,
          icon: Icons.person,
          id: parent.id,
        );
      }).toList();
    } else if (role == 'parent') {
      // Fetch teachers and convert them to ChatModel
      List<Teacher> teachers = await teacherService.fetchTeachers();
      return teachers.map((teacher) {
        return ChatModel(
          name: teacher.fullName!,
          icon: Icons.person,
          id: teacher.id,
        );
      }).toList();
    } else {
      return []; // Return an empty list if the role is not recognized
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
        title: Text(
          "Chats",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        ],
      ),
      body: FutureBuilder<List<ChatModel>>(
        future: chatModelsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No users found.'));
          }

          // Display the list of ChatModels
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final chatModel = snapshot.data![index];
              return ListTile(
                leading: Icon(chatModel.icon),
                title: Text(chatModel.name),
                onTap: () {
                  // Ensure userId is available before navigating
                  if (userId != null && userId != 'No id found') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IndividualPage(
                          chatModel: chatModel,
                          sourceChat: ChatModel(
                            name: "Source Chat", // Adjust as needed
                            id: userId!, // Use the stored userId from SharedPreferences
                          ),
                        ),
                      ),
                    );
                  } else {
                    // Handle the case where userId is not available
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('User ID not found!')));
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
