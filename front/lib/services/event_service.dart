import 'dart:convert';
import 'package:flutter_movie/models/event/event.dart';
import 'package:flutter_movie/models/response.dart';
import 'package:http/http.dart' as http;

class EventService{
  final String baseUrl = 'http://10.0.2.2:3000';

  Future<List<Event>> getEvents(String userId) async {
    try {
      Uri uri = Uri.parse('$baseUrl/event/all/$userId');
      var response = await http.get(uri);

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        var data = Response.fromJson(responseBody);
        List<Event> events = [];
        for (var event in data.data) {
          events.add(Event.fromJson(event));
        }
        return events;
      } else {
        throw Exception('Failed to load events');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> addEvent(Event event) async {
    try {
      Uri uri = Uri.parse('$baseUrl/event/create');
      var response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(event.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to add event');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}