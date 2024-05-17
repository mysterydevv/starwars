import 'package:flutter/material.dart';
import 'package:flutter_movie/components/app_bar.dart';
import 'package:flutter_movie/components/cinema/cinema_feedback.dart';
import 'package:flutter_movie/components/cinema/cinema_hours.dart';
import 'package:flutter_movie/components/circular_avatar.dart';
import 'package:flutter_movie/components/feedback_add_form.dart';
import 'package:flutter_movie/components/nav_bar.dart';
import 'package:flutter_movie/models/cinema/cinema.dart';
import 'package:flutter_movie/models/user_account.dart';
import 'package:flutter_movie/screens/event_screen.dart';
import 'package:flutter_movie/services/account_service.dart';
import 'package:flutter_movie/services/file_service.dart';

class CinemaDetailScreen extends StatelessWidget {
  const CinemaDetailScreen({super.key, required this.cinema});
  final Cinema cinema;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CinemaDetailScreenHome(cinema: cinema),
    );
  }
}

class CinemaDetailScreenHome extends StatefulWidget {
  const CinemaDetailScreenHome({super.key, required this.cinema});
  final Cinema cinema;

  @override
  State<StatefulWidget> createState() {
    return CinemaDetailScreenHomeState();
  }
}

class CinemaDetailScreenHomeState extends State<CinemaDetailScreenHome> {
  late Future<String> image;
  FileService fileService = FileService();
  AccountService accountService = AccountService();
  late UserAccount userAccount;

  @override
  void initState() {
    super.initState();
    image = fileService.read(widget.cinema.image);
    accountService.getAccount().then((value) {
      setState(() {
        userAccount = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const OwnAppBar(),
            const SizedBox(height: 20),
            OwnCircularAvatar(image: image),
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    width: 200,
                    child: Text(
                      widget.cinema.name,
                      softWrap: true,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 70,
                        ),
                        const Icon(Icons.location_on),
                        const SizedBox(width: 20),
                        SizedBox(
                          width: 300,
                          child: Text(
                            widget.cinema.address,
                            softWrap: true,
                            style: const TextStyle(fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const SizedBox(
                        width: 70,
                      ),
                      const Icon(Icons.phone),
                      const SizedBox(width: 20),
                      Text(
                        widget.cinema.phone,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CinemaHours(),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EventScreen(cinema: widget.cinema),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                    ),
                    child: const Text(
                      'Buy ticket',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: widget.cinema.feedbacks
                        .map(
                          (feedback) => FeedBackCard(
                            feedback: feedback,
                            cinemaId: widget.cinema.id,
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => FeedbackDialog(
                    cinema: widget.cinema,
                    email: userAccount.email!,
                  ),
                );
              },
              child: const Text(
                'Add feedback',
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
