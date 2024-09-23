// import 'package:responsive_admin_dashboard/constants/constants.dart';
// import 'package:responsive_admin_dashboard/models/analytic_info_model.dart';
// import 'package:responsive_admin_dashboard/models/discussions_info_model.dart';
// import 'package:responsive_admin_dashboard/models/referal_info_model.dart';

import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../models/analytic_info_model.dart';

List analyticData = [
  AnalyticInfo(
    title: "Employee",
    count: 720,
    icon: Icons.work_history_outlined,
    color: primaryColor,
  ),
  AnalyticInfo(
    title: "Parents",
    count: 820,
    icon: Icons.people_alt,
    color: purple,
  ),
  AnalyticInfo(
    title: "Students",
    count: 920,
    icon: Icons.people,
    color: orange,
  ),
];
