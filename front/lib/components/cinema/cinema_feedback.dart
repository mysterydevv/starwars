import 'package:flutter/material.dart';
import 'package:flutter_movie/main.dart';
import 'package:flutter_movie/models/cinema/feedback.dart';
import 'package:flutter_movie/services/cinema_service.dart';
import 'package:flutter_movie/utils/helpers.dart';

class FeedBackCard extends StatelessWidget {
  final FeedBack feedback;
  final String cinemaId;
  CinemaService cinemaService = CinemaService();

  FeedBackCard({super.key, required this.feedback, required this.cinemaId});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  feedback.email,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                Row(
                  children: List.generate(feedback.countOfStar, (index) {
                    return const Icon(
                      Icons.star,
                      color: Colors.amber,
                    );
                  }),
                ),
                IconButton(
                    onPressed: () {
                      cinemaService
                          .deleteFeedBack(cinemaId, feedback)
                          .then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) =>const MyApp())))
                          .catchError((onError) => Helper.showErrorDialog(
                              context, onError.toString()));
                    },
                    icon: const Icon(Icons.delete))
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              feedback.text,
              style: const TextStyle(fontSize: 14.0),
            ),
          ],
        ),
      ),
    );
  }
}

class CinemaDetailsScreen {}
