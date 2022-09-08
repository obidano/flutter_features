import 'dart:collection';
import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/calendar_event_model.dart';
import '../utils/get_hash_code.dart';

class CalendarController with ChangeNotifier {
  final kToday = DateTime.now();
  late DateTime kFirstDay;

  late DateTime kLastDay;

  Map<DateTime, List<Event>> calendrier = {};

  //pour test=> clé: exemple 2020-01
  Map<String, List<Event>> monthlyEvents = {};

  LinkedHashMap<DateTime, List<Event>> kEvents =
      LinkedHashMap<DateTime, List<Event>>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  // constructeur
  CalendarController() {
    kFirstDay = DateTime(kToday.year, kToday.month - 12, kToday.day);
    kLastDay = DateTime(kToday.year, kToday.month + 12, kToday.day);
  }

  // fonction pour test uniquement
  loadEventData([int? month = null]) {
    var final_month = month ?? DateTime.now().month;
    String monthKey = "${kToday.year}-${final_month}";

    // verifier si un mois n'a pas deja été chargée
    if (monthlyEvents.containsKey(monthKey)) {
      return;
    }
    int i = 0;
    // generer les dates
    List<Event> allMonthlyEvents = [];
    while (i < 10) {
      var date =
          DateTime.utc(kToday.year, final_month, Random().nextInt(28) + 1);
      List<Event> eventsByDate = [];
      var nombreEvents = Random().nextInt(5) + 1;
      int j = 0;
      // generer les events par date
      while (j < nombreEvents) {
        String nomPerson = Faker().person.name();
        Event event = Event("Anniversaire $nomPerson");
        eventsByDate.add(event);
        j++;
      }
      calendrier[date] = eventsByDate;
      allMonthlyEvents.addAll(eventsByDate);
      i++;
    }
    monthlyEvents[monthKey] = allMonthlyEvents;
    kEvents.addAll(calendrier);
    notifyListeners();
  }
}
