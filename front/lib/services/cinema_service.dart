import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_movie/models/cinema/cinema.dart';
import 'package:flutter_movie/models/cinema/feedback.dart';
import 'package:flutter_movie/models/cinema/place.dart';
import 'package:flutter_movie/models/response.dart';
import 'package:http/http.dart' as http;

class CinemaService {
  static const baseUrl = "http://10.0.2.2:3000";

  Future<List<Cinema>> getCinemas() async {
    final response = await http.get(Uri.parse('$baseUrl/cinema/all'));
    final responseBody = jsonDecode(response.body);
    final data = Response.fromJson(responseBody);
    if (data.status == 200) {
      List<Cinema> actors =
          (data.data as List).map((cinema) => Cinema.fromJson(cinema)).toList();
      return actors;
    }
    throw Exception(data.message);
  }


  Future<void> updatePlace(Place place, String cinemaId) async {
    Uri.parse('$baseUrl/cinema/updatePlace');
    var response = await http.post(
            Uri.parse('$baseUrl/cinema/updatePlace'),
            body: jsonEncode({'id': cinemaId, 'place': place.toJson()}),
            headers: {'Content-Type': 'application/json'},
        );
    var responseBody = jsonDecode(response.body);
    var data = Response.fromJson(responseBody);
    if (data.status != 200) {
      throw Exception(data.message);
    }
  }

  Future<void> addFeedBack(FeedBack feedBack,String cinemaId) async{
    var response = await http.post(
        Uri.parse('$baseUrl/cinema/addFeedBack'),
        body: jsonEncode({'id': cinemaId, 'email': feedBack.email, 'countOfStar': feedBack.countOfStar, 'text': feedBack.text}),
        headers: {'Content-Type': 'application/json'},
    );
    var responseBody = jsonDecode(response.body);
    var data = Response.fromJson(responseBody);
    if (data.status != 200) {
      throw Exception(data.message);
    }
  }

  Future<void> deleteFeedBack(String cinemaId, FeedBack feedBack) async{
    var response = await http.post(
        Uri.parse('$baseUrl/cinema/removeFeedBack'),
        body: jsonEncode({'id': cinemaId, 'email': feedBack.email, 'countOfStar': feedBack.countOfStar, 'text': feedBack.text}),
        headers: {'Content-Type': 'application/json'},
    );
    var responseBody = jsonDecode(response.body);
    var data = Response.fromJson(responseBody);
    if (data.status != 200) {
      throw Exception(data.message);
    }
  }
}
