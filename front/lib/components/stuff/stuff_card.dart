import 'package:flutter/material.dart';
import 'package:flutter_movie/components/circular_avatar.dart';
import 'package:flutter_movie/models/stuff.dart';
import 'package:flutter_movie/screens/stuff_details_screen.dart';
import 'package:flutter_movie/services/file_service.dart';
import 'package:flutter_movie/services/stuff_service.dart';

class StuffCard extends StatefulWidget {
  final Stuff stuff;

  const StuffCard({super.key, required this.stuff});
  @override
  State<StatefulWidget> createState() {
    return _StuffCardState();
  }
}

class _StuffCardState extends State<StuffCard> {
  late Future<String> image;
  FileService fileService = FileService();
  StuffService stuffService = StuffService();

  @override
  void initState() {
    super.initState();
    image = fileService.read(widget.stuff.image);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StuffDetailsScreen(stuff: widget.stuff),
          ),
        );
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.all(10.0),
        width: width * 0.9,
        height: height * 0.2,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(60, 187, 185, 185),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        StuffDetailsScreen(stuff: widget.stuff),
                  ),
                );
              },
              child: OwnCircularAvatar(image: image),
            ),
            const SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.stuff.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.stuff.activity,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
