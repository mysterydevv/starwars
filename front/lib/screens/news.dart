import 'package:flutter/material.dart';
import 'package:flutter_movie/components/app_bar.dart';
import 'package:flutter_movie/components/nav_bar.dart';
import 'package:flutter_movie/components/news/news_card.dart';
import 'package:flutter_movie/components/news/news_form.dart';
import 'package:flutter_movie/models/news.dart';
import 'package:flutter_movie/services/news_service.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NewsScreenHome(),
    );
  }
}

class NewsScreenHome extends StatefulWidget {
  const NewsScreenHome({super.key});

  @override
  NewsScreenHomeState createState() => NewsScreenHomeState();
}

class NewsScreenHomeState extends State<NewsScreenHome> {
  late Future<List<News>> news;
  NewsService newsService = NewsService();

  @override
  void initState() {
    super.initState();
    news = newsService.getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      body: Column(
        children: [
          const OwnAppBar(),
          FutureBuilder<List<News>>(
            future: news,
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
                          (news) => NewsCard(news: news),
                        )
                        .toList(),
                  ),
                );
              } else {
                return const Text('No News found');
              }
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              showDialog(
                  context: context, builder: (context) => const NewsForm());
            },
            child: const Text('Add news'),
          ),
        ],
      ),
    );
  }
}
