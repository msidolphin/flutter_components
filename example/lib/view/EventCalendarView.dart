
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_components/eventcalendar/event_calendar.dart';

class EventCalendarView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return EventCalendarViewState();
  }

}

class EventCalendarViewState extends State<EventCalendarView> {

  CalendarController calendarController = new CalendarController();

  @override
  void dispose() {
    super.dispose();
    calendarController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: EventCalendar(
        daysOfWeekStyle: DaysOfWeekStyle(
          height: 32
        ),
        calendarController: calendarController,
      ),
    );
  }

}