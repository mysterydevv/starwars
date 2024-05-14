import 'package:flutter_movie/models/cinema/feedback.dart';
import 'package:flutter_movie/models/cinema/place.dart';

class Cinema {
  final String id;
  final String name;
  final String address;
  final String phone;
  final String image;
  final List<FeedBack> feedbacks;
  final List<Place> places;

  Cinema( this.id, this.name, this.address, this.phone, this.image, this.feedbacks, this.places);

  static Cinema fromJson(cinema) {
    return Cinema(
      cinema['id'],
      cinema['name'],
      cinema['address'],
      cinema['phone'],
      cinema['image'],
      (cinema['feedback'] as List).map((feedback) => FeedBack.fromJson(feedback)).toList(),
      (cinema['places'] as List).map((place) => Place.fromJson(place)).toList(),
    );
  }

  Object? toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'phone': phone,
      'image': image,
      'feedbacks': feedbacks.map((feedback) => feedback.toJson()).toList(),
      'places': places.map((place) => place.toJson()).toList(),
    };
  }
}
