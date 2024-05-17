import 'package:flutter/material.dart';
import 'package:flutter_movie/components/circular_avatar.dart';
import 'package:flutter_movie/models/actors.dart';
import 'package:flutter_movie/screens/actor_info_screen.dart';
import 'package:flutter_movie/services/file_service.dart';


class ActorCard extends StatefulWidget{

  final Actor actor;

  const ActorCard({super.key, required this.actor});
  @override
  State<ActorCard> createState() => _ActorCardState();
}


class _ActorCardState extends State<ActorCard> {


  late Future<String> image;
  FileService fileService = FileService();

  _ActorCardState();


  @override
  void initState() {
    super.initState();
    image = fileService.read(widget.actor.image);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ActorDetailScreen(actor: widget.actor)));
        },
        child: Column(
          children: [
            OwnCircularAvatar(image: image),
            const SizedBox(height: 10),
            const Text(
              'Actor',
              style: TextStyle(fontSize: 16, fontFamily: 'Roboto', fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 5),
            Text(
              widget.actor.name,
              softWrap: true,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
            ),
            const SizedBox(height: 5),
            Text(
              'Роль: ${widget.actor.role}',
              style: const TextStyle(fontSize: 16, fontFamily: 'Roboto', fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
