

import 'package:flutter/material.dart';


String getFormattedWeekday() {
  DateTime now = DateTime.now();
  String weekday = _getWeekday(now.weekday);
  return weekday;
}


String _getWeekday(int weekday) {
  switch (weekday) {
    case DateTime.monday:
      return 'lunes';
    case DateTime.tuesday:
      return 'martes';
    case DateTime.wednesday:
      return 'miércoles';
    case DateTime.thursday:
      return 'jueves';
    case DateTime.friday:
      return 'viernes';
    case DateTime.saturday:
      return 'sábado';
    case DateTime.sunday:
      return 'domingo';
    default:
      return '';
  }
}


String getFormattedTime() {
  DateTime now = DateTime.now();
  String hour = '${now.hour}:${now.minute.toString().padLeft(2, '0')}';
  return hour;
}
