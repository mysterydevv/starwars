import 'package:flutter/material.dart';

class CinemaHours extends StatelessWidget {
  final Map<String, String> workingHours = {
    'Понедельник': '10:00 - 22:00',
    'Вторник': '10:00 - 22:00',
    'Среда': '10:00 - 22:00',
    'Четверг': '10:00 - 22:00',
    'Пятница': '10:00 - 23:00',
    'Суббота': '10:00 - 23:00',
    'Воскресенье': '10:00 - 22:00',
  };

  CinemaHours({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: workingHours.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    entry.key,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    entry.value,
                    style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      );
  }
}