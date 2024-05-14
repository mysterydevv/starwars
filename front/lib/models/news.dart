// (title, content, author, date, image)

class News {
  late String? id;
  late String? title;
  late String content;
  late String author;
  late String date;
  late String image;

  News({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.date,
    required this.image,
  });

  static News fromJson(actor) {
    return News(
      id: actor['id'],
      title: actor['name'],
      author: actor['age'],
      image: actor['image'],
      date: actor['role'],
      content: actor['movies'],
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
