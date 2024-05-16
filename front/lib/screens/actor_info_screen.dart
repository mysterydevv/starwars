import 'package:flutter/material.dart';
import 'package:flutter_movie/components/actor/actor_update_form.dart';
import 'package:flutter_movie/components/app_bar.dart';
import 'package:flutter_movie/components/circular_avatar.dart';
import 'package:flutter_movie/components/nav_bar.dart';
import 'package:flutter_movie/models/actors.dart';
import 'package:flutter_movie/screens/cast_screen.dart';
import 'package:flutter_movie/services/actor_service.dart';
import 'package:flutter_movie/services/file_service.dart';

class ActorDetailScreen extends StatelessWidget {
  const ActorDetailScreen({super.key, required this.actor});
  final Actor actor;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ActorDetailScreenHome(actor: actor),
    );
  }
}

class ActorDetailScreenHome extends StatefulWidget {
  const ActorDetailScreenHome({super.key, required this.actor});
  final Actor actor;

  @override
  State<StatefulWidget> createState() {
    return ActorDetailScreenHomeState();
  }
}

class ActorDetailScreenHomeState extends State<ActorDetailScreenHome> {
  late Future<String> image;
  FileService fileService = FileService();
  ActorService actorService = ActorService();

  @override
  void initState() {
    super.initState();
    image = fileService.read(widget.actor.image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const OwnAppBar(),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OwnCircularAvatar(image: image),
                      IconButton(
                          onPressed: () {
                            showDialog(context: context, builder: (context) => UpdateActorDialog(actor: widget.actor));
                          }, icon: const Icon(Icons.edit)),
                      IconButton(
                          onPressed: () async {
                            await actorService.deleteActor(widget.actor.id!);
                            // ignore: use_build_context_synchronously
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => const ActorScreen()));
                          },
                          icon: const Icon(Icons.delete)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Актер',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.actor.name,
                    softWrap: true,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Роль: ${widget.actor.role}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Возраст: ${widget.actor.age}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Фильмы:',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 5),
                  widget.actor.movies.isNotEmpty
                      ? Center(
                          child: Column(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: widget.actor.movies.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(
                                      widget.actor.movies[index],
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        )
                      : const Text('Нет информации'),
                  const SizedBox(height: 20),
                  const Text(
                    'Награды:',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 5),
                  widget.actor.awards.isNotEmpty
                      ? Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: widget.actor.awards.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(
                                      widget.actor.awards[index],
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        )
                      : const Text('Нет информации'),
                  const SizedBox(height: 5),
                  const Text(
                    'Биография:',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.actor.biography,
                    style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
