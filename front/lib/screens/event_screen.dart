import 'package:flutter/material.dart';
import 'package:flutter_movie/components/app_bar.dart';
import 'package:flutter_movie/components/cinema/cinema_hours.dart';
import 'package:flutter_movie/components/cinema/place_card.dart';
import 'package:flutter_movie/components/nav_bar.dart';
import 'package:flutter_movie/models/cinema/cinema.dart';
import 'package:flutter_movie/models/user_account.dart';
import 'package:flutter_movie/services/account_service.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key, required this.cinema});
  final Cinema cinema;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EventScreenHome(cinema: cinema),
    );
  }
}

class EventScreenHome extends StatefulWidget {
  final Cinema cinema;
  const EventScreenHome({super.key, required this.cinema});

  @override
  State<StatefulWidget> createState() {
    return EventScreenHomeState();
  }
}

class EventScreenHomeState extends State<EventScreenHome> {

  late UserAccount user;
  AccountService accountService = AccountService();

  @override
  void initState() {
    super.initState();
    accountService.getAccount().then((value) {
      setState(() {
        user = value;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      body: Column(
        children: [
          const OwnAppBar(),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: const Text(
                    'Choose a place:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: widget.cinema.places.map((place) {
                    return PlaceCard(place: place, cinemaId: widget.cinema.id);
                  }).toList(),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                   Column(
                      children: [
                        const Text(
                          'Free',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                   ),
                    const SizedBox(width: 20),
                    Column(
                      children: [
                        const Text(
                          'Ordered',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Cinema hours:',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          CinemaHours()
        ],
      ),
    );
  }
}
