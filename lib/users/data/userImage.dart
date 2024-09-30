// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/constants.dart';

class UserImageLoader {
  static late SharedPreferences _prefs;
  static String? userRole;

  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    userRole = _prefs.getString('role');
  // Check if imageUrl is valid and extract file name if necessary
  String? imageToLoad;
  if (imageUrl != null && imageUrl.isNotEmpty) {
    var fileName = formatUserImage(imageUrl);
    imageToLoad = "$url/uploads/parent_upload/$fileName";
  } else {
    imageToLoad = defaultImage;
  }

  static DecorationImage userImage(String? imageUrl) {
    String defaultImage =
        "https://www.transparentpng.com/download/user/gray-user-profile-icon-png-fP8Q1P.png";

    // Check if imageUrl is valid and extract file name if necessary
    String? imageToLoad;
    if (imageUrl != null && imageUrl.isNotEmpty) {
      var fileName = formatUserImage(imageUrl);
      var middleurl = (userRole == "parent") ? userParentImg : userTeacherImg;
      print(" k ca  $middleurl/$fileName");
      imageToLoad = "$middleurl/$fileName";
    } else {
      imageToLoad = defaultImage;
    }

    return DecorationImage(
      fit: BoxFit.cover,
      image: NetworkImage(imageToLoad),
    );
  }

  static String formatUserImage(String filePath) {
    // Parse the file URI and extract the file name
    Uri uri = Uri.parse(filePath);
    return uri.pathSegments.last;
  }
}
