import 'package:flutter/material.dart';
import 'package:flutter_movie/models/event/event.dart';
import 'package:intl/intl.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Событие ${event.id ?? ''}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.person, color: Colors.grey),
                const SizedBox(width: 5),
                Text('User ID: ${event.userId}'),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(Icons.local_movies, color: Colors.grey),
                const SizedBox(width: 5),
                Text('Cinema ID: ${event.cinemaId}'),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(Icons.event_seat, color: Colors.grey),
                const SizedBox(width: 5),
                Text('Place Number: ${event.place.number}'),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(Icons.email, color: Colors.grey),
                const SizedBox(width: 5),
                Text('Email: ${event.place.email ?? 'N/A'}'),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.calendar_today, color: Colors.grey),
                const SizedBox(width: 5),
                Text('Date: ${DateFormat('yyyy-MM-dd – kk:mm').format(event.date)}'),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.place, color: Colors.grey),
                const SizedBox(width: 5),
                Text('Place: ${event.place.number}'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
