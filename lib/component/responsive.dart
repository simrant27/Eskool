// lib/responsive_util.dart
import 'package:flutter/material.dart';

enum DeviceType { mobile, tablet, desktop }

class ResponsiveUtil {
  // Method to get the device type based on screen width
  static DeviceType getDeviceType(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    if (width >= 1024) {
      return DeviceType.desktop;
    } else if (width >= 600) {
      return DeviceType.tablet;
    } else {
      return DeviceType.mobile;
    }
  }

  // Method to get width and height based on the device type
  static Size getResponsiveSize(BuildContext context) {
    DeviceType deviceType = getDeviceType(context);

    double width;
    double height;

    switch (deviceType) {
      case DeviceType.desktop:
        width = 200;
        height = 150;
        break;
      case DeviceType.tablet:
        width = 150;
        height = 100;
        break;
      case DeviceType.mobile:
      default:
        width = 100;
        height = 80;
        break;
    }

    return Size(width, height);
  }
}
