import 'package:flutter/material.dart';
import 'package:flutter_movie/components/app_bar.dart';
import 'package:flutter_movie/components/circular_avatar.dart';
import 'package:flutter_movie/components/nav_bar.dart';
import 'package:flutter_movie/components/news/news_update_form.dart';
import 'package:flutter_movie/models/news.dart';
import 'package:flutter_movie/screens/news.dart';
import 'package:flutter_movie/services/file_service.dart';
import 'package:flutter_movie/services/news_service.dart';

class NewsDetailScreen extends StatelessWidget {
  const NewsDetailScreen({super.key, required this.news});
  final News news;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NewsDetailScreenHome(news: news),
    );
  }
}

class NewsDetailScreenHome extends StatefulWidget {
  const NewsDetailScreenHome({super.key, required this.news});
  final News news;

  @override
  State<StatefulWidget> createState() {
    return NewsDetailScreenHomeState();
  }
}

class NewsDetailScreenHomeState extends State<NewsDetailScreenHome> {
  late Future<String> image;
  FileService fileService = FileService();
  NewsService newsService = NewsService();

  @override
  void initState() {
    super.initState();
    image = fileService.read(widget.news.image!);
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
                            showDialog(
                                context: context,
                                builder: (context) =>
                                    UpdateNewsDialog(news: widget.news));
                          },
                          icon: const Icon(Icons.edit)),
                      IconButton(
                          onPressed: () async {
                            await newsService.deleteNews(widget.news.id!);
                            // ignore: use_build_context_synchronously
                            Navigator.push(
                                // ignore: use_build_context_synchronously
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const NewsScreen()));
                          },
                          icon: const Icon(Icons.delete)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'News',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${widget.news.title}',
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Content: ${widget.news.content}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Author: ${widget.news.author}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Date: ${widget.news.date}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
