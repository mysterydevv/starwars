import 'dart:convert';

import 'package:flutter_movie/models/news.dart';
import 'package:flutter_movie/models/response.dart';
import 'package:http/http.dart' as http;

class NewsService {
  final String baseUrl = 'http://10.0.2.2:3000';
  Future<List<News>> getNews() async {
    var response = await http.get(Uri.parse('$baseUrl/news/all'));
    var responseBody = jsonDecode(response.body);
    var data = Response.fromJson(responseBody);
    if (data.status == 200) {
      List<News> news =
          (data.data as List).map((news) => News.fromJson(news)).toList();
      return news;
    }
    throw Exception(data.message);
  }

  Future<News> getNewsById(String id) async {
    var response = await http.get(Uri.parse('$baseUrl/news/$id'));
    var data = jsonDecode(response.body) as Response;
    if (data.status == 200) {
      return data.data as News;
    }
    throw Exception(data.message);
  }

  Future<void> addNews(News news) async {
    var response = await http.post(
      Uri.parse('$baseUrl/news/create'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(news.toJson()),
    );
    var responseBody = jsonDecode(response.body);
    var data = Response.fromJson(responseBody);
    if (data.status != 200) {
      throw Exception(data.message);
    }
  }

  Future<void> updateNews(News news) async {
    var response = await http.put(
      Uri.parse('$baseUrl/news/update/${news.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(news.toJson()),
    );
    var responseBody = jsonDecode(response.body);
    var data = Response.fromJson(responseBody);
    if (data.status != 200) {
      throw Exception(data.message);
    }
  }

  Future<void> deleteNews(String id) async {
    var response = await http.delete(Uri.parse('$baseUrl/news/delete/$id'));
    var responseBody = jsonDecode(response.body);
    var data = Response.fromJson(responseBody);
    if (data.status != 200) {
      throw Exception(data.message);
    }
  }
}
