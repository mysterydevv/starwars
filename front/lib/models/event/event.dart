import 'package:flutter_movie/models/cinema/place.dart';

class Event {
  final String? id;
  final String userId;
  final String cinemaId;
  final Place place;
  final DateTime date;

  Event(this.id, this.userId, this.cinemaId, this.place, this.date);


  static Event fromJson(event) {
    return Event(
      event['id'],
      event['userId'],
      event['cinemaId'],
      Place.fromJson(event['place']),
      DateTime.parse(event['dateTime']),
    );
  }

  Object? toJson() {
    return {
      'userId': userId,
      'cinemaId': cinemaId,
      'place': place.toJson(),
      'dateTime': date.toIso8601String(),
    };
  }
}
