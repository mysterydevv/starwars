// (title, content, author, date, image)

class News {
  late String? id;
  late String? title;
  late String? content;
  late String? author;
  late String? date;
  late String? image;

  News({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.date,
    required this.image,
  });

  static News fromJson(news) {
    return News(
      id: news['id'],
      title: news['title'],
      author: news['author'],
      image: news['image'],
      date: news['date'],
      content: news['content'],
    );
  }

  Object? toJson() {
    return {
      'title': title,
      'author': author,
      'date': date,
      'image': image,
      'content': content,
    };
  }
}
