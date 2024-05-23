import 'package:flutter/material.dart';
import 'package:flutter_movie/components/app_bar.dart';
import 'package:flutter_movie/components/nav_bar.dart';
import 'package:flutter_movie/components/news/news_card.dart';
import 'package:flutter_movie/components/news/news_form.dart';
import 'package:flutter_movie/models/news.dart';
import 'package:flutter_movie/services/news_service.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NewsScreenHome(),
    );
  }
}

class NewsScreenHome extends StatefulWidget {
  const NewsScreenHome({Key? key}) : super(key: key);

  @override
  NewsScreenHomeState createState() => NewsScreenHomeState();
}

class NewsScreenHomeState extends State<NewsScreenHome> {
  late Future<List<News>> news;
  final NewsService newsService = NewsService();

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    setState(() {
      news = newsService.getNews();
    });
  }

  Future<void> addNews(News newNews) async {
    try {
      await newsService.addNews(newNews);
      await fetchNews();
    } catch (e) {
      print('Failed to add news: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const OwnAppBar(),
            const SizedBox(height: 20),
            const Text(
              'News',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildNewsList(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final newNews = await showDialog<News>(
                  context: context,
                  builder: (context) => const NewsForm(),
                );
                if (newNews != null) {
                  await addNews(newNews);
                }
              },
              child: const Text('Add news'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsList() {
    return FutureBuilder<List<News>>(
      future: news,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return const Center(child: Text('No News found'));
          }
          return Column(
            children: snapshot.data!
                .map(
                  (news) => NewsCard(news: news),
            )
                .toList(),
          );
        } else {
          return const Center(child: Text('No News found'));
        }
      },
    );
  }
}
