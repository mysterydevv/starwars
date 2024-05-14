import 'package:flutter/material.dart';
import 'package:flutter_movie/components/app_bar.dart';
import 'package:flutter_movie/components/cinema/cinema_card.dart';
import 'package:flutter_movie/components/nav_bar.dart';
import 'package:flutter_movie/models/cinema/cinema.dart';
import 'package:flutter_movie/services/cinema_service.dart';

class CinemaScreen extends StatelessWidget {
  const CinemaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CinemaScreenHome(),
    );
  }
}

class CinemaScreenHome extends StatefulWidget {
  const CinemaScreenHome({super.key});

  @override
  CinemaScreenHomeState createState() => CinemaScreenHomeState();
}

class CinemaScreenHomeState extends State<CinemaScreenHome> {
  late Future<List<Cinema>> cinemas;
  CinemaService cinemaService = CinemaService();

  @override
  void initState() {
    super.initState();
    cinemas = cinemaService.getCinemas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      body: Column(
        children: [
          const OwnAppBar(),
          FutureBuilder<List<Cinema>>(
            future: cinemas,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: snapshot.data!
                        .map(
                          (cinema) => CinemaCard(cinema: cinema),
                        )
                        .toList(),
                  ),
                );
              } else {
                return const Text('Something went wrong');
              }
            },
          ),
        ],
      ),
    );
  }
}
