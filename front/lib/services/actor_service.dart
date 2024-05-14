import 'dart:convert';

import 'package:flutter_movie/models/actors.dart';
import 'package:flutter_movie/models/response.dart';
import 'package:http/http.dart' as http;
class ActorService{
  final String baseUrl = 'http://10.0.2.2:3000';
  Future<List<Actor>> getActors() async {
    var response = await http.get(Uri.parse('$baseUrl/actor/all'));
    var responseBody = jsonDecode(response.body);
    var data = Response.fromJson(responseBody);
    if(data.status == 200){
      List<Actor> actors = (data.data as List).map((actor) => Actor.fromJson(actor)).toList();
      return actors;
    }
    throw Exception(data.message);
  }

  Future<Actor> getActorById(String id) async {
    var response = await http.get(Uri.parse('$baseUrl/actor/$id'));
    var data = jsonDecode(response.body) as Response;
    if(data.status == 200){
      return data.data as Actor;
    }
    throw Exception(data.message);
  }


  Future<void> addActor(Actor actor) async {
    var response = await http.post(
      Uri.parse('$baseUrl/actor/create'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(actor.toJson()),
    );
    var responseBody = jsonDecode(response.body);
    var data = Response.fromJson(responseBody);
    if(data.status != 200){
      throw Exception(data.message);
    }
  }

  Future<void> updateActor(Actor actor) async {
    var response = await http.put(
      Uri.parse('$baseUrl/actor/update/${actor.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(actor.toJson()),
    );
    var responseBody = jsonDecode(response.body);
    var data = Response.fromJson(responseBody);
    if(data.status != 200){
      throw Exception(data.message);
    }
  }

  Future<void> deleteActor(String id) async {
    var response = await http.delete(Uri.parse('$baseUrl/actor/delete/$id'));
    var responseBody = jsonDecode(response.body);
    var data = Response.fromJson(responseBody);
    if(data.status != 200){
      throw Exception(data.message);
    }
  }
} 