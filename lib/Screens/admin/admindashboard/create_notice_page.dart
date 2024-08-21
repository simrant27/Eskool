import 'package:eskool/Screens/admin/admindashboard/components/calenderWidget.dart';
import 'package:eskool/Screens/admin/admindashboard/components/customAppbar.dart';
import 'package:eskool/constants/constants.dart';
import 'package:eskool/constants/responsive.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'components/responsive_drawer_layout.dart'; // Import the new widget

class CreateNoticePage extends StatefulWidget {
  const CreateNoticePage({super.key});

  @override
  _CreateNoticePageState createState() => _CreateNoticePageState();
}

class _CreateNoticePageState extends State<CreateNoticePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  List<PlatformFile>? _mediaFiles;

  Future<void> _pickMediaFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'pdf'],
      allowMultiple: true,
    );

    if (result != null) {
      setState(() {
        _mediaFiles = result.files;
      });
    }
  }

  void _submitNotice() {
    final title = _titleController.text;
    final description = _descriptionController.text;

    // Handle form submission logic here
    print("Title: $title");
    print("Description: $description");
    if (_mediaFiles != null) {
      for (var file in _mediaFiles!) {
        print("Media: ${file.name}");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveDrawerLayout(
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppbar(
                  hinttext: "notices",
                  showSearch: false,
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        padding: EdgeInsets.all(appPadding),
                        margin: EdgeInsets.all(appPadding),
                        decoration: BoxDecoration(
                          color: Colors.white, // Background color
                          borderRadius:
                              BorderRadius.circular(12.0), // Rounded corners
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.grey.withOpacity(0.5), // Shadow color
                              spreadRadius: 2,
                              blurRadius: 10,
                              offset: Offset(0, 4), // Shadow position
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Create a Post",
                              style: TextStyle(
                                fontSize: 24,
                              ),
                            ),
                            SizedBox(
                              height: appPadding,
                            ),
                            TextField(
                              controller: _titleController,
                              decoration: InputDecoration(
                                labelText: "Title",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 20),
                            TextField(
                              controller: _descriptionController,
                              maxLines: 5,
                              decoration: InputDecoration(
                                labelText: "Description",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: _pickMediaFiles,
                              child: Text("Pick Media Files"),
                            ),
                            if (_mediaFiles != null) ...[
                              SizedBox(height: 10),
                              Text("Selected Files:"),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: _mediaFiles!.length,
                                itemBuilder: (context, index) {
                                  return Text(_mediaFiles![index].name);
                                },
                              ),
                            ],
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: _submitNotice,
                              child: Text("Submit Notice"),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (!Responsive.isMobile(context))
                      Expanded(flex: 2, child: CalenderWidget())
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
