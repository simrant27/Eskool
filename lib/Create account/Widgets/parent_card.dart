import 'package:flutter/material.dart';

class ParentCard extends StatelessWidget {
  final Map<String, dynamic> parent;
  final Function(Map<String, dynamic>) onEdit;
  final Function() onDelete;

  ParentCard({
    required this.parent,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Show dialog with parent details and options to edit and delete
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: ParentDetailPopup(
                parent: parent,
                onEdit: onEdit,
                onDelete: onDelete,
              ),
            );
          },
        );
      },
      child: Card(
        elevation: 5,
        margin: EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Parents Name: ${parent['fullName']}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('Email: ${parent['email']}'),
              Text('Phone: ${parent['phone']}'),
              Text('Child Name: ${parent['childrenDetails'].map((child) => child['name']).join(', ')}'),
            ],
          ),
        ),
      ),
    );
  }
}

class ParentDetailPopup extends StatelessWidget {
  final Map<String, dynamic> parent;
  final Function(Map<String, dynamic>) onEdit;
  final Function() onDelete;

  ParentDetailPopup({
    required this.parent,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Parent photo and details inside a blue box layout
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[100], // Blue background for parent details box
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (parent['photoUrl'] != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        parent['photoUrl'],
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  SizedBox(height: 10),
                  Text(
                    'Parents Name: ${parent['fullName']}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text('Email: ${parent['email']}'),
                  Text('Phone: ${parent['phone']}'),
                  Text('Address: ${parent['address'] ?? 'N/A'}'),
                  Text('Relationship to the child: ${parent['relationship to the child']}'),
                  Text('ParentID: ${parent['parentID']}'),
                  Text('Username: ${parent['username']}'),
                  Text('Password: ${parent['password']}'),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Edit button to open the combined form
            ElevatedButton(
              onPressed: () {
                // Show edit form with combined parent and child details
                Navigator.pop(context); // Close current popup
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      contentPadding: EdgeInsets.zero,
                      content: CombinedEditForm(
                        parent: parent,
                        onSave: (updatedParent) {
                          onEdit(updatedParent); // Call onEdit with updated data
                        },
                      ),
                    );
                  },
                );
              },
              child: Text('Edit Parent and Children Details'),
            ),
            SizedBox(height: 16),

            // Child details section
            Text('Children Details', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true, // To make ListView inside ScrollView
              itemCount: parent['childrenDetails'].length,
              itemBuilder: (context, index) {
                var child = parent['childrenDetails'][index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Child Name: ${child['name']}', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('Date of Birth: ${child['dob']}'),
                        Text('Grade: ${child['grade']}'),
                        Text('School ID: ${child['schoolId']}'),
                        Text('Address: ${child['address']}'),
                      ],
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: 16),
            // Buttons for editing and deleting
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
ElevatedButton(
  onPressed: () async {
    // Show confirmation dialog before deleting
    bool? confirmDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Delete'),
        content: Text('Are you sure you want to delete this entry?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), // Close dialog and return false
            child: Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true), // Close dialog and return true
            child: Text('Yes'),
          ),
        ],
      ),
    );

    // If user confirmed deletion, call onDelete function
    if (confirmDelete == true) {
      onDelete(); // Call delete function
      Navigator.of(context).pop(); // Close the parent detail dialog
    }
  },
  //style: ElevatedButton.styleFrom(primary: Colors.red), // Optional: Make it red for delete action
  child: Text('Delete'),
),

              ],
            ),
            SizedBox(height: 10),
            // Close button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CombinedEditForm extends StatefulWidget {
  final Map<String, dynamic> parent;
  final Function(Map<String, dynamic>) onSave;

  CombinedEditForm({
    required this.parent,
    required this.onSave,
  });

  @override
  _CombinedEditFormState createState() => _CombinedEditFormState();
}

class _CombinedEditFormState extends State<CombinedEditForm> {
  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late TextEditingController relationshipController;
  late TextEditingController parentIDController;
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late List<TextEditingController> childrenNameControllers;
  late List<TextEditingController> childrenDobControllers;
late List<TextEditingController> childrenGradeControllers;
 late List<TextEditingController> childrenSchoolIDControllers;
 late List<TextEditingController> childrenAddressControllers;
  @override
  void initState() {
    super.initState();

    // Initialize controllers for parent
    fullNameController = TextEditingController(text: widget.parent['fullName']);
    emailController = TextEditingController(text: widget.parent['email']);
    phoneController = TextEditingController(text: widget.parent['phone']);
    addressController = TextEditingController(text: widget.parent['address']);
    relationshipController = TextEditingController(text: widget.parent['relationship']);
    parentIDController = TextEditingController(text: widget.parent['parentID']);
    usernameController = TextEditingController(text: widget.parent['username']);
    passwordController = TextEditingController(text: widget.parent['password']); 


    // Initialize controllers for children
    childrenNameControllers = widget.parent['childrenDetails'].map<TextEditingController>((child) {
      return TextEditingController(text: child['name']);
    }).toList();

    childrenDobControllers = widget.parent['childrenDetails'].map<TextEditingController>((child) {
      return TextEditingController(text: child['dob']);
    }).toList();
    childrenGradeControllers = widget.parent['childrenDetails'].map<TextEditingController>((child) {
       return TextEditingController(text: child['grade']);
    }).toList();
    childrenSchoolIDControllers = widget.parent['childrenDetails'].map<TextEditingController>((child) {
       return TextEditingController(text: child['schoolID']);
    }).toList();
 childrenAddressControllers = widget.parent['childrenDetails'].map<TextEditingController>((child) {
       return TextEditingController(text: child['address']);
    }).toList();
  }

  @override
  void dispose() {
    // Dispose controllers
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    relationshipController.dispose();
    parentIDController.dispose();
    usernameController.dispose();
     passwordController.dispose();
    childrenNameControllers.forEach((controller) => controller.dispose());
    childrenDobControllers.forEach((controller) => controller.dispose());
    childrenGradeControllers.forEach((controller) => controller.dispose());
    childrenSchoolIDControllers.forEach((controller) => controller.dispose());
    childrenAddressControllers.forEach((controller) => controller.dispose());
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Edit Parent Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(
              controller: fullNameController,
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
            ),
            TextField(
              controller: addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: relationshipController,
              decoration: InputDecoration(labelText: 'Relationship'),
            ),
            TextField(
              controller: parentIDController,
              decoration: InputDecoration(labelText: 'ParentID'),
            ),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
            ),

            SizedBox(height: 16),

            // Edit children details
            Text('Edit Children Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.parent['childrenDetails'].length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: 'Child Name'),
                      controller: childrenNameControllers[index],
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Date of Birth'),
                      controller: childrenDobControllers[index],
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Grade'),
                      controller: childrenGradeControllers[index],
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'SchoolID'),
                      controller: childrenSchoolIDControllers[index],
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Address'),
                      controller: childrenAddressControllers[index],
                    ),
                    SizedBox(height: 8),
                  ],
                );
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Update parent details with edited values
                widget.parent['fullName'] = fullNameController.text;
                widget.parent['email'] = emailController.text;
                widget.parent['phone'] = phoneController.text;
                widget.parent['address'] = addressController.text;
                widget.parent['relationship to the child'] = relationshipController.text;
                widget.parent['parentID'] = parentIDController.text;
                widget.parent['username'] = usernameController.text;
                widget.parent['password'] = passwordController.text;
                // Update children details
                for (int i = 0; i < widget.parent['childrenDetails'].length; i++) {
                  widget.parent['childrenDetails'][i]['name'] = childrenNameControllers[i].text;
                  widget.parent['childrenDetails'][i]['dob'] = childrenDobControllers[i].text;
                  widget.parent['childrenDetails'][i]['grade'] = childrenGradeControllers[i].text;
                  widget.parent['childrenDetails'][i]['schoolID'] = childrenSchoolIDControllers[i].text;
                  widget.parent['childrenDetails'][i]['address'] = childrenAddressControllers[i].text;
                }

                widget.onSave(widget.parent); // Save the updated parent and children data
                Navigator.pop(context); // Close the form dialog
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
