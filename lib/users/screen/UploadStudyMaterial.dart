// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import '../component/customButtonStyle.dart';

// class UploadStudyMaterialScreen extends StatefulWidget {
//   @override
//   _UploadStudyMaterialScreenState createState() =>
//       _UploadStudyMaterialScreenState();
// }

// class _UploadStudyMaterialScreenState extends State<UploadStudyMaterialScreen> {
//   String? fileName;
//   String? filePath;
//   final TextEditingController titleController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();

//   Future<void> _pickFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf', 'ppt', 'doc', 'docx'],
//     );
//     if (result != null) {
//       setState(() {
//         fileName = result.files.single.name;
//         filePath = result.files.single.path;
//       });
//     } else {
//       // User canceled the picker
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Upload Study Material'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Title Input
//             TextField(
//               controller: titleController,
//               decoration: InputDecoration(
//                 labelText: 'Title',
//                 border: OutlineInputBorder(),
//                 hintText: 'Enter the title of the material',
//               ),
//             ),
//             SizedBox(height: 16),

//             // Description Input
//             TextField(
//               controller: descriptionController,
//               maxLines: 3,
//               decoration: InputDecoration(
//                 labelText: 'Description',
//                 border: OutlineInputBorder(),
//                 hintText: 'Enter a brief description',
//               ),
//             ),
//             SizedBox(height: 16),

//             // Upload Button
//             ElevatedButton.icon(
//               onPressed: _pickFile,
//               icon: Icon(Icons.upload_file),
//               label: Text('Choose File'),
//             ),
//             SizedBox(height: 16),

//             // Display selected file
//             if (fileName != null)
//               Text(
//                 'Selected File: $fileName',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//             if (fileName == null)
//               Text(
//                 'No file selected',
//                 style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
//               ),
//             Spacer(),

//             // Submit Button

//             Center(
//               child: ElevatedButton(
//                 onPressed: () {
//                   if (fileName != null && titleController.text.isNotEmpty) {
//                     // Implement upload functionality here
//                     showDialog(
//                       context: context,
//                       builder: (context) => AlertDialog(
//                         title: Text('Upload Successful'),
//                         content: Text('Your material has been uploaded.'),
//                         actions: [
//                           TextButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             child: Text('OK'),
//                           ),
//                         ],
//                       ),
//                     );
//                   } else {
//                     // Show error if no file or title
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text('Please select a file and enter a title'),
//                       ),
//                     );
//                   }
//                 },
//                 style: customButtonStyle,
//                 child: Text('Upload Material'),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
