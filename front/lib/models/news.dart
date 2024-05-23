class News {
  String? id;
  String? title;
  String? content;
  String? author;
  String? date;
  String? image;

  News({
    this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.date,
    required this.image,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      author: json['author'],
      date: json['date'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'author': author,
      'date': date,
      'image': image,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'author': author,
      'date': date,
      'image': image,
    };
  }

  factory News.fromMap(Map<String, dynamic> map) {
    return News(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      author: map['author'],
      date: map['date'],
      image: map['image'],
    );
  }
}
