// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../constants/constants.dart';

DecorationImage userImage(String? imageUrl) {
  String defaultImage =
      "https://www.transparentpng.com/download/user/gray-user-profile-icon-png-fP8Q1P.png";

  // Check if imageUrl is valid and extract file name if necessary
  String? imageToLoad;
  if (imageUrl != null && imageUrl.isNotEmpty) {
    var fileName = formatUserImage(imageUrl);
    imageToLoad = "$url/assets/$fileName";
  } else {
    imageToLoad = defaultImage;
  }

  return DecorationImage(
    fit: BoxFit.cover,
    image: NetworkImage(imageToLoad),
  );
}

String formatUserImage(String filePath) {
  // Parse the file URI and extract the file name
  Uri uri = Uri.parse(filePath);
  return uri.pathSegments.last;
}
