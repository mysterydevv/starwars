import 'package:flutter/material.dart';

class CinemaHours extends StatelessWidget {
  final Map<String, String> workingHours = {
    'Monday': '10:00 - 22:00',
    'Tuesday': '10:00 - 22:00',
    'Wednesday': '10:00 - 22:00',
    'Thursday': '10:00 - 22:00',
    'Friday': '10:00 - 23:00',
    'Saturday': '10:00 - 23:00',
    'Sunday': '10:00 - 22:00',
  };

  final Map<String, String> dayAbbreviations = {
    'Monday': 'Mn',
    'Tuesday': 'Tu',
    'Wednesday': 'Wd',
    'Thursday': 'Th',
    'Friday': 'Fr',
    'Saturday': 'Sa',
    'Sunday': 'Su',
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
                _buildDayIcon(dayAbbreviations[entry.key]!),
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

  Widget _buildDayIcon(String abbreviation) {
    return Container(
      width: 32.0,
      height: 32.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black, width: 2.0),
      ),
      child: Center(
        child: Text(
          abbreviation,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
