import 'package:flutter/material.dart';
import 'package:flutter_movie/models/cinema/cinema.dart';
import 'package:flutter_movie/models/cinema/feedback.dart';
import 'package:flutter_movie/screens/cinema_details_screen.dart';
import 'package:flutter_movie/services/cinema_service.dart';

class FeedbackDialog extends StatefulWidget {
  final Cinema cinema;
  final String email;

  const FeedbackDialog({ super.key,required this.cinema, required this.email});

  @override
  State<FeedbackDialog> createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends State<FeedbackDialog> {
  TextEditingController textController = TextEditingController();
  CinemaService cinemaService = CinemaService();
  int countOfStar = 5; 

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Feedback'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: textController,
              decoration: const InputDecoration(
                labelText: 'Text',
              ),
            ),
            DropdownButton<int>(
              value: countOfStar,
              onChanged: (int? newValue) {
                setState(() {
                  countOfStar = newValue!;
                });
              },
              items: List<DropdownMenuItem<int>>.generate(
                5,
                (int index) => DropdownMenuItem<int>(
                  value: index + 1,
                  child: Text('${index + 1} Star${index == 0 ? '' : 's'}'),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Submit'),
          onPressed: () async {
            final String email = widget.email;
            final String text = textController.text;
            final String cinemaId = widget.cinema.id;
            final int stars = countOfStar;

            final feedback = FeedBack(email, stars, text);
            await cinemaService.addFeedBack(feedback, cinemaId);  
            widget.cinema.feedbacks.add(feedback);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CinemaDetailScreen(cinema: widget.cinema),
              ),
            );
          },
        ),
      ],
    );
  }
}
