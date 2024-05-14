import 'package:flutter/material.dart';
import 'package:flutter_movie/components/actor/actor_card.dart';
import 'package:flutter_movie/components/actor/actor_create_form.dart';
import 'package:flutter_movie/components/app_bar.dart';
import 'package:flutter_movie/components/nav_bar.dart';
import 'package:flutter_movie/models/actors.dart';
import 'package:flutter_movie/services/actor_service.dart';

class ActorScreen extends StatelessWidget {
  const ActorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ActorScreenHome(),
    );
  }
}

class ActorScreenHome extends StatefulWidget {
  const ActorScreenHome({super.key});

  @override
  ActorScreenHomeState createState() => ActorScreenHomeState();
}

class ActorScreenHomeState extends State<ActorScreenHome> {
  late Future<List<Actor>> actors;
  ActorService actorService = ActorService();

  @override
  void initState() {
    super.initState();
    actors = actorService.getActors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      body: Column(
        children: [
          const OwnAppBar(),
          FutureBuilder<List<Actor>>(
            future: actors,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: snapshot.data!
                        .map(
                          (actor) => ActorCard(actor: actor),
                        )
                        .toList(),
                  ),
                );
              } else {
                return const Text('No stuff members found');
              }
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              showDialog(context: context, builder:(context) => const ActorForm());
            },
            child: const Text('Add actor'),
          ),
        ],
      ),
    );
  }
}
