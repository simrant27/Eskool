import 'package:url_launcher/url_launcher.dart';

class FileUtils {
  static Future<void> openFile(String filePath) async {
    final Uri uri = Uri.file(filePath);
    // Use canLaunchUrl and launchUrl
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $filePath';
    }
  }
}
