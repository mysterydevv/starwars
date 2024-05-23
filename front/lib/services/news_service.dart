import 'dart:convert';
import 'package:http/http.dart' as http;
import 'database_helper.dart';
import '../models/news.dart';
import '../models/response.dart';

class NewsService {
  final String baseUrl = 'http://10.0.2.2:3000';
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<List<News>> getNews() async {
    try {
      var response = await http.get(Uri.parse('$baseUrl/news/all'));
      var responseBody = jsonDecode(response.body);
      var data = Response.fromJson(responseBody);

      if (data.status == 200) {
        List<News> newsList = (data.data as List)
            .map((news) => News.fromJson(news))
            .toList();

        // Save fetched news to local database
        await _dbHelper.deleteAllNews();
        await _dbHelper.insertNews(newsList);

        return newsList;
      } else {
        throw Exception(data.message);
      }
    } catch (e) {
      // If there's an error fetching from the server, retrieve from local database
      print('Failed to fetch news from server: $e');
      return await _dbHelper.getNews();
    }
  }

  Future<News> getNewsById(String id) async {
    try {
      var response = await http.get(Uri.parse('$baseUrl/news/$id'));
      var responseBody = jsonDecode(response.body);
      var data = Response.fromJson(responseBody);

      if (data.status == 200) {
        return News.fromJson(data.data);
      } else {
        throw Exception(data.message);
      }
    } catch (e) {
      // Handle error and possibly fetch from local database if needed
      throw Exception('Failed to fetch news by id: $e');
    }
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
