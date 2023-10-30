import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TimeTableScreen extends StatelessWidget {
  const TimeTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset('asset/lottie/coming.json'),
      ),
    );
  }
}
// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:kcgerp/Screen/OverScreen/TimeTable/Widget/event.dart';
// import 'package:table_calendar/table_calendar.dart';

// class TimeTableScreen extends StatefulWidget {
//   const TimeTableScreen({super.key});

//   @override
//   State<TimeTableScreen> createState() => _TimeTableScreenState();
// }

// class _TimeTableScreenState extends State<TimeTableScreen> {
//   Map<DateTime, List<Event>>? selectedEvents;

//   CalendarFormat format = CalendarFormat.month;

//   DateTime selectedDay = DateTime.now();

//   DateTime focusedDay = DateTime.now();

//   TextEditingController _eventController = TextEditingController();
//  List<Timer> eventTimers = []; 
//    @override
//   void initState() {
//     selectedEvents = {};
//     super.initState();
//     // Schedule a recurring timer to check and update event visibility
//     Timer.periodic(Duration(seconds: 60), (timer) {
//       _updateEventVisibility();
//     });
//   }

//   void _updateEventVisibility() {
//     final now = DateTime.now();
//     setState(() {
//       eventTimers.forEach((timer) {
//         final event = timer.tick.toString().split(" ")[1].substring(0, 5);
//         final eventTime = DateTime(
//           selectedDay.year,
//           selectedDay.month,
//           selectedDay.day,
//           int.parse(event.split(":")[0]),
//           int.parse(event.split(":")[1]),
//         );
//         if (now.isAfter(eventTime)) {
//           timer.cancel();
//           eventTimers.remove(timer);
//         }
//       });
//     });
//   }

//   List<Event> _getEventsfromDay(DateTime date) {
//     List<Event> events = selectedEvents![date] ?? [];

//     if (date.weekday == DateTime.monday) {
//       events.add(Event(time: '9:00-9:50:', title: 'OOPS'));
//       // Add more events here
//     } else if (date.weekday == DateTime.tuesday) {
//       events.add(Event(time: '9:00-9:50:', title: 'DS'));
//       // Add more events here
//     }
//     else if (date.weekday == DateTime.sunday) {
//       events.add(Event(time: '9:00-9:50:', title: 'DS'));
//       // Add more events here
//     }
//     // Add events for other days

//     // Schedule timers for each event
//     events.forEach((event) {
//       final eventTime = DateTime(
//         date.year,
//         date.month,
//         date.day,
//         int.parse(event.time.split("-")[0].split(":")[0]),
//         int.parse(event.time.split("-")[0].split(":")[1]),
//       );
//       final timeDifference = eventTime.isAfter(DateTime.now())
//           ? eventTime.difference(DateTime.now())
//           : Duration.zero;

//       final eventTimer = Timer(timeDifference, () {
//         setState(() {
//           events.remove(event);
//         });
//       });
//       eventTimers.add(eventTimer);
//     });

//     return events;
//   }

//   @override
//   void dispose() {
//     _eventController.dispose();
//     // Cancel and dispose of event timers
//     eventTimers.forEach((timer) {
//       timer.cancel();
//     });
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Calendar"),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             TableCalendar(
//               focusedDay: selectedDay,
//               firstDay: DateTime(2023),
//               lastDay: DateTime(2050),
//               calendarFormat: format,
//               onFormatChanged: (CalendarFormat _format) {
//                 setState(() {
//                   format = _format;
//                 });
//               },
//               startingDayOfWeek: StartingDayOfWeek.sunday,
//               daysOfWeekVisible: true,
//               onDaySelected: (DateTime selectDay, DateTime focusDay) {
//                 setState(() {
//                   selectedDay = selectDay;
//                   focusedDay = focusDay;
//                 });
//               },
//               selectedDayPredicate: (DateTime date) {
//                 return isSameDay(selectedDay, date);
//               },
//               eventLoader: _getEventsfromDay,
//               calendarStyle: CalendarStyle(
//                 markerSize: 0,
//                 isTodayHighlighted: true,
//                 selectedDecoration: BoxDecoration(
//                   color: Colors.blue,
//                   shape: BoxShape.rectangle,
//                   borderRadius: BorderRadius.circular(5.0),
//                 ),
//                 selectedTextStyle: TextStyle(color: Colors.white),
//                 todayDecoration: BoxDecoration(
//                   color: Colors.purpleAccent,
//                   shape: BoxShape.rectangle,
//                   borderRadius: BorderRadius.circular(5.0),
//                 ),
//                 defaultDecoration: BoxDecoration(
//                   shape: BoxShape.rectangle,
//                   borderRadius: BorderRadius.circular(5.0),
//                 ),
//                 weekendDecoration: BoxDecoration(
//                   shape: BoxShape.rectangle,
//                   borderRadius: BorderRadius.circular(5.0),
//                 ),
//               ),
//               headerStyle: HeaderStyle(
//                 formatButtonVisible: true,
//                 titleCentered: true,
//                 formatButtonShowsNext: false,
//                 formatButtonDecoration: BoxDecoration(
//                   color: Colors.blue,
//                   borderRadius: BorderRadius.circular(5.0),
//                 ),
//                 formatButtonTextStyle: TextStyle(
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//             ..._getEventsfromDay(selectedDay).map(
//               (Event event) => Container(
//                 height: MediaQuery.of(context).size.height * 0.051,
//                 child: Row(
//                   children: [
//                     Text(event.time),
//                     Text(event.title),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
      
//     );
//   }
// }

