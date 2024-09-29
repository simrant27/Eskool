import 'package:intl/intl.dart';

DateTime now = DateTime.now();
String dayOfWeekShort = DateFormat('EEE').format(now);
String day = DateFormat('d').format(now);
String monthShort = DateFormat('MMM').format(now);
