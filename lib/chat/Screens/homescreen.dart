import 'package:eskool/services/parentService.dart';
import 'package:eskool/services/teacherService.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/ParentMode.dart';
import '../../models/teacherModel.dart';
import '../models/chat_model.dart';
// / Adjust import as per your structure

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<ChatModel>> chatModelsFuture;
  ParentService parentService = ParentService();
  TeacherService teacherService = TeacherService();

  @override
  void initState() {
    super.initState();
    chatModelsFuture = _fetchUsersBasedOnRole();
  }

  Future<List<ChatModel>> _fetchUsersBasedOnRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String role = prefs.getString('role') ?? 'No role found';

    if (role == 'parent') {
      // Fetch parents and convert them to ChatModel
      List<Parent> parents = await parentService.fetchParents();
      return parents.map((parent) {
        return ChatModel(
          name: parent.fullName!,
          icon: Icons.person,
          // isGroup: false,
          // time: '18:00', // You can modify this as per your needs
          // currentMessage: 'Send a message', // Default message
          id: parent.id,
        );
      }).toList();
    } else if (role == 'teacher') {
      // Fetch teachers and convert them to ChatModel
      List<Teacher> teachers = await teacherService.fetchTeachers();
      return teachers.map((teacher) {
        return ChatModel(
          name: teacher.fullName!,
          icon: Icons.person,
          // isGroup: false,
          // time: '18:00', // You can modify this as per your needs
          // Default message
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
                // subtitle: Text(chatModel.currentMessage),
                onTap: () {
                  // Navigate to chat page or any other action
                },
              );
            },
          );
        },
      ),
    );
  }
}
