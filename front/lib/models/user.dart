abstract class User{
  final String name;
  final int age;
  final String image;
  final String? dateOfBirth;

  User({required this.name, required this.age, required this.image, this.dateOfBirth});
}