import 'package:flutter/material.dart';
import 'package:flutter_movie/components/circular_avatar.dart';
import 'package:flutter_movie/models/news.dart';
import 'package:flutter_movie/screens/news_detail_screen.dart';
import 'package:flutter_movie/services/file_service.dart';

class NewsCard extends StatefulWidget {
  final News news;

  const NewsCard({super.key, required this.news});
  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  late Future<String> image;
  FileService fileService = FileService();

  _NewsCardState();

  @override
  void initState() {
    super.initState();
    image = fileService.read(widget.news.image);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NewsDetailScreen(news: widget.news)));
        },
        child: Column(
          children: [
            OwnCircularAvatar(image: image),
            const SizedBox(height: 10),
            const Text(
              'News',
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 5),
            const Text(
              'widget.news.title',
              softWrap: true,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto'),
            ),
            const SizedBox(height: 5),
            Text(
              'Content: ${widget.news.content}',
              style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
