import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import '../../../../constants/constants.dart';
import '../../../../constants/responsive.dart';
import '../../components/custom_page_layout.dart';
import '../../components/custon_button.dart';
import 'calenderWidget.dart';

class NoticeForm extends StatefulWidget {
  final String? initialTitle;
  final String? initialDescription;
  final List<PlatformFile>? initialFiles;
  final Function(String title, String description, List<PlatformFile>? files)
      onSubmit;

  const NoticeForm({
    Key? key,
    this.initialTitle,
    this.initialDescription,
    this.initialFiles,
    required this.onSubmit,
  }) : super(key: key);

  @override
  _NoticeFormState createState() => _NoticeFormState();
}

class _NoticeFormState extends State<NoticeForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  List<PlatformFile>? _mediaFiles;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.initialTitle ?? '';
    _descriptionController.text = widget.initialDescription ?? '';
    _mediaFiles = widget.initialFiles ?? [];
  }

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

  void _clearFields() {
    setState(() {
      _titleController.clear();
      _descriptionController.clear();
      _mediaFiles = null;
    });
  }

  void _removeFile(int index) {
    setState(() {
      _mediaFiles!.removeAt(index);
    });
  }

  void _submit() {
    final title = _titleController.text;
    final description = _descriptionController.text;
    widget.onSubmit(title, description, _mediaFiles);
  }

  @override
  Widget build(BuildContext context) {
    return CustomPageLayout(
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Container(
                padding: EdgeInsets.all(appPadding),
                margin: EdgeInsets.all(appPadding),
                decoration: BoxDecoration(
                  color: Colors.white, // Background color
                  borderRadius: BorderRadius.circular(12.0), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Shadow color
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
                      widget.initialTitle == null
                          ? "Create a Post"
                          : "Edit Post",
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 16),
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
                    CustomButton(
                      label: "Select files",
                      color: Colors.blue.shade100,
                      onPressed: _pickMediaFiles,
                    ),
                    if (_mediaFiles != null) ...[
                      SizedBox(height: 10),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: _mediaFiles!.length,
                        itemBuilder: (context, index) {
                          final file = _mediaFiles![index];
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(file.extension == 'pdf'
                                ? Icons.picture_as_pdf
                                : Icons.image),
                            title: Text(file.name),
                            trailing: IconButton(
                              icon: Icon(Icons.close, color: Colors.red),
                              onPressed: () => _removeFile(index),
                            ),
                          );
                        },
                      ),
                    ],
                    SizedBox(height: 20),
                    Row(
                      children: [
                        CustomButton(
                          label: "Submit",
                          color: Colors.green.shade200,
                          onPressed: _submit,
                        ),
                        SizedBox(width: 20),
                        CustomButton(
                          label: "Clear",
                          color: Colors.red.shade200,
                          onPressed: _clearFields,
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    CustomButton(
                      label: "Cancel",
                      color: Colors.grey.shade300,
                      onPressed: () => Navigator.pop(
                          context), // Navigates back to the previous page
                    ),
                  ],
                )),
          ),
          if (!Responsive.isMobile(context))
            Expanded(flex: 2, child: CalenderWidget())
        ],
      ),
    );
  }
}
