import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

class ViewNoticeFile extends StatelessWidget {
  final String title;
  final String description;
  final String? fileUrl; // URL for the image or file

  const ViewNoticeFile({
    Key? key,
    required this.title,
    required this.description,
    this.fileUrl,
  }) : super(key: key);

  void _openFile() async {
    if (fileUrl != null) {
      // Open the PDF file using the URL
      await OpenFile.open(fileUrl!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              description,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            if (fileUrl != null) ...[
              // For image files
              if (fileUrl!.endsWith('.jpg') ||
                  fileUrl!.endsWith('.png') ||
                  fileUrl!.endsWith('.jpeg')) ...[
                Image.network(
                  fileUrl!,
                  fit: BoxFit.cover,
                ),
              ] else if (fileUrl!.endsWith('.pdf')) ...[
                // For PDF files
                ElevatedButton(
                  onPressed: _openFile,
                  child: Text("Open PDF"),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
