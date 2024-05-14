class Place {
  late String? email;
  late bool isOrdered;
  late int number;

  Place(this.email, this.isOrdered, this.number);

  static Place fromJson(place) {
    return Place(
      place['email'] ?? '',
      place['isOrdered'],
      place['number'],
    );
  }

  Object? toJson() {
    return {
      'email': email,
      'isOrdered': isOrdered,
      'number': number,
    };
  } 
}