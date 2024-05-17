import 'package:flutter/material.dart';
import 'package:flutter_movie/models/event/event.dart';
import 'package:intl/intl.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({Key? key, required this.event}) : super(key: key);

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
              'Event ${event.id ?? ''}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            buildInfoRow(Icons.person, 'User ID: ${event.userId}'),
            buildInfoRow(Icons.local_movies, 'Cinema ID: ${event.cinemaId}'),
            buildInfoRow(Icons.event_seat, 'Place Number: ${event.place.number}'),
            buildInfoRow(Icons.email, 'Email: ${event.place.email ?? 'N/A'}'),
            const SizedBox(height: 10),
            buildInfoRow(Icons.calendar_today, 'Date: ${DateFormat('yyyy-MM-dd – kk:mm').format(event.date)}'),
            buildInfoRow(Icons.place, 'Place: ${event.place.number}'),
          ],
        ),
      ),
    );
  }

  Widget buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey),
        const SizedBox(width: 5),
        Flexible(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
