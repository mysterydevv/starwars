import 'package:flutter/material.dart';
import 'package:flutter_movie/components/actor/actor_card.dart';
import 'package:flutter_movie/components/actor/actor_create_form.dart';
import 'package:flutter_movie/components/app_bar.dart';
import 'package:flutter_movie/components/nav_bar.dart';
import 'package:flutter_movie/models/actors.dart';
import 'package:flutter_movie/services/actor_service.dart';

class ActorScreen extends StatelessWidget {
  const ActorScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ActorScreenHome(),
    );
  }
}

class ActorScreenHome extends StatefulWidget {
  const ActorScreenHome({Key? key});

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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const OwnAppBar(),
            const SizedBox(height: 10),
            const Text(
              'Cast',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            FutureBuilder<List<Actor>>(
              future: actors,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return Column(
                    children: [
                      for (var i = 0; i < snapshot.data!.length; i += 2)
                        Row(
                          children: [
                            Expanded(
                              child: ActorCard(actor: snapshot.data![i]),
                            ),
                            if (i + 1 < snapshot.data!.length)
                              Expanded(
                                child: ActorCard(actor: snapshot.data![i + 1]),
                              ),
                          ],
                        ),
                    ],
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
      ),
    );
  }
}
