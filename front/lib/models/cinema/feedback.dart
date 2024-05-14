class FeedBack {
  final String email;
  final int countOfStar;
  final String text;

  FeedBack(this.email, this.countOfStar, this.text);

  static FeedBack fromJson(feedback) {
    return FeedBack(
      feedback['email'],
      feedback['countOfStar'],
      feedback['text'],
    );
  }

  Object? toJson() {
    return {
      'email': email,
      'countOfStar': countOfStar,
      'text': text,
    };
  }
}