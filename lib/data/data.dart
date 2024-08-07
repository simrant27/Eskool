// import 'package:responsive_admin_dashboard/constants/constants.dart';
// import 'package:responsive_admin_dashboard/models/analytic_info_model.dart';
// import 'package:responsive_admin_dashboard/models/discussions_info_model.dart';
// import 'package:responsive_admin_dashboard/models/referal_info_model.dart';

import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../models/analytic_info_model.dart';
import '../models/discussions_info_model.dart';
import '../models/referal_info_model.dart';

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

List discussionData = [
  DiscussionInfoModel(
    imageSrc: "assets/images/photo1.jpg",
    name: "Lutfhi Chan",
    date: "Jan 25,2021",
  ),
  DiscussionInfoModel(
    imageSrc: "assets/images/photo2.jpg",
    name: "Devi Carlos",
    date: "Jan 25,2021",
  ),
  DiscussionInfoModel(
    imageSrc: "assets/images/photo3.jpg",
    name: "Danar Comel",
    date: "Jan 25,2021",
  ),
  DiscussionInfoModel(
    imageSrc: "assets/images/photo4.jpg",
    name: "Karin Lumina",
    date: "Jan 25,2021",
  ),
  DiscussionInfoModel(
    imageSrc: "assets/images/photo5.jpg",
    name: "Fandid Deadan",
    date: "Jan 25,2021",
  ),
  DiscussionInfoModel(
    imageSrc: "assets/images/photo1.jpg",
    name: "Lutfhi Chan",
    date: "Jan 25,2021",
  ),
];

List referalData = [
  ReferalInfoModel(
    title: "Facebook",
    count: 234,
    svgSrc: "assets/icons/Facebook.svg",
    color: primaryColor,
  ),
  ReferalInfoModel(
    title: "Twitter",
    count: 234,
    svgSrc: "assets/icons/Twitter.svg",
    color: primaryColor,
  ),
  ReferalInfoModel(
    title: "Linkedin",
    count: 234,
    svgSrc: "assets/icons/Linkedin.svg",
    color: primaryColor,
  ),
  ReferalInfoModel(
    title: "Dribble",
    count: 234,
    svgSrc: "assets/icons/Dribbble.svg",
    color: red,
  ),
];
