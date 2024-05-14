import 'package:flutter/material.dart';
import 'package:flutter_movie/components/actor/actor_card.dart';
import 'package:flutter_movie/components/app_bar.dart';
import 'package:flutter_movie/components/cinema/cinema_main_info.dart';
import 'package:flutter_movie/components/cinema/cinema_overview.dart';
import 'package:flutter_movie/components/nav_bar.dart';
import 'package:flutter_movie/components/video_player.dart';
import 'package:flutter_movie/models/actors.dart';
import 'package:flutter_movie/services/actor_service.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Future<List<Actor>> _actors;
  final ActorService _actorService = ActorService();

  @override
  void initState() {
    super.initState();
    _actors = _actorService.getActors();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      drawer: const NavBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const OwnAppBar(),
            SizedBox(
              width: width,
              height: height * 0.3,
              child: const VideoApp(),
            ),
            const SizedBox(height: 20),
            const CinemaMainInfo(),
            const CinemaOverview(),
            const SizedBox(height: 40),
            FutureBuilder<List<Actor>>(
              future: _actors,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: snapshot.data! 
                          .map((actor) => ActorCard(actor: actor))
                          .toList(),
                    ),
                  );
                } else {
                  return const Text('No actors found');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
