import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:odc_flutter_features/controllers/calendar_controller.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/calendar_event_model.dart';

class CalendarPage extends StatefulWidget {
  String title;

  CalendarPage({required this.title});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final ValueNotifier<List<Event>> _selectedEvents = ValueNotifier([]);
  DateTime? _selectedDay;

  // Using a `LinkedHashSet` is recommended due to equality comparison override
  /*final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );*/

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDay = _focusedDay;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CalendarController>().loadEventData();
    });
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(BuildContext context, DateTime day) {
    return context.read<CalendarController>().kEvents[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedEvents.value = _getEventsForDay(context, selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            calendrierVue(context),
            SizedBox(
              height: 10,
            ),
            eventsVue(context)
          ],
        ),
      ),
    );
  }

  calendrierVue(BuildContext context) {
    var controller = context.watch<CalendarController>();
    return TableCalendar<Event>(
      firstDay: controller.kFirstDay,
      lastDay: controller.kLastDay,
      focusedDay: _focusedDay,
      calendarBuilders: CalendarBuilders(
        markerBuilder: (BuildContext context, date, events) {
          if (events.isEmpty) return SizedBox();
          return Stack(
            children: [
              Align(
                // alignment: Alignment.bottomLeft,
                child: CircleAvatar(
                  backgroundColor: Colors.deepOrangeAccent.withOpacity(.7),
                  // maxRadius: 10,
                  child: Text(
                    '${date.day}',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: CircleAvatar(
                  backgroundColor: Colors.grey.withOpacity(1),
                  maxRadius: 10,
                  child: Text(
                    '${events.length}',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          );
        },
        dowBuilder: (context, day) {
          if (day.weekday == DateTime.sunday ||
              day.weekday == DateTime.saturday) {
            final text = DateFormat.E().format(day);

            return Center(
              child: Text(
                text,
                style: TextStyle(color: Colors.red),
              ),
            );
          }
        },
      ),
      calendarFormat: _calendarFormat,
      eventLoader: (DateTime d) => _getEventsForDay(context, d),
      startingDayOfWeek: StartingDayOfWeek.monday,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onDaySelected: _onDaySelected,
      onFormatChanged: (format) {
        if (_calendarFormat != format) {
          setState(() {
            _calendarFormat = format;
          });
        }
      },
      onPageChanged: (focusedDay) {
        print("page changing ${focusedDay.toIso8601String()}");
        _focusedDay = focusedDay;
        context.read<CalendarController>().loadEventData(focusedDay.month);
      },
    );
  }

  eventsVue(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder<List<Event>>(
        valueListenable: _selectedEvents,
        builder: (context, value, _) {
          return ListView.separated(
            separatorBuilder: (_, i) => Divider(
              thickness: 1,
            ),
            itemCount: value.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 2.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  //border: Border.all(),
                  borderRadius: BorderRadius.circular(1.0),
                ),
                child: ListTile(
                  minVerticalPadding: 2,
                  leading: Icon(Icons.cake),
                  onTap: () => print('${value[index]}'),
                  title: Text('${value[index]}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
