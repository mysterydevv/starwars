import 'package:flutter/material.dart';
import 'package:flutter_movie/screens/cinema_screen.dart';

class CinemaMainInfo extends StatelessWidget {
  static const String year = '2010';
  static const String duration = '2h 28m';
  static const String rating = '8.8/10';

  const CinemaMainInfo({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Icon(
                  Icons.calendar_month,
                  color: Color.fromARGB(255, 24, 24, 24),
                  size: 30,
                ),
                SizedBox(height: 10),
                Text(
                  year,
                  style: TextStyle(
                    color: Color.fromARGB(255, 24, 24, 24),
                    fontSize: 20,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Icon(
                  Icons.timer,
                  color: Color.fromARGB(255, 24, 24, 24),
                  size: 30,
                ),
                SizedBox(height: 10),
                Text(
                  duration,
                  style: TextStyle(
                    color: Color.fromARGB(255, 24, 24, 24),
                    fontSize: 20,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Icon(
                  Icons.star,
                  color: Color.fromARGB(255, 24, 24, 24),
                  size: 30,
                ),
                SizedBox(height: 10),
                Text(
                  rating,
                  style: TextStyle(
                    color: Color.fromARGB(255, 24, 24, 24),
                    fontSize: 20,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const CinemaScreen()));
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
          child: const Text(
            'Buy tickets',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Divider(
          color: Color.fromARGB(255, 24, 24, 24),
          thickness: 1,
        ),
      ],
    );
  }
}
