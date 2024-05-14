import 'package:flutter_movie/models/user.dart';

class Actor extends User{
  late String? id;
  late String role;
  late List<dynamic> movies; 
  late List<dynamic> awards;
  late String biography;

  Actor({
    required this.id,
    required super.name,
    required super.age,
    required super.image,
    required this.role,
    required this.movies,
    required this.awards,
    required this.biography,
  });

  static Actor fromJson(actor) {
    return Actor(
      id: actor['id'],
      name: actor['name'],
      age: actor['age'],
      image: actor['image'],
      role: actor['role'],
      movies: actor['movies'] ,
      awards: actor['awards'] ,
      biography: actor['biography'], 
    );
  }

  Object? toJson() {
    return {
      'name': name,
      'age': age,
      'image': image,
      'role': role,
      'movies': movies,
      'awards': awards,
      'biography': biography,
    };
  }
}