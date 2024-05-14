import 'dart:convert';

import 'package:flutter_movie/models/stuff.dart';
import 'package:flutter_movie/models/response.dart';
import 'package:http/http.dart' as http;

class StuffService {
  final String baseUrl = 'http://10.0.2.2:3000';
  Future<List<Stuff>> getAllMembersOfStuff() async {
    var response = await http.get(Uri.parse('$baseUrl/stuff/all'));
    var responseBody = jsonDecode(response.body);
    var data = Response.fromJson(responseBody);
    if (data.status == 200) {
      List<Stuff> stuff = (data.data as List).map((stuff) => Stuff.fromJson(stuff)).toList();
      return stuff;
    }
    throw Exception(data.message);
  }

  Future<Stuff> getMemberOfStuff(String id) async {
    var response = await http.get(Uri.parse('$baseUrl/stuff/$id'));
    var responseBody = jsonDecode(response.body);
    var data = Response.fromJson(responseBody);
    if (data.status == 200) {
      return Stuff.fromJson(data.data);
    }
    throw Exception(data.message);
  }


  Future<String> addMemberOfStuff(Stuff stuff) async {
    var response = await http.post(
      Uri.parse('$baseUrl/stuff/create'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(stuff.toJson()),
    );
    var responseBody = jsonDecode(response.body);
    var data = Response.fromJson(responseBody);
    if (data.status == 200) {
      return data.data;
    }
    throw Exception(data.message);
  }

  Future<void> updateMemberOfStuff(Stuff stuff) async {
    var response = await http.put(
      Uri.parse('$baseUrl/stuff/update'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(stuff.toJson()),
    );
    var responseBody = jsonDecode(response.body);
    var data = Response.fromJson(responseBody);
    if (data.status != 200) {
      throw Exception(data.message); 
    }
  }


  Future<void> deleteMemberOfStuff(String id) async {
    var response = await http.delete(Uri.parse('$baseUrl/stuff/delete/$id'));
    var responseBody = jsonDecode(response.body);
    var data = Response.fromJson(responseBody);
    if (data.status != 200) {
      throw Exception(data.message);
    }
  }
}