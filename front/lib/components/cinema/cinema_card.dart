import 'package:flutter/cupertino.dart';
import 'package:flutter_movie/components/circular_avatar.dart';
import 'package:flutter_movie/models/cinema/cinema.dart';
import 'package:flutter_movie/screens/cinema_details_screen.dart';
import 'package:flutter_movie/services/file_service.dart';

class CinemaCard extends StatefulWidget {
  final Cinema cinema;

  const CinemaCard({super.key, required this.cinema});

  @override
  CinemaCardState createState() => CinemaCardState();
}

class CinemaCardState extends State<CinemaCard> {
  late Future<String> image;
  FileService fileService = FileService();

  @override
  void initState() {
    super.initState();
    image = fileService.read(widget.cinema.image);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => CinemaDetailScreen(cinema: widget.cinema),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OwnCircularAvatar(image: image, radius: 70),
            const SizedBox(width: 30),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: 200, // Установите ширину контейнера
                  child: Text(
                    widget.cinema.name,
                    softWrap: true, // Включает автоматический перенос текста
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: 200, // Установите ширину контейнера
                  child: Text(
                    widget.cinema.address,
                    softWrap: true, // Включает автоматический перенос текста
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                Text(widget.cinema.phone),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
