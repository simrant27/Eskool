import 'package:eskool/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderWidget extends StatefulWidget {
  const CalenderWidget({super.key});

  @override
  State<CalenderWidget> createState() => _CalenderWidgetState();
}

class _CalenderWidgetState extends State<CalenderWidget> {
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: secondaryColor, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${DateFormat("MMM, yyyy").format(_focusedDay)}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: textColor),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _focusedDay =
                            DateTime(_focusedDay.year, _focusedDay.month - 1);
                      });
                    },
                    child: Icon(
                      Icons.chevron_left,
                      color: textColor,
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
                          _focusedDay =
                              DateTime(_focusedDay.year, _focusedDay.month - 1);
                        });
                      },
                      child: Icon(
                        Icons.chevron_right,
                        color: textColor,
                      )),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime.utc(2010),
            lastDay: DateTime.utc(2040),
            headerVisible: false,
            onFormatChanged: (format) {},
            daysOfWeekStyle: DaysOfWeekStyle(
              dowTextFormatter: (date, locale) {
                return DateFormat("EEE").format(date).toUpperCase();
              },
              weekdayStyle: TextStyle(fontWeight: FontWeight.bold),
              weekendStyle: TextStyle(fontWeight: FontWeight.bold),
            ),
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.8), shape: BoxShape.circle),
            ),
          )
        ],
      ),
    );
  }
}
