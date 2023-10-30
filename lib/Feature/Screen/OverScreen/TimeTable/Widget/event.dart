

class Event {
  final String title;
  final String time;
  Event({required this.title,required this.time});

  String toString() => this.title;
}
List<Event> getEventsfromDay({required DateTime date,Map<DateTime, List<Event>>? selectedEvents}) {
  List<Event> events = selectedEvents![date] ?? [];

  // Check if the selected day is a Monday
  if (date.weekday == DateTime.monday) {
    events.add(Event(time: '9:00-9:50:',title: 'OOPS'));
    events.add(Event(time: '9:50-10:40',title: 'OOPS'));
    events.add(Event(time: '10:55-11:45:',title: 'OOPS'));
    events.add(Event(time: '11:45-12:35:',title: 'OOPS'));
    events.add(Event(time: '1:30-2:20:',title: 'OOPS'));
    events.add(Event(time: '2:20-3:10:',title: 'OOPS'));
    events.add(Event(time: '3:10-4:00:',title: 'OOPS'));
  }  // Check if the selected day is a Monday
  else if (date.weekday == DateTime.tuesday) {
    events.add(Event(time: '9:00-9:50:',title: 'DS'));
    events.add(Event(time: '9:50-10:40',title: 'OOPS'));
    events.add(Event(time: '10:55-11:45:',title: 'OOPS'));
    events.add(Event(time: '11:45-12:35:',title: 'OOPS'));
    events.add(Event(time: '1:30-2:20:',title: 'OOPS'));
    events.add(Event(time: '2:20-3:10:',title: 'OOPS'));
    events.add(Event(time: '3:10-4:00:',title: 'OOPS'));
  }  // Check if the selected day is a Monday
  else if (date.weekday == DateTime.wednesday) {
    events.add(Event(time: '9:00-9:50:',title: 'OOPS'));
    events.add(Event(time: '9:50-10:40',title: 'OOPS'));
    events.add(Event(time: '10:55-11:45:',title: 'OOPS'));
    events.add(Event(time: '11:45-12:35:',title: 'OOPS'));
    events.add(Event(time: '1:30-2:20:',title: 'OOPS'));
    events.add(Event(time: '2:20-3:10:',title: 'OOPS'));
    events.add(Event(time: '3:10-4:00:',title: 'OOPS'));
  }  // Check if the selected day is a Monday
  else if (date.weekday == DateTime.thursday) {
    events.add(Event(time: '9:00-9:50:',title: 'OOPS'));
    events.add(Event(time: '9:50-10:40',title: 'OOPS'));
    events.add(Event(time: '10:55-11:45:',title: 'OOPS'));
    events.add(Event(time: '11:45-12:35:',title: 'OOPS'));
    events.add(Event(time: '1:30-2:20:',title: 'OOPS'));
    events.add(Event(time: '2:20-3:10:',title: 'OOPS'));
    events.add(Event(time: '3:10-4:00:',title: 'OOPS'));
  }  // Check if the selected day is a Monday
  else if (date.weekday == DateTime.friday) {
    events.add(Event(time: '9:00-9:50:',title: 'OOPS'));
    events.add(Event(time: '9:50-10:40',title: 'OOPS'));
    events.add(Event(time: '10:55-11:45:',title: 'OOPS'));
    events.add(Event(time: '11:45-12:35:',title: 'OOPS'));
    events.add(Event(time: '1:30-2:20:',title: 'OOPS'));
    events.add(Event(time: '2:20-3:10:',title: 'OOPS'));
    events.add(Event(time: '3:10-4:00:',title: 'OOPS'));
  }

  return events;
}